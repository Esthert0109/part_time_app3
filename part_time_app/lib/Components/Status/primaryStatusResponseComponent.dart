import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Pages/UserAuth/loginPage.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../Button/primaryButtonComponent.dart';

class PrimaryStatusBottomSheetComponent {
  static void show(BuildContext context, bool needButton) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context, // Set isScrollControlled to true
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  width: 150,
                  height: 5.0,
                  child: ElevatedButton(
                    onPressed: null,
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll((Color(0xFFF0F0F0)))),
                    child: Text(' '),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Container(
                  width: 200,
                  child: SvgPicture.asset(
                    "assets/status/successfulMark.svg",
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Text(
                  needButton ? "密码修改成功" : "验证码验证成功",
                  // AppLocalizations.of(context)!.statusSuccessful,
                  style: tStatusFieldText,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  needButton ? "您的密码已修改" : "您的账号已注册",
                  style: tStatusFieldText1,
                ),
                const SizedBox(
                  height: 100,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: 351,
                      child: needButton
                          ? primaryButtonComponent(
                              isLoading: false,
                              onPressed: () {
                                Navigator.pop(context);
                                Get.offAllNamed("/onboarding");
                              },
                              text: "重新登入",
                              buttonColor: kMainYellowColor,
                              textStyle: buttonTextStyle,
                            )
                          : null,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
