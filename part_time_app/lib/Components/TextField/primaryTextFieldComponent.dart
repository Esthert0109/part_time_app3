import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class primaryTextFieldComponent extends StatelessWidget {
  final String hintText;
  final Icon suffixIcon;

  const primaryTextFieldComponent({
    Key? key,
    required this.hintText,
    required this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        margin: const EdgeInsets.only(left: 12, right: 12),
        width: screenWidth,
        height: 40,
        child: TextField(
          style: const TextStyle(
              color: kMainBlackColor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              hintText: hintText,
              filled: true,
              fillColor: kMainTextFieldGreyColor,
              contentPadding: const EdgeInsetsDirectional.all(10),
              hintStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: kSecondGreyColor),
              errorStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: kMainRedColor),
              suffixIcon: suffixIcon,
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kMainRedColor))),
        ));
  }
}
