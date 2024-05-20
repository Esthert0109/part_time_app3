import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:part_time_app/Constants/globalConstant.dart';
import 'package:part_time_app/Pages/UserAuth/forgotPasswordPage.dart';
import 'package:part_time_app/Pages/UserAuth/signupPage.dart';
import 'package:part_time_app/Services/User/userServices.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';

import '../../Components/Button/primaryButtonComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/User/userModel.dart';
import '../Message/user/chatConfig.dart';
import '../Message/user/userMessagePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final _formKey = GlobalKey<FormState>();

class _LoginPageState extends State<LoginPage> {
  TextEditingController userNicknameController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmedPasswordController = TextEditingController();
  TextEditingController phoneControllerLogin = TextEditingController();
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'MY');
  String dialCode = '';
  String phone = '';
  String countryCode = '';
  String _responseMsgRegister = "";
  bool _obscureText = true;
  bool isLoading = false;

  // service
  UserModel? userLogin;
  UserData? userData;
  UserServices services = UserServices();
  bool isError = false;
  String errorDisplay = "";

  @override
  Widget build(BuildContext context) {
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
                    '登录',
                    style: primaryTitleTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 35,
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
                                textFieldController: phoneControllerLogin,
                                formatInput: true,
                                selectorConfig: SelectorConfig(
                                    showFlags: false,
                                    selectorType:
                                        PhoneInputSelectorType.DIALOG),
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
                      const SizedBox(height: 10.0),
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 7),
                            child: Text(
                              '密码',
                              textAlign: TextAlign.left,
                              style: missionCheckoutHintTextStyle,
                            ),
                          )),
                      const SizedBox(height: 5.0),
                      SizedBox(
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: SvgPicture.asset(
                                _obscureText
                                    ? "assets/authentication/fluent_eye-open.svg"
                                    : "assets/authentication/fluent_eye-close.svg",
                                color: kMainGreyColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: kErrorRedColor, width: 1),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF5F5F5),
                            hintText: '请输入密码',
                            hintStyle: missionDetailText2,
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none),
                          ),
                          validator: (value) {
                            print("check: $value");
                            if (value == null || value.isEmpty) {
                              return '密码不能为空';
                            } else if (value.length < 8) {
                              return '密码至少需要8个字符';
                            } else if (!value.contains(RegExp(r'[A-Z]'))) {
                              return '密码必须包含至少一个大写字母';
                            } else if (!value.contains(RegExp(r'[a-z]'))) {
                              return '密码必须包含至少一个小写字母';
                            } else if (!value.contains(RegExp(
                                r'[!@#\$%^&*()\[\]{}\-_=+\|\\:;\"\<>,./?~]'))) {
                              return '密码必须包含至少一个符号';
                            } else if (value.contains(RegExp(r'\s'))) {
                              return '密码不能包含空格';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                          padding: EdgeInsets.only(right: 7, top: 5),
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
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
                                        child: const ForgotPasswordPage(),
                                      ));
                                },
                              );
                            },
                            child: const Text(
                              "忘记密码",
                              style: missionNoticeBlackTextStyle,
                            ),
                          )),
                      isError
                          ? Text(
                              "${errorDisplay}",
                              style: errorDisplayeTextStyle,
                            )
                          : SizedBox(),
                      const SizedBox(height: 70),
                      SizedBox(
                        width: 372,
                        height: 50.0,
                        child: primaryButtonComponent(
                          isLoading: isLoading,
                          text: "提交",
                          disableButtonColor: buttonLoadingColor,
                          onPressed: () async {
                            // bool isLoginTencent =
                            //     await userTencentLogin('2206');

                            // if (isLoginTencent) {
                            //   Get.to(() => UserMessagePage(),
                            //       transition: Transition.rightToLeft);
                            //   // Navigate to another screen or do something else
                            // } else {
                            //   print("cannot");
                            // }

                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });

                              userLogin = await services
                                  .login(phone, passwordController.text)
                                  .then((value) async {
                                if (value!.code != 0) {
                                  setState(() {
                                    isError = true;
                                    isLoading = false;
                                    print("check ${value.msg}");
                                    errorDisplay = value.msg;
                                  });
                                } else {
                                  UserModel? user =
                                      await services.getUserInfo();

                                  Get.offAllNamed('/');
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              });
                            }
                          },
                          buttonColor: kMainYellowColor,
                          textStyle: missionDetailText1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 180),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: '未拥有账号?  ',
                          style: loginPageTextStyle1,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                useSafeArea: true,
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.9,
                                          child: const SignUpPage(),
                                        )),
                                  );
                                },
                              );
                            }),
                      TextSpan(
                          text: '注册',
                          style: loginPageTextStyle2,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                useSafeArea: true,
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.9,
                                          child: const SignUpPage(),
                                        )),
                                  );
                                },
                              );
                            }),
                    ],
                  ),
                ),
              ],
            )));
  }
}
