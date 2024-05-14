import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../Components/Button/primaryButtonComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Services/User/userServices.dart';

class OtpCodePage extends StatefulWidget {
  final String phone;
  OtpCodePage({super.key, required this.phone});

  @override
  State<OtpCodePage> createState() => _OtpCodePageState();
}

class _OtpCodePageState extends State<OtpCodePage> {
  final _formKey = GlobalKey<FormState>();
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());

  // services
  UserServices services = UserServices();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      margin: EdgeInsets.only(left: 10, right: 10),
      width: 70,
      height: 70,
      textStyle: selectedSecondaryTitleTextStyle,
      decoration: BoxDecoration(
        color: kMainTextFieldGreyColor,
        borderRadius: BorderRadius.circular(8),
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const SizedBox(
              width: 139.0,
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
              height: 25,
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                '验证码验证',
                style: primaryTitleTextStyle,
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            const SizedBox(height: 10),
            Pinput(
              errorTextStyle: otpErrorTextStyle1,
              controller: pinController,
              focusNode: focusNode,
              autofocus: true,
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsUserConsentApi,
              listenForMultipleSmsOnAndroid: true,
              defaultPinTheme: defaultPinTheme,
              separatorBuilder: (index) => const SizedBox(width: 8),
              validator: (value) {
                return value == '2222' ? null : '   验证码错误';
              },
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) {
                debugPrint('onCompleted: $pin');
              },
              onChanged: (value) {
                debugPrint('onChanged: $value');
              },
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: kMainWhiteColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kMainYellowColor),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: kMainWhiteColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kMainYellowColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                color: kMainWhiteColor,
                border: Border.all(color: Colors.redAccent),
              )),
            ),
            const SizedBox(height: 70),
            SizedBox(
              width: 372,
              height: 50.0,
              child: primaryButtonComponent(
                isLoading: false,
                text: "提交",
                onPressed: () {

                  
                },
                buttonColor: kMainYellowColor,
                textStyle: missionDetailText1,
              ),
            ),
            SizedBox(
              height: 332,
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(text: '未收到验证码？', style: loginPageTextStyle1),
              TextSpan(
                  text: '再次发送',
                  style: loginPageTextStyle2,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      await services.sendOTP(widget.phone, 1);
                    })
            ]))
          ],
        ),
      ),
    );
  }
}
