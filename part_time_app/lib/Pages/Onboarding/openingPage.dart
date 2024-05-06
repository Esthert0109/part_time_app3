import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class OpeningPage extends StatefulWidget {
  const OpeningPage({super.key});

  @override
  State<OpeningPage> createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage> {
  @override
  void initState() {
    super.initState();
    getDataAndNavigate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getDataAndNavigate() {
    Timer(const Duration(seconds: 2), () {
      Get.offAllNamed('/');
    });
  }

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
    );
  }
}
