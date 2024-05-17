import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';
import 'package:part_time_app/Services/explore/categoryServices.dart';
import 'package:part_time_app/Services/User/userServices.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';

import '../../Constants/globalConstant.dart';
import '../../Model/Category/categoryModel.dart';
import '../../Model/User/userModel.dart';
import '../../Model/notification/messageModel.dart';
import '../../Services/notification/systemMessageServices.dart';

class OpeningPage extends StatefulWidget {
  const OpeningPage({super.key});

  @override
  State<OpeningPage> createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage> {
  bool isFetching = false;
  bool isLogin = false;
  UserData? userInfo;
  UserServices services = UserServices();
  CategoryServices categoryServices = CategoryServices();
  SystemMessageServices messageServices = SystemMessageServices();

  @override
  void initState() {
    super.initState();
    checkIfLogined();
    // fetchDataExplorePage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  checkIfLogined() async {
    String? token = await SharedPreferencesUtils.getToken();
    String? phone = await SharedPreferencesUtils.getPhoneNo();
    String? password = await SharedPreferencesUtils.getPassword();

    if (token != null && token != "") {
      if (phone != null && password != null) {
        try {
          LoginUserModel? userModel = await services.login(phone!, password!);
          if (userModel!.code == 0) {
            UserModel? user = await services.getUserInfo();
            await SharedPreferencesUtils.saveUserInfo(user!);
            await SharedPreferencesUtils.saveUserDataInfo(user.data!);
            await SharedPreferencesUtils.saveToken(userModel.data!.token!);

            if (user.code == 0) {
              Get.offAllNamed('/');
            }
          }
        } catch (e) {
          Timer(const Duration(seconds: 1), () {
            Get.offAllNamed('/onboarding');
          });
        }
      } else {
        Timer(const Duration(seconds: 1), () {
          Get.offAllNamed('/onboarding');
        });
      }
    } else {
      Timer(const Duration(seconds: 1), () {
        Get.offAllNamed('/onboarding');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      backgroundColor: kSlashScreenColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30 * fem),
                  child: Image.asset(
                    'assets/opening/splashscreen.png',
                    width: 295 * fem,
                    height: 410 * fem,
                  ),
                ),
                SizedBox(
                  height: 90 * fem,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/opening/pandalogo.svg',
                      width: 50 * fem,
                      height: 50 * fem,
                    ),
                    SizedBox(
                      width: 20 * fem,
                    ),
                    const Text("兼职平台app", style: splashScreenTextStyle)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
