import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class missionFailedReasonCardComponent extends StatelessWidget {
  final String reasonTitle;
  final String reasonDesc;

  const missionFailedReasonCardComponent({
    Key? key,
    required this.reasonTitle,
    required this.reasonDesc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        padding: const EdgeInsetsDirectional.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: kMainWhiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              reasonTitle,
              style: const TextStyle(
                  color: kMainBlackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                reasonDesc,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: kSecondGreyColor),
              ),
            )
          ],
        ));
  }
}
