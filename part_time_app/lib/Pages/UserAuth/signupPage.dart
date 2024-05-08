import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:part_time_app/Pages/UserAuth/loginPage.dart';

import '../../Components/Button/primaryButtonComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

final _formKey = GlobalKey<FormState>();

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController userNicknameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  TextEditingController phoneControllerLogin = TextEditingController();
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'MY');
  String dialCode = '';
  String phone = '';
  String countryCode = '';
  String _responseMsgRegister = "";
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const SizedBox(
            width: 139.0, // <-- Your width
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
            height: 35,
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: Text(
              '注册',
              style: primaryTitleTextStyle,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const SizedBox(height: 10),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 7),
                    child: Text(
                      '用户昵称',
                      textAlign: TextAlign.left,
                      style: missionUsernameTextStyle,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  child: TextFormField(
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      hintText: '请输入用户昵称',
                      hintStyle: missionDetailText2,
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "用户名不能为空";
                        // return AppLocalizations.of(context)!
                        //     .valiUsernameNoEmpty;
                      } else if (value.length < 2) {
                        return "用户名至少需要2个字符";
                        // return AppLocalizations.of(context)!
                        //     .valiUsernameAtLeast3;
                      } else if (value.contains(RegExp(r'\s'))) {
                        return "用户不能包含空格";
                        // return AppLocalizations.of(context)!
                        //     .valiUsernameNoSpaceAllow;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 7),
                    child: Text(
                      '手机号码',
                      textAlign: TextAlign.left,
                      style: missionUsernameTextStyle,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
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
                          errorMessage: "手机号码不正确",
                          initialValue: phoneNumber,
                          textFieldController: phoneControllerLogin,
                          formatInput: true,
                          selectorConfig: const SelectorConfig(
                              showFlags: false,
                              selectorType: PhoneInputSelectorType.DIALOG),
                          onInputChanged: (PhoneNumber number) {
                            phone = number.phoneNumber.toString();
                            dialCode = number.dialCode.toString();
                            countryCode = number.isoCode.toString();
                          },
                          // autoValidateMode:
                          //     AutovalidateMode.onUserInteraction,
                          cursorColor: Colors.black,
                          inputDecoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1),
                              ),
                              filled: true,
                              fillColor: kDialogInputColor,
                              contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
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
                const SizedBox(height: 7.0),
                Container(
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 7),
                          child: Text(
                            '密码',
                            textAlign: TextAlign.left,
                            style: missionUsernameTextStyle,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        controller: passwordController,
                        obscureText: _obscureText1,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: SvgPicture.asset(
                              _obscureText1
                                  ? "assets/authentication/fluent_eye-open.svg"
                                  : "assets/authentication/fluent_eye-close.svg",
                              color: kMainGreyColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText1 = !_obscureText1;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          hintText: '请输入密码',
                          hintStyle: missionDetailText2,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '密码不能为空';
                          } else if (value.length < 8) {
                            return '密码至少需要8个字符';
                          } else if (!value.contains(RegExp(r'[A-Z]'))) {
                            return '密码必须包含至少一个大写字母';
                          } else if (!value.contains(RegExp(r'[a-z]'))) {
                            return '密码必须包含至少一个小写字母';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 7),
                          child: Text(
                            '确认密码',
                            textAlign: TextAlign.left,
                            style: missionUsernameTextStyle,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: _obscureText2,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: SvgPicture.asset(
                              _obscureText2
                                  ? "assets/authentication/fluent_eye-open.svg"
                                  : "assets/authentication/fluent_eye-close.svg",
                              color: kMainGreyColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText2 = !_obscureText2;
                              });
                            },
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          hintText: '请确认密码',
                          hintStyle: missionDetailText2,
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '密码不能为空';
                          } else if (value != passwordController.text) {
                            return '密码与确认密码不匹配';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 372,
                  height: 50.0,
                  child: primaryButtonComponent(
                    isLoading: false,
                    text: "提交",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, perform your actions
                        _formKey.currentState!.save();
                        // Perform actions with _password here
                      }
                    },
                    buttonColor: kMainYellowColor,
                    textStyle: missionDetailText1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: '已有账号?  ',
                    style: loginPageTextStyle1,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
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
                                      MediaQuery.of(context).size.height * 0.9,
                                  child: LoginPage(),
                                ));
                          },
                        );
                      }),
                TextSpan(
                    text: '登录',
                    style: loginPageTextStyle2,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
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
                                      MediaQuery.of(context).size.height * 0.9,
                                  child: LoginPage(),
                                ));
                          },
                        );
                      }),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    ));
  }
}
