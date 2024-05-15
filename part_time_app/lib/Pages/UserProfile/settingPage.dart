import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Components/Dialog/alertDialogComponent.dart';
import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Utils/sharedPreferencesUtils.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isPrivate = false;

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
                  text: "设置",
                ))),
        body: Container(
          constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.all(12),
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 92,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: kMainWhiteColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          "隐私设置",
                          style: secondaryTextFieldHintTextStyle,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "任务收藏",
                            style: missionDetailText6,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Text(
                                    isPrivate ? "仅自己可见" : "公开",
                                    style: tStatusFieldText1,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                  height: 40,
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Switch(
                                        value: isPrivate,
                                        activeColor: kMainBlackColor,
                                        activeTrackColor: kMainYellowColor,
                                        inactiveTrackColor: kTransparent,
                                        inactiveThumbColor: kMainBlackColor,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.padded,
                                        trackOutlineColor: MaterialStateProperty
                                            .resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                            if (isPrivate) {
                                              return kMainBlackColor;
                                            }
                                            return kMainBlackColor; // Use the default color.
                                          },
                                        ),
                                        trackOutlineWidth:
                                            MaterialStateProperty.all(1),
                                        onChanged: (private) {
                                          setState(() {
                                            isPrivate = private;
                                          });
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: 92,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: kMainWhiteColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          "账号设置",
                          style: secondaryTextFieldHintTextStyle,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "登出",
                              style: missionDetailText6,
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialogComponent(
                                        alertTitle: '您即将登出账号',
                                        alertDesc: Text(""),
                                        descTextStyle:
                                            alertDialogContentTextStyle,
                                        firstButtonText: '返回',
                                        firstButtonTextStyle:
                                            alertDialogFirstButtonTextStyle,
                                        firstButtonColor: kThirdGreyColor,
                                        secondButtonText: '登出',
                                        secondButtonTextStyle:
                                            tStatusFieldText1,
                                        secondButtonColor: kMainYellowColor,
                                        isButtonExpanded: true,
                                        firstButtonOnTap: () {
                                          setState(() {
                                            Navigator.pop(context);
                                          });
                                        },
                                        secondButtonOnTap: () async {
                                          await SharedPreferencesUtils
                                              .clearSharedPreferences();
                                          setState(() {
                                            Navigator.pop(context);

                                            Fluttertoast.showToast(
                                                msg: "已登出",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: kMainGreyColor,
                                                textColor: kThirdGreyColor);
                                            Get.offAllNamed('/onboarding');
                                          });
                                        },
                                      );
                                    });
                              },
                              child: Text(
                                "登出账号",
                                style: logoutTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
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
