import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Button/primaryButtonComponent.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';
import 'package:part_time_app/Pages/Explore/exploreMainPage.dart';
import 'package:part_time_app/Pages/homePage.dart';

import '../UserAuth/loginPage.dart';
import '../UserAuth/signupPage.dart';

class OnboradingPage extends StatefulWidget {
  const OnboradingPage({super.key});

  @override
  State<OnboradingPage> createState() => _OnboradingPageState();
}

class _OnboradingPageState extends State<OnboradingPage> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      backgroundColor: kSlashScreenColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20 * fem),
                child: Image.asset(
                  'assets/opening/splashscreen.png',
                  width: 295 * fem,
                  height: 410 * fem,
                ),
              ),
              SizedBox(
                height: 30 * fem,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 11),
                      width: MediaQuery.of(context).size.width,
                      child: primaryButtonComponent(
                        text: '登入',
                        textStyle: onboradingPageTextStyle,
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            useSafeArea: true,
                            builder: (BuildContext context) {
                              return ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.9,
                                    child: const LoginPage(),
                                  ));
                            },
                          );
                        },
                        buttonColor: kMainYellowColor,
                      )),
                  SizedBox(
                    height: 10 * fem,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 11),
                      width: MediaQuery.of(context).size.width,
                      child: primaryButtonComponent(
                        text: '注册',
                        textStyle: onboradingPageText2Style,
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            useSafeArea: true,
                            builder: (BuildContext context) {
                              return ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.9,
                                    child: const SignUpPage(),
                                  ));
                            },
                          );
                        },
                        buttonColor: kOnboradingPageBtnColor,
                      ))
                ],
              ),
              SizedBox(
                height: 90 * fem,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => HomePage());
                },
                child: const Text(
                  '游客模式',
                  style: onboradingPageText3Style,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
