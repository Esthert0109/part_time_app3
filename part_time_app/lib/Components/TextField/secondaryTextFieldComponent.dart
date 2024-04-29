import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class secondaryTextFieldComponent extends StatelessWidget {
  final String hintText;

  const secondaryTextFieldComponent({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        margin: const EdgeInsets.only(left: 12, right: 12),
        width: screenWidth,
        height: 31,
        child: TextField(
          style: const TextStyle(
              color: kMainBlackColor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none
              ),
            hintText: hintText,
            filled: true,
            fillColor: kSecondTextFieldGreyColor,
            contentPadding: const EdgeInsetsDirectional.only(start: 10, top: 8, bottom: 8, end: 10),
            hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: kSecondGreyColor),
          ),
        ));
  }
}
