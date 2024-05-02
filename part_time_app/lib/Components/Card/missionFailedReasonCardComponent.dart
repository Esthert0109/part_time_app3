import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class missionFailedReasonCardComponent extends StatefulWidget {
  final String reasonTitle;
  final String reasonDesc;

  const missionFailedReasonCardComponent({
    super.key,
    required this.reasonTitle,
    required this.reasonDesc,
  });

  @override
  State<missionFailedReasonCardComponent> createState() =>
      _missionFailedReasonCardComponentState();
}

class _missionFailedReasonCardComponentState
    extends State<missionFailedReasonCardComponent> {
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
              widget.reasonTitle,
              style: const TextStyle(
                  color: kMainBlackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                widget.reasonDesc,
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
