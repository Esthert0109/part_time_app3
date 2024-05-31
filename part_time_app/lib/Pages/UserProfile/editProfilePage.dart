import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:part_time_app/Components/Button/primaryButtonComponent.dart';
import 'package:part_time_app/Components/Card/userDetailCardComponent.dart';
import 'package:part_time_app/Components/Loading/editProfilePageLoading.dart';
import 'package:part_time_app/Components/Title/secondaryTitleComponent.dart';
import 'package:part_time_app/Components/Title/thirdTitleComponent.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/globalConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';
import 'package:part_time_app/Services/Upload/uploadServices.dart';
import 'package:part_time_app/Services/User/userServices.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';

import '../../Model/User/userModel.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

final ImagePicker _picker = ImagePicker();

class _EditProfilePageState extends State<EditProfilePage> {
  bool isLoading = false;
  bool isUploading = false;
  bool isUpdating = false;
  ScrollController _scrollController = ScrollController();
  UploadServices uploadServices = UploadServices();
  UserServices services = UserServices();
  String? updatedAvatar = userData!.avatar;
  String? nickname;
  String? username;
  String? country;
  int? field;
  String? secPhoneNumber;
  String? email;
  String? gender;
  String? walletAddress;
  String? walletNetwork;
  String? usdtLink;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    try {
      UserData? data = await SharedPreferencesUtils.getUserDataInfo();
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        nickname = data!.nickname;
        username = data.username;
        country = data.country;
        field = data?.businessScopeId ?? 0;
        email = data.email;
        gender = data.gender;
        secPhoneNumber = data.secondPhoneNo;
        walletAddress = data.billingAddress;
        walletNetwork = data.billingNetwork;
        usdtLink = data.billingCurrency;
        isLoading = false;
      });
    } catch (e) {
      print("problem");
    }
  }

  void selectAvatar() async {
    XFile? newAvatar = await _picker.pickImage(source: ImageSource.gallery);
    File avatarPath = File("");

    if (newAvatar != null) {
      setState(() {
        isUploading = true;
      });
      avatarPath = File(newAvatar.path);
      String? path = await uploadServices.uploadAvatar(avatarPath);
      if (path != null) {
        setState(() {
          updatedAvatar = path;
          isUploading = false;
          Fluttertoast.showToast(
              msg: "已上传",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: kMainGreyColor,
              textColor: kThirdGreyColor);
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // fetchData();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kTextTabBarHeight),
        child: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              "assets/common/arrow_back.svg",
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  kBackgroundFirstGradientColor,
                  kBackgroundSecondGradientColor
                ],
                stops: [0.5, 1.0],
              ),
            ),
          ),
          backgroundColor: const Color(0xFFF9F9F9),
          title: const thirdTitleComponent(
            text: '编辑资料',
          ),
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: isLoading
                ? EditProfilePageLoadingComponent()
                : Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 29,
                            backgroundColor: kSecondGreyColor,
                            child: ClipOval(
                              child: Image.network(
                                updatedAvatar ?? userData!.avatar!,
                                fit: BoxFit.cover,
                                height: 58,
                                width: 58,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: isUploading
                                ? null
                                : () {
                                    selectAvatar();
                                  },
                            child: CircleAvatar(
                              radius: 29,
                              backgroundColor: Colors.black38,
                              child: Center(
                                child: isUploading
                                    ? LoadingAnimationWidget.stretchedDots(
                                        color: kMainYellowColor, size: 20)
                                    : Icon(
                                        Icons.camera_alt,
                                        color: kMainWhiteColor,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        child: UserDetailCardComponent(
                          isEditProfile: true,
                          usernameInitial: nickname,
                          countryInitial: country,
                          fieldInitial: field,
                          emailInitial: email,
                          nameInitial: username,
                          sexInitial: gender,
                          phoneNumber: secPhoneNumber,
                          walletAddressInitial: walletAddress,
                          walletNetworkInitial: walletNetwork,
                          usdtLinkInitial: usdtLink,
                        ),
                      ),
                    ],
                  ),
          ))
        ],
      ),
      bottomNavigationBar: Container(
        height: 105,
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(color: kMainWhiteColor, boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(1, 0),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ]),
        child: SizedBox(
          width: double.infinity,
          child: primaryButtonComponent(
            isLoading: isUpdating,
            buttonColor: kMainYellowColor,
            disableButtonColor: buttonLoadingColor,
            text: "立刻保存",
            textStyle: buttonTextStyle,
            onPressed: () async {
              isUpdating = true;
              print(
                  "check update profile: ${usernameControllerPayment.text}, ${countryControllerPayment.text}, ${sexControllerPayment.text}, ${emailControllerPayment.text}, ${nameControllerPayment.text}, ${phone}, ${walletNetworkControllerPayment.text}, ${walletAddressControllerPayment.text}, ${bussinessIdSelected}, $updatedAvatar");

              try {
                UserData? updateProfile = UserData(
                  nickname: usernameControllerPayment.text,
                  username: nameControllerPayment.text,
                  country: countryControllerPayment.text,
                  gender: sexControllerPayment.text,
                  avatar: updatedAvatar,
                  secondPhoneNo: phone,
                  email: emailControllerPayment.text,
                  businessScopeId: bussinessIdSelected,
                  billingAddress: walletAddressControllerPayment.text,
                  billingNetwork: walletNetworkControllerPayment.text,
                );

                UpdateCustomerInfoModel? model =
                    await services.updateCustomerInfo(updateProfile);

                if (model!.code == 0) {
                  UserModel? model = await services.getUserInfo();
                  if (model!.code == 0) {
                    Fluttertoast.showToast(
                        msg: "已更新",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: kMainGreyColor,
                        textColor: kThirdGreyColor);
                    isUpdating = false;
                    updateProfile = null;
                    Get.back();
                  } else {
                    Fluttertoast.showToast(
                        msg: "更新失败，请重试",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: kMainGreyColor,
                        textColor: kThirdGreyColor);
                    isUpdating = false;
                  }
                } else {
                  Fluttertoast.showToast(
                      msg: "更新失败，请重试",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: kMainGreyColor,
                      textColor: kThirdGreyColor);
                }
              } catch (e) {
                Fluttertoast.showToast(
                    msg: "$e",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: kMainGreyColor,
                    textColor: kThirdGreyColor);
              }
              isUpdating = false;
            },
          ),
        ),
      ),
    );
  }
}
