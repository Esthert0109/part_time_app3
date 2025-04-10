import 'dart:convert';
import 'dart:io';

import 'package:part_time_app/Utils/apiUtils.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';

import '../../Constants/apiConstant.dart';
import '../../Constants/globalConstant.dart';
import '../../Model/Advertisement/advertisementModel.dart';
import '../../Model/Category/categoryModel.dart';
import '../../Model/Task/missionClass.dart';
import '../../Model/User/userModel.dart';
import '../../Model/notification/messageModel.dart';
import '../../Pages/Message/user/chatConfig.dart';
import '../WebSocket/webSocketService.dart';
import '../explore/categoryServices.dart';
import '../explore/exploreServices.dart';
import '../notification/systemMessageServices.dart';

class UserServices {
  String url = "";
  CategoryServices categoryServices = CategoryServices();
  SystemMessageServices messageServices = SystemMessageServices();
  ExploreService exploreServices = ExploreService();

  Future<LoginUserModel?> login(String phone, String password) async {
    url = port + loginUrl;
    LoginUserModel? loginUserModel;

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };

    final Map<String, dynamic> body = {
      'first_phone_no': phone,
      'password': password
    };

    try {
      final response = await postRequest(url, headers, body);
      int statusCode = response.statusCode;

      Map<String, dynamic> jsonData = json.decode(response.responseBody);
      int responseCode = jsonData['code'];
      String responseMsg = jsonData['msg'];
      loginUserModel = LoginUserModel(code: responseCode, msg: responseMsg);

      Map<String, dynamic>? data = jsonData['data'];
      LoginData responseData = LoginData.fromJson(data!);

      loginUserModel = LoginUserModel(
          code: responseCode, msg: responseMsg, data: responseData);

      if (statusCode == 200) {
        if (responseCode == 0) {
          if (data!.isNotEmpty && data != null) {
            await SharedPreferencesUtils.saveToken(loginUserModel.data!.token!);
            await SharedPreferencesUtils.savePhoneNo(phone);
            await SharedPreferencesUtils.savePassword(password);

            try {
              UserModel? userModel = await getUserInfo();

              isLoginTencent =
                  await userTencentLogin(userModel!.data!.customerId!);
              bool isChangeNicknameTencent = await setNickNameTencent(
                  userModel.data!.customerId!, userModel.data!.nickname!);
              bool isChangeAvatarTencent = await setAvatarTencent(
                  userModel.data!.customerId!, userModel.data!.avatar!);
              customerIDWebsocket = userModel.data!.customerId!;
              WebSocketService(customerIDWebsocket);
              initAndLoginIm();
              isLogin = true;

              CategoryModel? model = await categoryServices.getCategoryList();
              if (model!.data != null) {
                exploreCategoryList = model.data!;
              }

              NotificationTipsModel? tipsModel =
                  await messageServices.getNotificationTips();
              if (tipsModel!.data != null) {
                notificationTips = tipsModel!.data;
              }

              for (int i = 0; i < 5; i++) {
                NotificationListModel? notiModel =
                    await messageServices.getNotificationList(i, 1);
                if (notiModel!.data != null) {
                  switch (i) {
                    case 0:
                      systemMessageList = notiModel.data!;
                      await SharedPreferencesUtils.saveSystemMessageList(
                          systemMessageList);
                      break;
                    case 1:
                      missionMessageList = notiModel.data!;
                      await SharedPreferencesUtils.saveMissionMessageList(
                          missionMessageList);
                      break;
                    case 2:
                      paymentMessageList = notiModel.data!;
                      await SharedPreferencesUtils.savePaymentMessageList(
                          paymentMessageList);
                      break;
                    case 3:
                      publishMessageList = notiModel.data!;
                      await SharedPreferencesUtils.savePublishMessageList(
                          publishMessageList);
                      break;
                    case 4:
                      ticketingMessageList = notiModel.data!;
                      await SharedPreferencesUtils.saveTicketMessageList(
                          ticketingMessageList);
                      break;
                  }
                }
              }

              AdvertisementModel? advertisementModel =
                  await exploreServices.getAdvertisement();
              if (advertisementModel!.data != null) {
                advertisementList = advertisementModel.data!;

                print("check ads: ${advertisementList[0].advertisementImage}");
              }

              missionAvailable = await exploreServices.fetchExplore(1);
              print("check all mission: ${missionAvailable[0].nickname}");
              missionAvailableDesc =
                  await exploreServices.fetchExploreByPrice("Desc", 1);
              print("check all mission: ${missionAvailableDesc[0].avatar}");
              missionAvailableAsec =
                  await exploreServices.fetchExploreByPrice("Asc", 1);
              print(
                  "check all mission: ${missionAvailableAsec[0].taskContent}");

              // bool isLoginTencent = await userTencentLogin(data['customerId']);
              // print("login tencent");
            } catch (e) {
              print("get info after logined error: $e");
            }

            return loginUserModel;
          }
        } else {
          return loginUserModel;
        }
      }
    } catch (e) {
      print("Error in login: $e");
      return loginUserModel;
    }
    return null;
  }

  Future<UserModel?> registration(UserData userData) async {
    url = port + registrationUrl;

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    print("check data: ${userData.nickname}");

    final Map<String, dynamic> body = {
      "nickname": userData.nickname,
      "password": userData.password,
      "firstPhoneNo": userData.firstPhoneNo
    };

    try {
      final response = await postRequest(url, headers, body);
      int statusCode = response.statusCode;

      Map<String, dynamic> jsonData = json.decode(response.responseBody);
      int responseCode = jsonData['code'];
      String responseMsg = jsonData['msg'];
      Map<String, dynamic>? data = jsonData['data'];
      UserData responseData = UserData.fromJson(data!);

      if (statusCode == 200) {
        if (responseCode == 0) {
          if (data!.isNotEmpty && data != null) {
            UserModel userModel = UserModel(
                code: responseCode, msg: responseMsg, data: responseData);

            return userModel;
          }
        } else {
          UserModel userModel = UserModel(
              code: responseCode, msg: responseMsg, data: responseData);

          return userModel;
        }
      }
    } catch (e) {
      print("Error in registration: $e");
    }
    return null;
  }

  Future<CheckUserModel?> checkNameAndPhone(
      String phone, String nickname) async {
    url = port + checkUrl;
    CheckUserModel? checkModel;

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };

    final Map<String, dynamic> body = {
      "nickname": nickname,
      "firstPhoneNo": phone
    };

    try {
      final response = await postRequest(url, headers, body);
      int statusCode = response.statusCode;

      Map<String, dynamic> jsonData = json.decode(response.responseBody);
      int responseCode = jsonData['code'];
      String responseMsg = jsonData['msg'];
      String responseData = jsonData['data'];

      if (statusCode == 200) {
        if (responseCode == 0) {
          checkModel = CheckUserModel(
              code: responseCode, msg: responseMsg, data: responseData);
          return checkModel;
        }
        return checkModel;
      }
      return checkModel;
    } catch (e) {
      print("Error in check: $e");
    }
  }

  Future<OTPUserModel?> sendOTP(String phone, int type) async {
    url = port + sendOTPUrl + type.toString() + '/' + phone;
    OTPUserModel? otpModel;

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };

    try {
      final response = await getRequest(url, headers);
      int statusCode = response.statusCode;

      Map<String, dynamic> jsonData = json.decode(response.responseBody);
      int? responseCode = jsonData['code'];
      String? responseMsg = jsonData['msg'];
      Map<String, dynamic> data = jsonData['data'];
      OtpData? responseData = OtpData.fromJson(data);

      if (statusCode == 200) {
        if (responseCode == 0) {
          otpModel = OTPUserModel(
              code: responseCode, msg: responseMsg, data: responseData);

          return otpModel;
        } else {
          otpModel = OTPUserModel(
              code: responseCode, msg: responseMsg, data: responseData);

          return otpModel;
        }
      }
    } catch (e) {
      print("Error in send otp: $e");
    }
  }

  Future<CheckOTPModel?> verifyOTP(String phone, String code, int type) async {
    url = port + verifyOTPUrl + type.toString();
    CheckOTPModel? otpModel;

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };

    final Map<String, dynamic> body = {"mobile": phone, "code": code};

    try {
      final response = await postRequest(url, headers, body);
      int statusCode = response.statusCode;

      Map<String, dynamic> jsonData = json.decode(response.responseBody);
      int responseCode = jsonData['code'];
      String responseMsg = jsonData['msg'];
      bool? responseData = jsonData['data'];

      if (statusCode == 200) {
        if (responseCode == 0) {
          otpModel = CheckOTPModel(
              code: responseCode, msg: responseMsg, data: responseData);

          return otpModel;
        } else {
          otpModel = CheckOTPModel(
              code: responseCode, msg: responseMsg, data: responseData);

          return otpModel;
        }
      }
    } catch (e) {
      print("Error in check otp: $e");
    }
  }

  Future<CheckOTPModel?> updatePassword(String phone, String password) async {
    url = port + updateForgotPasswordUrl + phone;

    CheckOTPModel updatePasswordModel;

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };

    final Map<String, dynamic> body = {'password': password};

    try {
      final response = await patchRequest(url, headers, body);
      int statusCode = response.statusCode;

      Map<String, dynamic> jsonData = json.decode(response.responseBody);
      int responseCode = jsonData['code'];
      String responseMsg = jsonData['msg'];
      bool responseData = jsonData['data'];

      updatePasswordModel = CheckOTPModel(
          code: responseCode, msg: responseMsg, data: responseData);
      return updatePasswordModel;
    } catch (e) {
      print("Error in change password");
      return null;
    }
  }

  Future<UserModel?> getUserInfo() async {
    url = port + getUserInfoUrl;
    UserModel? userModel;

    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!
    };

    try {
      final response = await getRequest(url, headers);
      int statusCode = response.statusCode;

      Map<String, dynamic> jsonData = json.decode(response.responseBody);
      int responseCode = jsonData['code'];
      String responseMsg = jsonData['msg'];
      Map<String, dynamic>? data = jsonData['data'];
      UserData responseData = UserData.fromJson(data!);
      userModel =
          UserModel(code: responseCode, msg: responseMsg, data: responseData);

      await SharedPreferencesUtils.saveUserDataInfo(responseData);

      return userModel;
    } catch (e) {
      print("Error in get user info: $e");
      return userModel;
    }
  }

  Future<bool?> updateCollectionViewable() async {
    url = port + updateCollectionViewUrl;
    UpdateCollectionModel? updateCollectionModel;

    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!,
    };

    final Map<String, dynamic> body = {};

    try {
      final response = await patchRequest(url, headers, body);
      int statusCode = response.statusCode;

      Map<String, dynamic> jsonData = json.decode(response.responseBody);
      int responseCode = jsonData['code'];
      String responseMsg = jsonData['msg'];
      bool data = jsonData['data'];
      // UserData responseData = UserData.fromJson(data);

      if (statusCode == 200) {
        if (responseCode == 0) {
          return data;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print("Error in updateCollectionViewable: $e");
    }
    return null;
  }

  Future<CheckOTPModel?> updateUSDT(UserData userInfo) async {
    url = port + updateUserInfoUrl;
    CheckOTPModel? updateModel;
    String? token = await SharedPreferencesUtils.getToken();
    String? phone = await SharedPreferencesUtils.getPhoneNo();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!
    };

    final Map<String, dynamic> body = {
      'billingNetwork': userInfo.billingNetwork,
      'billingAddress': userInfo.billingAddress,
      'billingCurrency': 'USDT',
      'firstPhoneNo': phone
    };

    try {
      final response = await patchRequest(url, headers, body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.responseBody);
        int responseCode = jsonData['code'];
        String responseMsg = jsonData['msg'];
        if (responseCode == 0) {
          bool responseData = jsonData['data'];
          updateModel = CheckOTPModel(
              code: responseCode, msg: responseMsg, data: responseData);

          getUserInfo();

          return updateModel;
        }

        updateModel =
            CheckOTPModel(code: responseCode, msg: responseMsg, data: false);
        return updateModel;
      }
    } catch (e) {
      print("Error in update USDT: $e");
    }
  }

  Future<UserData?> getCustomerHomePage(String customerId) async {
    url = port + customerHomePageUrl + customerId.toString();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };

    try {
      final response = await getRequest(url, headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.responseBody);
        int responseCode = jsonData['code'];
        String responseMsg = jsonData['msg'];

        if (responseCode == 0) {
          Map<String, dynamic> data = jsonData['data'];
          UserData? responseData = UserData.fromJson(data);
          return responseData;
        }
      }
    } catch (e) {
      print("Error in customer home page: $e");
    }
  }

  Future<int?> getCustomerTaskTotalCount(String customerId) async {
    url = port + customerTotalPostUrl + "customerId=${customerId}";

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };

    try {
      final response = await getRequest(url, headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.responseBody);
        int responseCode = jsonData['code'];
        String responseMsg = jsonData['msg'];

        if (responseCode == 0) {
          int responseData = jsonData['data'];
          return responseData;
        }
      }
    } catch (e) {
      print("Error in task total count: $e");
    }
  }

  Future<int?> getCustomerCollectionCount(String customerId) async {
    url = port + customerTotalCollectionUrl + customerId;

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };

    try {
      final response = await getRequest(url, headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.responseBody);
        int responseCode = jsonData['code'];
        String responseMsg = jsonData['msg'];

        if (responseCode == 0) {
          int responseData = jsonData['data'];
          return responseData;
        }
      }
    } catch (e) {
      print("Error in collection total count: $e");
    }
  }

  Future<OrderModel?> getCustomerHomePageTask(
      String customerId, int page) async {
    url = port +
        customerHomePageTaskUrl +
        customerId +
        "?page=${page.toString()}";
    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!,
    };

    try {
      final response = await getRequest(url, headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.responseBody);
        int responseCode = jsonData['code'];
        String responseMsg = jsonData['msg'];

        if (responseCode == 0) {
          List<dynamic>? data = jsonData['data'];
          List<OrderData>? responseData =
              data?.map((e) => OrderData.fromJson(e)).toList();
          OrderModel orderModel = OrderModel(
              code: responseCode, msg: responseMsg, data: responseData);
          return orderModel;
        } else {
          OrderModel orderModel =
              OrderModel(code: responseCode, msg: responseMsg, data: []);
          return orderModel;
        }
      }
    } catch (e) {
      print("Error in home page task: $e");
    }
  }

  Future<UpdateCustomerInfoModel?> updateCustomerInfo(UserData userData) async {
    url = port + updateUserInfoUrl;

    UpdateCustomerInfoModel updateCustomerInfoModel;

    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!,
    };

    final Map<String, dynamic> body = {
      'nickname': userData.nickname,
      'username': userData.username,
      'country': userData.country,
      'gender': userData.gender,
      'avatar': userData.avatar,
      'secondPhoneNo': userData.secondPhoneNo,
      'email': userData.email,
      'businessScopeId': userData.businessScopeId,
      'billingNetwork': userData.billingNetwork,
      'billingAddress': userData.billingAddress,
      // 'billingCurrency': userData.billingCurrency
    };

    try {
      final response = await patchRequest(url, headers, body);
      int statusCode = response.statusCode;

      Map<String, dynamic> jsonData = json.decode(response.responseBody);
      int responseCode = jsonData['code'];
      String responseMsg = jsonData['msg'];
      bool responseData = jsonData['data'];

      updateCustomerInfoModel = UpdateCustomerInfoModel(
          code: responseCode, msg: responseMsg, data: responseData);
      return updateCustomerInfoModel;
    } catch (e) {
      print("Error in update customer info");
      return null;
    }
  }

  Future<UpdateCustomerInfoModel?> updateCustomerPassword(
      String password) async {
    String? token = await SharedPreferencesUtils.getToken();
    url = port + updateCustomerPassUrl + token!;

    UpdateCustomerInfoModel updateCustomerInfoModel;

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token,
    };

    final Map<String, dynamic> body = {'password': userData?.password};

    try {
      final response = await patchRequest(url, headers, body);
      int statusCode = response.statusCode;

      Map<String, dynamic> jsonData = json.decode(response.responseBody);
      int responseCode = jsonData['code'];
      String responseMsg = jsonData['msg'];
      bool responseData = jsonData['data'];

      updateCustomerInfoModel = UpdateCustomerInfoModel(
          code: responseCode, msg: responseMsg, data: responseData);
      return updateCustomerInfoModel;
    } catch (e) {
      print("Error in update customer password");
      return null;
    }
  }

  Future<UploadCustomerAvatarModel?> uploadAvatar(File imageFile) async {
    String? token = await SharedPreferencesUtils.getToken();
    url = port + uploadAvatarUrl + token!;

    UploadCustomerAvatarModel uploadCustomerAvatarModel;

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token,
    };

    final Map<String, dynamic> body = {'file': userData?.avatar};

    try {
      final response = await postRequest(url, headers, body);
      int statusCode = response.statusCode;

      Map<String, dynamic> jsonData = json.decode(response.responseBody);
      int responseCode = jsonData['code'];
      String responseMsg = jsonData['msg'];
      String responseData = jsonData['data'];

      if (statusCode == 200) {
        if (responseCode == 0) {
          uploadCustomerAvatarModel = UploadCustomerAvatarModel(
              code: responseCode, msg: responseMsg, data: responseData);

          return uploadCustomerAvatarModel;
        } else {
          uploadCustomerAvatarModel = UploadCustomerAvatarModel(
              code: responseCode, msg: responseMsg, data: responseData);

          return uploadCustomerAvatarModel;
        }
      }
    } catch (e) {
      print("Error in upload avatar: $e");
    }
  }
}
