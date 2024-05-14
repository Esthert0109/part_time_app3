import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:part_time_app/Pages/UserAuth/changePassword.dart';
import 'package:pinput/pinput.dart';

import '../../Components/Button/primaryButtonComponent.dart';
import '../../Components/Common/countdownTimer.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Services/User/userServices.dart';

class OtpCodePage extends StatefulWidget {
  final String phone;
  final int type;
  final int countdownTime;
  const OtpCodePage(
      {super.key,
      required this.phone,
      required this.type,
      required this.countdownTime});

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
  String errorDisplay = "";
  bool isError = false;
  bool isLoading = false;
  bool isFilled = false;
  bool isCountDown = true;

  // services
  UserServices services = UserServices();
  DateTime? countdown;

  void convertCountDownTime(int timestamp) {
    countdown = DateTime.fromMillisecondsSinceEpoch(timestamp);
    print("check: $countdown");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    convertCountDownTime(widget.countdownTime);
  }

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
                setState(() {
                  isFilled = true;
                });
              },
              onChanged: (value) {
                debugPrint('onChanged: $value');
                if (value.length < 4) {
                  setState(() {
                    isFilled = false;
                  });
                }
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
            isCountDown
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: CountdownTimer(
                        expiredDate: countdown!,
                        isReview: false,
                        isOTP: true,
                        onCountdownFinished: (finish) {
                          setState(() {
                            isCountDown = finish;
                          });
                        },
                      ),
                    ),
                  )
                : SizedBox(),
            const SizedBox(height: 30),
            isError
                ? Text(
                    "${errorDisplay}",
                    style: errorDisplayeTextStyle,
                  )
                : SizedBox(),
            const SizedBox(height: 40),
            SizedBox(
              width: 372,
              height: 50.0,
              child: primaryButtonComponent(
                isLoading: isLoading,
                text: "提交",
                onPressed: isFilled
                    ? () async {
                        setState(() {
                          isLoading = true;
                        });
                        await services
                            .verifyOTP(widget.phone, pinController.text, 1)
                            .then((value) {
                          if (value!.code != 0) {
                            setState(() {
                              isLoading = false;
                              isError = true;
                              errorDisplay = value.msg!;
                            });
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pop(context);
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              useSafeArea: true,
                              builder: (BuildContext context) {
                                return ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.9,
                                      child: ChangePasswordPage(),
                                    ));
                              },
                            );
                          }
                        });
                      }
                    : null,
                disableButtonColor: Color(0x69FFE457),
                buttonColor: kMainYellowColor,
                textStyle: isFilled ? missionDetailText1 : otpDisableTextStyle,
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
