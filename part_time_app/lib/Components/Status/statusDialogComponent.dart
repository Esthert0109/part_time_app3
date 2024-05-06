import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:part_time_app/Components/Button/primaryButtonComponent.dart';
import 'package:part_time_app/Components/Button/secondaryButtonComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../Button/thirdButtonComponent.dart';

class StatusDialogComponent extends StatefulWidget {
  bool complete;
  Function() onTap;
  StatusDialogComponent(
      {super.key, required this.complete, required this.onTap});

  @override
  State<StatusDialogComponent> createState() => _StatusDialogComponentState();
}

class _StatusDialogComponentState extends State<StatusDialogComponent> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20),
          width: 351,
          height: widget.complete ? 286 : 269,
          decoration: BoxDecoration(
            color: kMainWhiteColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              widget.complete
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        SvgPicture.asset("assets/status/submitSuccess.svg"),
                        SizedBox(height: 10),
                        Text(
                          "提交成功",
                          style: dialogText2,
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            "系统将审核你的内容，审核通过后将发布该悬赏。",
                            style: missionDetailText2,
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: 291,
                          child: thirdButtonComponent(
                            text: "返回首页",
                            onPressed: widget.onTap,
                          ),
                        )
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(height: 25),
                        SvgPicture.asset("assets/status/submitFail.svg"),
                        SizedBox(height: 10),
                        Text(
                          "请完整悬赏详情",
                          style: dialogText2,
                        ),
                        SizedBox(height: 50),
                        Container(
                          width: 291,
                          child: thirdButtonComponent(
                            text: "继续编辑",
                            onPressed: widget.onTap,
                          ),
                        )
                      ],
                    ),
            ],
          ),
        ));
  }
}
