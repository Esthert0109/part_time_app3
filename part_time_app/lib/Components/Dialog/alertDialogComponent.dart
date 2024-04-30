import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Button/secondaryButtonComponent.dart';
import 'package:part_time_app/Constants/colorConstant.dart';

import '../../Constants/textStyleConstant.dart';

class AlertDialogComponent extends StatefulWidget {
  final String alertTitle;
  final String alertDesc;
  final TextStyle descTextStyle;
  final String firstButtonText;
  final TextStyle firstButtonTextStyle;
  final Color firstButtonColor;
  final String secondButtonText;
  final TextStyle secondButtonTextStyle;
  final Color secondButtonColor;

  const AlertDialogComponent(
      {super.key,
      required this.alertTitle,
      required this.alertDesc,
      required this.descTextStyle,
      required this.firstButtonText,
      required this.firstButtonTextStyle,
      required this.firstButtonColor,
      required this.secondButtonText,
      required this.secondButtonTextStyle,
      required this.secondButtonColor});

  @override
  State<AlertDialogComponent> createState() => _AlertDialogComponentState();
}

class _AlertDialogComponentState extends State<AlertDialogComponent> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: kMainWhiteColor,
      surfaceTintColor: kMainWhiteColor,
      title: Text(
        widget.alertTitle,
      ),
      titleTextStyle: alertDialogTitleTextStyle,
      content: Text(
        widget.alertDesc,
      ),
      contentTextStyle: widget.descTextStyle,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            secondaryButtonComponent(
              text: widget.firstButtonText,
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
              buttonColor: kMainYellowColor,
              textStyle: alertDialogSecondButtonTextStyle,
            ),
            secondaryButtonComponent(
              text: widget.secondButtonText,
              onPressed: () {
                setState(() {
                  print("pressed");
                });
              },
              buttonColor: kMainYellowColor,
              textStyle: alertDialogSecondButtonTextStyle,
            )
          ],
        )
      ],
    );
  }
}
