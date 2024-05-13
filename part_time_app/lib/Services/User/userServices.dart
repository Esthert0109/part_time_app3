import 'dart:convert';

import 'package:part_time_app/Utils/apiUtils.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';

import '../../Constants/apiConstant.dart';
import '../../Model/User/userModel.dart';

class UserServices {
  String url = "";

  Future<LoginUserModel?> login(UserData userData) async {
    url = port + loginUrl;
    LoginUserModel? loginUserModel;

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };

    final Map<String, dynamic> body = {
      'first_phone_no': userData.firstPhoneNo,
      'password': userData.password
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
            await SharedPreferencesUtils.savePhoneNo(userData.firstPhoneNo!);
            await SharedPreferencesUtils.savePassword(userData.password!);
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

    final Map<String, dynamic> body = {
      "username": userData.username,
      "password": userData.password,
      "firstPhoneNo": userData.firstPhoneNo
    };

    try {
      final response = await postRequest(url, headers, body);
      int statusCode = response.statusCode;

      Map<String, dynamic> jsonData = json.decode(response.responseBody);
      int responseCode = jsonData['code'];
      String responseMsg = jsonData['msg'];
      Map<String, dynamic> data = jsonData['data'];
      UserData responseData = UserData.fromJson(data);

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

      Map<String, dynamic>? data = jsonData;
      UserData responseData = UserData.fromJson(data!);
      userModel = UserModel(data: responseData);

      return userModel;
    } catch (e) {
      print("Error in get user info: $e");
      return userModel;
    }
  }
}
