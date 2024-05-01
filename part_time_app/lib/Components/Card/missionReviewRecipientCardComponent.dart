import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Constants/colorConstant.dart';

import '../../Constants/textStyleConstant.dart';

class MissionReviewRecipientCardComponent extends StatefulWidget {
  final bool isReviewing;
  final bool isCompleted;
  final String userAvatar;
  final String username;
  Function()? onTap;
  String? duration;

  MissionReviewRecipientCardComponent(
      {super.key,
      required this.isReviewing,
      required this.isCompleted,
      required this.userAvatar,
      required this.username,
      this.onTap,
      this.duration});

  @override
  State<MissionReviewRecipientCardComponent> createState() =>
      _MissionReviewRecipientCardComponentState();
}

class _MissionReviewRecipientCardComponentState
    extends State<MissionReviewRecipientCardComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: kMainWhiteColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 15,
            child: CircleAvatar(
              backgroundColor: kSecondGreyColor,
              foregroundImage: NetworkImage(widget.userAvatar),
            ),
          ),
          Expanded(
            flex: widget.isReviewing ? 50 : 65,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.username,
                style: recipientCardTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          widget.isCompleted
              ? Container()
              : Expanded(
                  flex: 40,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "剩余时间 ",
                        style: durationTextStyle,
                        children: [
                          TextSpan(
                              text: widget.duration, style: durationTextStyle)
                        ]),
                  ),
                ),
          (widget.isReviewing || widget.isCompleted)
              ? GestureDetector(
                  onTap: widget.onTap,
                  child: Expanded(
                    flex: 10,
                    child: Text(
                      "查看",
                      style: checkTextStyle,
                      textAlign: TextAlign.right,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
