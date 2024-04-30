import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  final Function()? firstButtonOnTap;
  final String secondButtonText;
  final TextStyle secondButtonTextStyle;
  final Color secondButtonColor;
  final Function()? secondButtonOnTap;
  final bool isButtonExpanded;

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
      required this.secondButtonColor,
      required this.isButtonExpanded,
      this.firstButtonOnTap,
      this.secondButtonOnTap});

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
            widget.isButtonExpanded
                ? Expanded(
                    child: secondaryButtonComponent(
                      text: widget.firstButtonText,
                      onPressed: widget.firstButtonOnTap,
                      buttonColor: widget.firstButtonColor,
                      textStyle: widget.firstButtonTextStyle,
                    ),
                  )
                : secondaryButtonComponent(
                    text: widget.firstButtonText,
                    onPressed: widget.firstButtonOnTap,
                    buttonColor: widget.firstButtonColor,
                    textStyle: widget.firstButtonTextStyle,
                  ),
            SizedBox(
              width: 6,
            ),
            widget.isButtonExpanded
                ? Expanded(
                    child: secondaryButtonComponent(
                      text: widget.secondButtonText,
                      onPressed: widget.secondButtonOnTap,
                      buttonColor: widget.secondButtonColor,
                      textStyle: widget.secondButtonTextStyle,
                    ),
                  )
                : secondaryButtonComponent(
                    text: widget.secondButtonText,
                    onPressed: widget.secondButtonOnTap,
                    buttonColor: widget.secondButtonColor,
                    textStyle: widget.secondButtonTextStyle,
                  ),
          ],
        )
      ],
    );
  }
}
