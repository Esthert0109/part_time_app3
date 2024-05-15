import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../Common/countdownTimer.dart';

class MissionReviewRecipientCardComponent extends StatelessWidget {
  final bool isReviewing;
  final bool isCompleted;
  final String userAvatar;
  final String username;
  final Function()? onTap;
  final String? duration;

  MissionReviewRecipientCardComponent({
    Key? key,
    required this.isReviewing,
    required this.isCompleted,
    required this.userAvatar,
    required this.username,
    this.onTap,
    this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kMainWhiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: kSecondGreyColor,
                  foregroundImage: NetworkImage(userAvatar),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    username,
                    style: recipientCardTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          if (!isCompleted && duration != null)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: CountdownTimer(
                  isOTP: false,
                  isReview: true,
                  expiredDate: DateTime(2024, 6, 8, 12, 0, 0),
                ),
              ),
            ),
          if (isReviewing || isCompleted)
            GestureDetector(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  "查看",
                  style: checkTextStyle,
                  textAlign: TextAlign.right,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
