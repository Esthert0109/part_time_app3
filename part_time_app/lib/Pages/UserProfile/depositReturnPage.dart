import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Components/Button/primaryButtonComponent.dart';
import '../../Components/Card/userDetailCardComponent.dart';
import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class DepositReturnPage extends StatefulWidget {
  const DepositReturnPage({super.key});

  @override
  State<DepositReturnPage> createState() => _DepositReturnPageState();
}

class _DepositReturnPageState extends State<DepositReturnPage> {
  bool isLoading = false;
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
                  text: "押金退还",
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
          child: SingleChildScrollView(
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
                    isLoading: false,
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
                    isLoading: isLoading,
                    text: "确认提交",
                    buttonColor: kMainYellowColor,
                    textStyle: buttonTextStyle,
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });

                      Future.delayed(Duration(seconds: 2), () {
                        setState(() {
                          isLoading = false;
                          Get.back();
                          Fluttertoast.showToast(
                            msg: "已提交",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: kMainGreyColor,
                            textColor: kThirdGreyColor,
                          );
                        });
                      });
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
