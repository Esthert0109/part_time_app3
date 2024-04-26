import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class thirdButtonComponent extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const thirdButtonComponent({
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
                fontWeight: FontWeight.w400,
                color: kSecondGreyColor),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
            elevation: 0,
          ),
          onPressed: onPressed,
          child: Text(
            text,
          ),
        ));
  }
}
