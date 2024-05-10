import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Title/thirdTitleComponent.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Pages/UserProfile/depositHistoryDetailPage.dart';
import 'package:part_time_app/Pages/UserProfile/depositPaymentPage.dart';
import 'package:part_time_app/Pages/UserProfile/depositReturnPage.dart';

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
                    child: Align(
                      child: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: thirdTitleComponent(text: "押金认证"),
                      ),
                    )),
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
            children: [
              //card 1 true is already verified, then can return deposit.
              //condition(card1,2 is true)
              //card 1 false is NOT verify, then CANT return deposit.
              //condition(card1,2 is false)
              cardComponent1("• 押金认证", false),
              cardComponent2("• 退还押金", false)
            ],
          ),
        ),
      ),
    );
  }

  Widget cardComponent1(
    String text,
    bool deposit,
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
                    text,
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
                    onTap: deposit
                        ? () {
                            Get.to(() => PaymentHistoryDetailPage(),
                                transition: Transition.rightToLeft);
                          }
                        : () {
                            Get.to(() => DepositPaymentPage(),
                                transition: Transition.rightToLeft);
                          },
                    child: Text(deposit ? "查看详情" : "立刻认证",
                        style: depositTextStyle1),
                  )))
        ],
      ),
    );
  }

  Widget cardComponent2(
    String text,
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
                    text,
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
                            Get.to(() => DepositReturnPage(),
                                transition: Transition.rightToLeft);
                          }
                        : () {
                            setState(() {
                              Fluttertoast.showToast(
                                msg: "请先提交认证",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: kMainGreyColor,
                                textColor: kThirdGreyColor,
                              );
                            });
                          },
                    child: Text(
                      "立刻退还",
                      style: verify ? depositTextStyle1 : depositTextStyle4,
                    ),
                  )))
        ],
      ),
    );
  }
}
