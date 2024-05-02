import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Button/primaryButtonComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../Button/secondaryButtonComponent.dart';

class RejectReasonDialogComponent extends StatefulWidget {
  const RejectReasonDialogComponent({super.key});

  @override
  State<RejectReasonDialogComponent> createState() =>
      _RejectReasonDialogComponentState();
}

class _RejectReasonDialogComponentState
    extends State<RejectReasonDialogComponent> {
  int _selectedIndex = -1;
  bool _showTextField = false;
  List<String> buttonLabels = ['未根据指示完成任务', '恶意提交', '内容不完整', '其他'];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 351,
        height: _showTextField ? 500 : 450,
        decoration: BoxDecoration(
          color: kMainWhiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15, top: 15),
              child: Text(
                "拒绝任务理由",
                style: dialogText1,
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              height: 220, // Adjust the height as per your requirement
              child: ListView.builder(
                itemCount: buttonLabels.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      buttonLabels[index],
                      style: missionDetailText6,
                    ),
                    trailing: _selectedIndex == index
                        ? SvgPicture.asset("assets/button/selectedButton.svg")
                        : SvgPicture.asset(
                            "assets/button/unselectedButton.svg"),
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                        _showTextField = index == buttonLabels.length - 1;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 8),
            _showTextField
                ? Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    width: 291,
                    height: 100,
                    decoration: BoxDecoration(
                      color: kDialogInputColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: TextField(
                      style: missionCheckoutHintTextStyle,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "请输入拒绝理由",
                        hintStyle: missionDetailText2,
                        filled: true,
                        fillColor: kDialogInputColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: secondaryButtonComponent(
                text: "提交",
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Get.back();
                },
                buttonColor: kMainYellowColor,
                textStyle: buttonTextStyle2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
