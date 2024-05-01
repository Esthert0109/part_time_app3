import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class thirdTitleComponent extends StatefulWidget {
  final String text;

  const thirdTitleComponent({
    super.key,
    required this.text,
  });

  @override
  State<thirdTitleComponent> createState() => _thirdTitleComponentState();
}

class _thirdTitleComponentState extends State<thirdTitleComponent> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: thirdTitleTextStyle,
    );
  }
}
