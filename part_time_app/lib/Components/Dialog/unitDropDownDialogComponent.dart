import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../Button/secondaryButtonComponent.dart';

typedef void StringCallback(String selectedString);

class unitDropDownDialogComponent extends StatefulWidget {
  final StringCallback callback;

  const unitDropDownDialogComponent({super.key, required this.callback});

  @override
  State<unitDropDownDialogComponent> createState() =>
      _unitDropDownDialogComponentState();
}

class _unitDropDownDialogComponentState
    extends State<unitDropDownDialogComponent> {
  int _selectedIndex = -1;
  List<String> buttonLabels = ['分钟', '小时', '天', '个月', '年'];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: kMainWhiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 310,
              child: ListView.builder(
                itemCount: buttonLabels.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      buttonLabels[index],
                      style: missionDetailText6,
                    ),
                    trailing: _selectedIndex == index
                        ? const Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.circle,
                                color: kMainYellowColor,
                              ),
                              Icon(
                                Icons.circle,
                                color: kMainBlackColor,
                                size: 12,
                              ),
                            ],
                          )
                        : const Icon(
                            Icons.circle_rounded,
                            color: kPaymentScreenShotColor,
                          ),
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                      widget.callback(buttonLabels[_selectedIndex]);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: secondaryButtonComponent(
                text: "提交",
                onPressed: () {
                  Navigator.pop(context);
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
