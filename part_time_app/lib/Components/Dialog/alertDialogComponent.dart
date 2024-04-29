import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';

import '../../Constants/textStyleConstant.dart';

class AlertDialogComponent extends StatefulWidget {
  const AlertDialogComponent({super.key});

  @override
  State<AlertDialogComponent> createState() => _AlertDialogComponentState();
}

class _AlertDialogComponentState extends State<AlertDialogComponent> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: kMainWhiteColor,
      surfaceTintColor: kMainWhiteColor,
      title: Text(
        "提交前请检查",
      ),
      titleTextStyle: alertDialogTitleTextStyle,
      content: Text(
        "是否从相册选择了正确的截图 截图是否符合悬赏要求",
        style: alertDialogContentTextStyle,
      ),
      contentTextStyle: alertDialogContentTextStyle,
      actions: [
        
      ],
    );
  }
}
