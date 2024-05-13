import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../Components/Button/primaryButtonComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

final _formKey = GlobalKey<FormState>();

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController phoneController = TextEditingController();
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'MY');
  String dialCode = '';
  String phone = '';
  String countryCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
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
              height: 29,
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                '忘记密码',
                style: primaryTitleTextStyle,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 7),
                        child: Text(
                          '电话号码',
                          textAlign: TextAlign.left,
                          style: missionCheckoutHintTextStyle,
                        ),
                      )),
                  const SizedBox(height: 5.0),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Container(
                        child: Stack(children: [
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(12, 0, 12, 15),
                          width: 70,
                          height: 48,
                          decoration: BoxDecoration(
                            color: kDialogInputColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('     '),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          child: InternationalPhoneNumberInput(
                            errorMessage: "请正确的电话号码",
                            initialValue: phoneNumber,
                            textFieldController: phoneController,
                            formatInput: true,
                            selectorConfig: SelectorConfig(
                                showFlags: false,
                                selectorType: PhoneInputSelectorType.DIALOG),
                            onInputChanged: (PhoneNumber number) {
                              phone = number.phoneNumber.toString();
                              dialCode = number.dialCode.toString();
                              countryCode = number.isoCode.toString();
                            },
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            cursorColor: Colors.black,
                            inputDecoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: kErrorRedColor, width: 1),
                                ),
                                filled: true,
                                fillColor: kDialogInputColor,
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 0, 12, 0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                hintText: "请输入电话号码",
                                hintStyle: missionDetailText2),
                          ),
                        ),
                      ),
                    ])),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: primaryButtonComponent(
                      isLoading: false,
                      text: '提交',
                      textStyle: forgotPassSubmitTextStyle,
                      buttonColor: kMainYellowColor,
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
