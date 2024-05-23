import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class secondaryTextFieldComponent extends StatefulWidget {
  final String hintText;
  final Icon? suffixIcon;
  final TextEditingController inputController;
  final Function(String?) validator;

  const secondaryTextFieldComponent({
    super.key,
    required this.hintText,
    this.suffixIcon,
    required this.inputController,
    required this.validator,
  });

  @override
  State<secondaryTextFieldComponent> createState() =>
      _secondaryTextFieldComponentState();
}

class _secondaryTextFieldComponentState
    extends State<secondaryTextFieldComponent> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        // height: 31,
        child: Column(
      children: [
        TextFormField(
          controller: widget.inputController,
          style: secondaryTextFieldTextStyle,
          cursorColor: kMainYellowColor,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none),
            hintText: widget.hintText,
            filled: true,
            fillColor: kSecondTextFieldGreyColor,
            suffixIcon: widget.suffixIcon,
            contentPadding: const EdgeInsetsDirectional.only(
                start: 10, top: 4, bottom: 4, end: 10),
            hintStyle: secondaryTextFieldHintTextStyle,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return '请输入地址';
            }
            return null;
          },
        ),
      ],
    ));
  }
}
