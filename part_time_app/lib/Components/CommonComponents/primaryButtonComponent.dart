import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class primaryButtonComponent extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const primaryButtonComponent({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        margin: const EdgeInsets.only(left: 12, right: 12),
        width: screenWidth,
        height: 46,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: kMainYellowColor,
            textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: kMainBlackColor),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
          ),
          onPressed: onPressed,
          child: Text(
            text,
          ),
        ));
  }
}
