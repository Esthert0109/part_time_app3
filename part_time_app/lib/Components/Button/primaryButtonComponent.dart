import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class primaryButtonComponent extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? buttonColor;
  final Color? disableButtonColor;
  final TextStyle textStyle;
  final int? buttonStatus;

  const primaryButtonComponent({
    super.key,
    required this.text,
    this.onPressed,
    this.buttonColor,
    this.disableButtonColor,
    required this.textStyle,
    this.buttonStatus,
  });

  @override
  State<primaryButtonComponent> createState() => _primaryButtonComponentState();
}

class _primaryButtonComponentState extends State<primaryButtonComponent> {

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 46,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.buttonColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
            disabledBackgroundColor: widget.disableButtonColor,
          ),
          onPressed: widget.onPressed,
          child: Text(
            widget.text,
            style: widget.textStyle,
          ),
        ));
  }
}
