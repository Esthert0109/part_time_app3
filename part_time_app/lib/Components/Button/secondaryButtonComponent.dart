import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class secondaryButtonComponent extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color buttonColor;
  final TextStyle textStyle;

  const secondaryButtonComponent({
    Key? key,
    required this.text,
    this.onPressed,
    required this.buttonColor,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              textStyle: textStyle,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2)),
              elevation: 0),
          onPressed: onPressed,
          child: Text(
            text,
          ),
        ));
  }
}
