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

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

final ImagePicker _picker = ImagePicker();

class _EditProfilePageState extends State<EditProfilePage> {
  bool isLoading = false;
  bool isUploading = false;
  ScrollController _scrollController = ScrollController();
  UploadServices uploadServices = UploadServices();
  String? updatedAvatar;

  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 2), () {
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
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
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kTextTabBarHeight),
        child: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              "assets/common/arrow_back.svg",
              // height: 58,
              // width: 58,
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
      body: isLoading
          ? const EditProfilePageLoadingComponent()
          : SingleChildScrollView(
              child: Column(
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
                      usernameInitial: userData.nickname,
                      countryInitial: userData.country,
                      fieldInitial: userData.businessScopeId,
                      emailInitial: userData.email,
                      nameInitial: userData.username,
                      sexInitial: userData.gender,
                      phoneNumber: userData.secondPhoneNo,
                      walletAddressInitial: userData.billingAddress,
                      walletNetworkInitial: userData.billingNetwork,
                      usdtLinkInitial: userData.billingCurrency,
                      avatarUrl: updatedAvatar,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
