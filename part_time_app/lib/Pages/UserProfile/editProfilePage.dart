import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:part_time_app/Components/Button/primaryButtonComponent.dart';
import 'package:part_time_app/Components/Card/userDetailCardComponent.dart';
import 'package:part_time_app/Components/Loading/editProfilePageLoading.dart';
import 'package:part_time_app/Components/Title/secondaryTitleComponent.dart';
import 'package:part_time_app/Components/Title/thirdTitleComponent.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

final ImagePicker _picker = ImagePicker();

void openImagePicker() async {
  XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    // showLoadingDialog(context);
    // 选择了图像
    File imageFile = File(image.path);
    print("Checking imageFile $imageFile");

    try {
      //  bool isFinish = await customerService.updateProfilePic(imageFile);
      //   if (isFinish == true) {

      //   }
    } catch (e) {
      print("Error updating profile picture: $e");
    }
  } else {
    // 用户取消了选择
  }
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isLoading = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
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
            title: const ThirdTitleComponent(
              text: '编辑资料',
            ),
            centerTitle: true,
          ),
        ),
        body: isLoading
            ? const EditProfilePageLoadingComponent()
            : Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          print("edit image");
                          setState(() {
                            openImagePicker();
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/profile/profile_img.svg",
                                height: 58,
                                width: 58,
                              ),
                              Positioned(
                                bottom: 16,
                                right: 16,
                                child: SvgPicture.asset(
                                  "assets/profile/camera.svg",
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: UserDetailCardComponent(
                          isEditProfile: true,
                        ),
                      ),
                    ],
                  ))),
                  Material(
                    elevation: 20,
                    child: Container(
                        padding: const EdgeInsets.only(
                            bottom: 50, left: 10, right: 10, top: 5),
                        decoration: const BoxDecoration(color: kMainWhiteColor),
                        width: double.infinity,
                        child: PrimaryButtonComponent(
                          text: "立刻保存",
                          onPressed: () {},
                          buttonColor: kMainYellowColor,
                          textStyle: missionCheckoutTotalPriceTextStyle,
                        )),
                  )
                ],
              ));
  }
}
