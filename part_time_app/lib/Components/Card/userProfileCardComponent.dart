import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:part_time_app/Constants/colorConstant.dart';

import '../../Constants/textStyleConstant.dart';

class UserProfileCardComponent extends StatefulWidget {
  final String image;
  final String status;
  Function()? ontap;

  UserProfileCardComponent({
    super.key,
    required this.image,
    required this.status,
    this.ontap,
  });

  @override
  State<UserProfileCardComponent> createState() =>
      _UserProfileCardComponentState();
}

class _UserProfileCardComponentState extends State<UserProfileCardComponent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.ontap,
        child: Container(
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          height: 48,
          decoration: BoxDecoration(
            color: kMainWhiteColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.only(left: 20),
          child: Row(
            children: [
              SvgPicture.asset(
                widget.image,
                width: 24,
              ),
              SizedBox(width: 12),
              Text(
                widget.status,
                style: userProfileMenuTextStyle,
              ),
            ],
          ),
        ));
  }
}
