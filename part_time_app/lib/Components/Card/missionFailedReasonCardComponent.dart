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
    return Card(
      elevation: 0,
      child: Container(
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
                style: missionFailedReasonTitleTextStyle,
              ),
              const SizedBox(height: 12),
              Text(
                widget.reasonDesc,
                style: missionFailedReasonDescTextStyle,
              )
            ],
          )),
    );
  }
}
