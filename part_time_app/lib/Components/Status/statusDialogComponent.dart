import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class StatusDialogComponent extends StatefulWidget {
  bool complete;
  StatusDialogComponent({super.key, required this.complete});

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
                      children: [
                        SizedBox(height: 25),
                        SvgPicture.asset("assets/status/submitSuccess.svg"),
                        SizedBox(height: 10),
                        Text(
                          "提交成功",
                          style: dialogText2,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "系统将审核你的内容，审核通过后将发布该悬赏。",
                          style: missionDetailText2,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        SvgPicture.asset("assets/status/submitFail.svg"),
                        Text("请完整悬赏详情"),
                      ],
                    ),
            ],
          ),
        ));
  }
}
