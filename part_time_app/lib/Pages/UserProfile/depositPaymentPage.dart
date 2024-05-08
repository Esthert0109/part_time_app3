import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:part_time_app/Components/Card/userDetailCardComponent.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class DepositPaymentPage extends StatefulWidget {
  const DepositPaymentPage({super.key});

  @override
  State<DepositPaymentPage> createState() => _DepositPaymentPageState();
}

class _DepositPaymentPageState extends State<DepositPaymentPage> {
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
                      "发布权限",
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "信息填写",
                    style: depositTextStyle3,
                  ),
                ),
                UserDetailCardComponent(
                  isEditProfile: false,
                ),
                Container(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "押金提交",
                    style: depositTextStyle3,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: kMainWhiteColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "支付信息 (平台)",
                        style: depositTextStyle2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "USDT 链名称：",
                              style: inputCounterTextStyle,
                            ),
                            SizedBox(height: 5),
                            Text("支付信息 (平台)"),
                            SizedBox(height: 5),
                            Text(
                              "USDT 链地址：",
                              style: inputCounterTextStyle,
                            ),
                            Row(
                              children: [
                                Text("USDT 链地址USDT 链地址USDT 链地址"),
                                SizedBox(width: 50),
                                GestureDetector(
                                    onTap: () {},
                                    child: SvgPicture.asset(
                                        "assets/common/copy.svg",
                                        width: 15))
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
