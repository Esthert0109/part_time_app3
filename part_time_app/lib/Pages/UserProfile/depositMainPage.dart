import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Pages/UserProfile/depositPaymentPage.dart';

import '../../Constants/textStyleConstant.dart';

class DepositMainPage extends StatefulWidget {
  const DepositMainPage({super.key});

  @override
  State<DepositMainPage> createState() => _DepositMainPageState();
}

class _DepositMainPageState extends State<DepositMainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: SvgPicture.asset(
                      "assets/common/back_button.svg",
                      width: 24,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const Expanded(
                  flex: 12,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      "押金认证",
                      style: dialogText2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
          decoration: const BoxDecoration(
            color: kThirdGreyColor,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                kBackgroundFirstGradientColor,
                kBackgroundSecondGradientColor
              ],
              stops: [0.0, 0.15],
            ),
          ),
          child: Column(
            children: [cardComponent(true), cardComponent(false)],
          ),
        ),
      ),
    );
  }

  Widget cardComponent(
    bool verify,
  ) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(15),
      height: 94,
      decoration: BoxDecoration(
          color: kMainWhiteColor, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: Container(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    verify ? "• 退还押金" : "• 押金认证",
                    style: primarySystemMessageTitleTextStyle,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "账号仅限本人使用，禁止转借共用等。",
                      style: missionDetailText2,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                  padding: EdgeInsets.fromLTRB(5, 10, 0, 35),
                  child: GestureDetector(
                    onTap: verify
                        ? () {
                            Get.to(() => DepositPaymentPage(),
                                transition: Transition.rightToLeft);
                          }
                        : () {},
                    child: Text(verify ? "立刻认证" : " 立刻退还",
                        style: depositTextStyle1),
                  )))
        ],
      ),
    );
  }
}
