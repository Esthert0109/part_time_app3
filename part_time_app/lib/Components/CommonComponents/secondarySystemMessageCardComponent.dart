import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class secondarySystemMessageCardComponent extends StatelessWidget {
  final String messageTitle;
  final String messageContent;

  const secondarySystemMessageCardComponent({
    Key? key,
    required this.messageTitle,
    required this.messageContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      margin: const EdgeInsets.only(left: 12, right: 12),
      elevation: 0,
      child: Container(
          width: screenWidth,
          padding: const EdgeInsetsDirectional.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: kMainWhiteColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                messageTitle,
                style: const TextStyle(
                    color: kMainBlackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 12),
              Text(
                messageContent,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: kMainGreyColor),
              ),
              SvgPicture.asset(
                "assets/report/report_image.svg",
              ),
            ],
          )),
    );
  }
}
