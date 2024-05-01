import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class secondaryTextFieldComponent extends StatefulWidget {
  final String hintText;
  final Icon? suffixIcon;

  const secondaryTextFieldComponent({
    super.key,
    required this.hintText,
    this.suffixIcon,
  });

  @override
  State<secondaryTextFieldComponent> createState() =>
      _secondaryTextFieldComponentState();
}

class _secondaryTextFieldComponentState
    extends State<secondaryTextFieldComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 31,
        child: TextField(
          style: secondaryTextFieldTextStyle,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none),
            hintText: widget.hintText,
            filled: true,
            fillColor: kSecondTextFieldGreyColor,
            suffixIcon: widget.suffixIcon,
            contentPadding: const EdgeInsetsDirectional.only(
                start: 10, top: 8, bottom: 8, end: 10),
            hintStyle: secondaryTextFieldHintTextStyle,
          ),
        ));
  }
}
