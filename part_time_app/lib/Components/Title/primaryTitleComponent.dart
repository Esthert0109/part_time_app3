import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class primaryTitleComponent extends StatelessWidget {
  final String text;

  const primaryTitleComponent({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 30, fontWeight: FontWeight.w700, color: kMainBlackColor),
    );
  }
}
