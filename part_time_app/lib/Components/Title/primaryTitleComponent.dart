import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class primaryTitleComponent extends StatefulWidget {
  final String text;

  const primaryTitleComponent({
    super.key,
    required this.text,
  });

  @override
  State<primaryTitleComponent> createState() => _primaryTitleComponentState();
}

class _primaryTitleComponentState extends State<primaryTitleComponent> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: primaryTitleTextStyle,
    );
  }
}
