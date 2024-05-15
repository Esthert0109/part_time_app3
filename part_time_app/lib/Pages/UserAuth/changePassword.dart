import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Model/User/userModel.dart';
import 'package:part_time_app/Services/User/userServices.dart';

import '../../Components/Button/primaryButtonComponent.dart';
import '../../Components/Status/primaryStatusResponseComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class ChangePasswordPage extends StatefulWidget {
  final String phone;
  const ChangePasswordPage({super.key, required this.phone});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool isLoading = false;

  // services
  UserServices services = UserServices();
  CheckOTPModel? changePasswordModel;

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
                    '修改密码',
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
                      const SizedBox(height: 5.0),
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
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 1),
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
                            const SizedBox(height: 30.0),
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
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 1),
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
                      const SizedBox(height: 70),
                      SizedBox(
                        width: 372,
                        height: 50.0,
                        child: primaryButtonComponent(
                          isLoading: isLoading,
                          text: "提交",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, perform your actions
                              _formKey.currentState!.save();
                              setState(() {
                                isLoading = true;
                              });
                              // Perform actions with _password here
                              try {
                                changePasswordModel =
                                    await services.updatePassword(
                                        widget.phone, passwordController.text);

                                if (changePasswordModel == null) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: "修改失败",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: kErrorRedColor,
                                      textColor: kMainWhiteColor);
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pop(context);
                                  PrimaryStatusBottomSheetComponent.show(
                                      context, true);
                                }
                              } catch (e) {
                                Fluttertoast.showToast(
                                    msg: "修改失败",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: kErrorRedColor,
                                    textColor: kMainWhiteColor);
                                print("error change password page: $e");
                              }
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
              ],
            )));
  }
}
