import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class missionNoticeCardComponent extends StatelessWidget {
  final String text;
  final String clickableText;
  final String noticeText;

  const missionNoticeCardComponent({
    Key? key,
    required this.text,
    required this.clickableText,
    required this.noticeText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
          padding: const EdgeInsetsDirectional.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: kMainWhiteColor,
          ),
          height: 101,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      text: text,
                      style: missionNoticeBlackTextStyle,
                      children: <TextSpan>[
                    TextSpan(
                      text: clickableText,
                      style: missionNoticeCardBlueTextStyle,
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    )
                  ])),
              const SizedBox(height: 12),
              Text(
                noticeText,
                style: missionNoticeGreyTextStyle,
              )
            ],
          )),
    );
  }
}
