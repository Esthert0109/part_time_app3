import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Components/Button/primaryButtonComponent.dart';
import '../../Components/Card/userDetailCardComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class DepositReturnPage extends StatefulWidget {
  const DepositReturnPage({super.key});

  @override
  State<DepositReturnPage> createState() => _DepositReturnPageState();
}

class _DepositReturnPageState extends State<DepositReturnPage> {
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
                      "押金退还",
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
            children: [
              UserDetailCardComponent(
                isEditProfile: false,
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: kMainWhiteColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  "注意事项：退还押金后将无法使用发布功能，若想使用发布功能，需再次支付押金，并进行审核。(3-5天审核时间) \n(退还押金将下架所有正在进行中的悬赏 或 剩下已完成的悬赏)",
                  style: searchBarTextStyle,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
            height: 84,
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(color: kMainWhiteColor, boxShadow: [
              BoxShadow(
                color: Color(0x1A000000),
                offset: Offset(1, 0),
                blurRadius: 2,
                spreadRadius: 0,
              ),
            ]),
            child: Row(
              children: [
                Expanded(
                  child: primaryButtonComponent(
                    text: "放弃提交",
                    buttonColor: kRejectMissionButtonColor,
                    textStyle: missionRejectButtonTextStyle,
                    onPressed: () {
                      setState(() {
                        Get.back();
                        // Fluttertoast.showToast(
                        //     msg: "已提交",
                        //     toastLength: Toast.LENGTH_LONG,
                        //     gravity: ToastGravity.BOTTOM,
                        //     backgroundColor: kMainGreyColor,
                        //     textColor: kThirdGreyColor);
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: primaryButtonComponent(
                    text: "确认提交",
                    buttonColor: kMainYellowColor,
                    textStyle: buttonTextStyle,
                    onPressed: () {
                      setState(() {
                        Get.back();
                        Fluttertoast.showToast(
                            msg: "已提交",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: kMainGreyColor,
                            textColor: kThirdGreyColor);
                      });
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}
