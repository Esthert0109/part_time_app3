import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:part_time_app/Components/Button/primaryButtonComponent.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';
import 'package:part_time_app/Pages/Explore/exploreMainPage.dart';

class onboradingPage extends StatefulWidget {
  const onboradingPage({super.key});

  @override
  State<onboradingPage> createState() => _onboradingPageState();
}

class _onboradingPageState extends State<onboradingPage> {
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
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => const LoginPage()));
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
                            // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => const RegistrationPage()));
                        },
                        buttonColor: kOnboradingPageBtnColor,
                      ))
                ],
              ),
              SizedBox(
                height: 90 * fem,
              ),
              const Text(
                '游客模式',
                style: onboradingPageText3Style,
              )
            ],
          ),
        ),
      ),
    );
  }
}
