import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Pages/UserProfile/depositPaymentPage.dart';
import 'package:part_time_app/Pages/UserProfile/depositReturnPage.dart';

import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/textStyleConstant.dart';

class TicketMainPage extends StatefulWidget {
  const TicketMainPage({super.key});

  @override
  State<TicketMainPage> createState() => _TicketMainPageState();
}

class _TicketMainPageState extends State<TicketMainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0.0,
            leading: IconButton(
              iconSize: 15,
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Get.back();
              },
            ),
            centerTitle: true,
            title: Container(
                color: kTransparent,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: thirdTitleComponent(
                  text: "工单",
                ))),
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
      height: 95,
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
                    verify ? "• 查看工单" : "• 提交工单",
                    style: primarySystemMessageTitleTextStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      verify
                          ? "查看已提交的工单，尽可查看不可删除或更改。"
                          : "提交工单，一个工单仅可举报一个用户或悬赏ID。",
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
                            // Get.to(() => DepositPaymentPage(),
                            //     transition: Transition.rightToLeft);
                          }
                        : () {
                            // Get.to(() => DepositReturnPage(),
                            //     transition: Transition.rightToLeft);
                          },
                    child: Text(verify ? "查看工单" : "  提交工单",
                        style: depositTextStyle1),
                  )))
        ],
      ),
    );
  }
}
