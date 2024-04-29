import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:part_time_app/Constants/colorConstant.dart';

import '../../Constants/textStyleConstant.dart';

class MissionMessageCardComponent extends StatefulWidget {
  final String messageTitle;
  final String messageDesc;
  Function() onTap;
  MissionMessageCardComponent(
      {super.key,
      required this.messageTitle,
      required this.messageDesc,
      required this.onTap});

  @override
  State<MissionMessageCardComponent> createState() =>
      _MissionMessageCardComponentState();
}

class _MissionMessageCardComponentState
    extends State<MissionMessageCardComponent> {
  Color buttonColor = kMainWhiteColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          decoration: const BoxDecoration(
              color: kMainWhiteColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 6),
                child: Text(
                  widget.messageTitle,
                  style: messageTitleTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
                child: Text(
                  widget.messageDesc,
                  style: messageDescTextStyle,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTapDown: (details) {
            setState(() {
              buttonColor = kThirdGreyColor;
              widget.onTap();
            });
          },
          onTapUp: (details) {
            setState(() {
              buttonColor = kMainWhiteColor;
            });
          },
          child: Container(
            height: 45,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: buttonColor,
                border: Border(top: BorderSide(color: kBorderColor, width: 1)),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
            child: Center(
              child: Text(
                "查看",
                style: checkTextStyle2,
              ),
            ),
          ),
        )
      ],
    );
  }
}
