import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class primaryTextFieldComponent extends StatefulWidget {
  final String hintText;
  final Icon? suffixIcon;

  const primaryTextFieldComponent({
    super.key,
    required this.hintText,
    this.suffixIcon,
  });

  @override
  State<primaryTextFieldComponent> createState() =>
      _primaryTextFieldComponentState();
}

class _primaryTextFieldComponentState extends State<primaryTextFieldComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        child: TextField(
          style: primaryTextFieldTextStyle,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              hintText: widget.hintText,
              filled: true,
              fillColor: kMainTextFieldGreyColor,
              contentPadding: const EdgeInsetsDirectional.all(10),
              hintStyle: primaryTextFieldHintTextStyle,
              errorStyle: primaryTextFieldErrorTextStyle,
              suffixIcon: widget.suffixIcon,
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kMainRedColor))),
        ));
  }
}
