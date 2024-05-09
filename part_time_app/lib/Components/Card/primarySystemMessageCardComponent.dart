import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class primarySystemMessageCardComponent extends StatefulWidget {
  final String messageTitle;
  final String messageContent;

  const primarySystemMessageCardComponent({
    super.key,
    required this.messageTitle,
    required this.messageContent,
  });

  @override
  State<primarySystemMessageCardComponent> createState() =>
      _primarySystemMessageCardComponentState();
}

class _primarySystemMessageCardComponentState
    extends State<primarySystemMessageCardComponent> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
          width: double.infinity,
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
                widget.messageTitle,
                style: primarySystemMessageTitleTextStyle,
              ),
              const SizedBox(height: 12),
              Text(
                widget.messageContent,
                style: missionDetailText2,
              )
            ],
          )),
    );
  }
}
