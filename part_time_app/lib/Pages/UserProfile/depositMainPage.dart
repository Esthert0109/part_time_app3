import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Title/thirdTitleComponent.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Pages/UserProfile/paymentHistoryDetailPage.dart';
import 'package:part_time_app/Pages/UserProfile/depositPaymentPage.dart';
import 'package:part_time_app/Pages/UserProfile/depositReturnPage.dart';

import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/globalConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/User/userModel.dart';
import '../../Services/payment/paymentServices.dart';
import 'depositPaymentStatusPage.dart';

class DepositMainPage extends StatefulWidget {
  final bool isHome;
  const DepositMainPage({super.key, required this.isHome});

  @override
  State<DepositMainPage> createState() => _DepositMainPageState();
}

class _DepositMainPageState extends State<DepositMainPage> {
  PaymentServices paymentService = PaymentServices();
  bool depositSubmitted = false;
  UserData? depositStatus;

  fetchStatus() async {
    UserData? data = await paymentService.depositStatus();
    setState(() {
      if (data != null) {
        depositStatus = data;
        depositSubmitted = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchStatus();
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0.0,
            leading: widget.isHome
                ? null
                : IconButton(
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
                  text: "押金认证",
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
            children: [
              //card 1 true is already verified, then can return deposit.
              //condition(card1,2 is true)
              //card 1 false is NOT verify, then CANT return deposit.
              //condition(card1,2 is false)
              if (userData?.validIdentity == 1) ...[
                cardComponent1("• 押金认证", depositSubmitted),
                cardComponent2("• 退还押金", true),
              ] else ...[
                cardComponent1("• 押金认证", depositSubmitted),
                cardComponent2("• 退还押金", false),
              ],
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
                            Get.to(() => DepositPaymentStatusPage(),
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
