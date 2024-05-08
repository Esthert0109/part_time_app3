import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
