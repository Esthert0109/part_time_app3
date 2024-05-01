import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class missionNoticeCardComponent extends StatelessWidget {

  const missionNoticeCardComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsetsDirectional.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: kMainWhiteColor,
        ),
        height: 101,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    text: "报名悬赏前，请阅读",
                    style: bottomNaviBarTextStyle,
                    children: <TextSpan>[
                  TextSpan(
                    text: "《众人帮做悬赏须知规范》",
                    style: clickableTextStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("pressed");
                      },
                  ),
                ])),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: RichText(
                text: TextSpan(
                    text: "请知晓",
                    style: bottomNaviBarTextStyle,
                    children: [
                      TextSpan(
                        text: "《悬赏发布者声明》",
                        style: clickableTextStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("pressed");
                          },
                      )
                    ]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "投资理财有风险，请勿与他人私下交易，谨防上当",
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: kSecondGreyColor),
                ),
              ],
            )
          ],
        ));
  }
}
