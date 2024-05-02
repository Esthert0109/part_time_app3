import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../Components/Button/primaryButtonComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class OtpCodePage extends StatefulWidget {
  const OtpCodePage({super.key});

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
  @override
  Widget build(BuildContext context) {
    const fillColor = Color.fromRGBO(243, 246, 249, 0);

    final defaultPinTheme = PinTheme(
      margin: EdgeInsets.all(10),
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
              controller: pinController,
              focusNode: focusNode,
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsUserConsentApi,
              listenForMultipleSmsOnAndroid: true,
              defaultPinTheme: defaultPinTheme,
              separatorBuilder: (index) => const SizedBox(width: 8),
              validator: (value) {
                return value == '2222' ? null : 'Pin is incorrect';
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
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
            // Form(
            //   key: _formKey,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: List.generate(4, (index) => buildOtpTextField(index)),
            //   ),
            // ),
            const SizedBox(height: 70),
            SizedBox(
              width: 372,
              height: 50.0,
              child: primaryButtonComponent(
                text: "提交",
                onPressed: () {},
                buttonColor: kMainYellowColor,
                textStyle: missionDetailText1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOtpTextField(int index) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextFormField(
        controller: _controllers[index],
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          filled: true,
          fillColor: kMainTextFieldGreyColor,
          counterText: "",
          hintStyle: TextStyle(fontSize: 24),
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kMainYellowColor, width: 2.0),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          errorMaxLines: 1,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter OTP';
          }
          return null;
        },
        onChanged: (value) {
          if (value.length == 1) {
            if (index < _controllers.length - 1) {
              FocusScope.of(context).nextFocus();
            } else {
              FocusScope.of(context).unfocus();
            }
          }
        },
      ),
    );
  }
}
