import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:part_time_app/Components/Button/primaryButtonComponent.dart';
import 'package:part_time_app/Components/TextField/primaryTextFieldComponent.dart';
import 'package:part_time_app/Components/Title/primaryTitleComponent.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ForgotPasswordPage {
  static void showForgotPasswordBottomSheet(BuildContext context) {
    final formKeyForgotPw = GlobalKey<FormState>();
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    PhoneNumber phoneNumber = PhoneNumber(isoCode: 'MY');
    String dialCode = '';
    String phone = '';
    String countryCode = '';
    TextEditingController phoneControllerLogin = TextEditingController();
    showModalBottomSheet(
      backgroundColor: kMainWhiteColor,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
            height: MediaQuery.of(context).size.height * 0.9,
            width: double.infinity,
            child: Column(
              children: <Widget>[
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
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const primaryTitleComponent(text: '忘记密码'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    // const SizedBox(
                    //   width: 11,
                    // ),
                    const Text(
                      '电话号码',
                      style: forgotPassTextStyle,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Form(
                  key: formKeyForgotPw,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Positioned(
                              child: SizedBox(
                                height: 50,
                                width: 347 * fem,
                                child: InternationalPhoneNumberInput(
                                  errorMessage: "无效的电话号码",
                                  initialValue: phoneNumber,
                                  textFieldController: phoneControllerLogin,
                                  formatInput: true,
                                  selectorConfig: const SelectorConfig(
                                      showFlags: false,
                                      selectorType:
                                          PhoneInputSelectorType.DROPDOWN),
                                  onInputChanged: (PhoneNumber number) {
                                    phone = number.phoneNumber.toString();
                                    dialCode = number.dialCode.toString();
                                    countryCode = number.isoCode.toString();
                                  },
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorColor: kMainBlackColor,
                                  inputDecoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 1.6),
                                    ),
                                    filled: true,
                                    fillColor: kMainTextFieldGreyColor,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        12 * fem, 0 * fem, 12 * fem, 0 * fem),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: '请输入电话号码',
                                    hintStyle: primaryTextFieldHintTextStyle,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                    width: double.infinity,
                    // padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: primaryButtonComponent(
                      isLoading: false,
                      text: '提交',
                      textStyle: forgotPassSubmitTextStyle,
                      buttonColor: kMainYellowColor,
                      onPressed: () {},
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
    // final formKeyForgotPw = GlobalKey<FormState>();
    // double baseWidth = 375;
    // double fem = MediaQuery.of(context).size.width / baseWidth;
    // PhoneNumber phoneNumber = PhoneNumber(isoCode: 'MY');
    // String dialCode = '';
    // String phone = '';
    // String countryCode = '';
    // TextEditingController phoneControllerLogin = TextEditingController();
    // showModalBottomSheet(
    //     backgroundColor: kMainWhiteColor,
    //     context: context,
    //     builder: (BuildContext context) {
    //       return Material(
    //           type: MaterialType.transparency,
    //           child:
    //               // Stack(
    //               //   children: [
    //               Container(
    //                   padding: const EdgeInsets.symmetric(
    //                       vertical: 20.0, horizontal: 20),
    //                   height: MediaQuery.of(context).size.height * 0.9,
    //                   width: MediaQuery.of(context).size.width,
    //                   child: Column(
    //                     children: [
    //                       const primaryTitleComponent(text: '忘记密码'),
    //                       const SizedBox(
    //                         height: 20,
    //                       ),
    //                       Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           const Text(
    //                             '电话号码',
    //                             style: forgotPassTextStyle,
    //                           ),
    //                           Form(
    //                             key: formKeyForgotPw,
    //                             child: Column(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: <Widget>[
    //                                 Row(
    //                                   children: <Widget>[
    //                                     Positioned(
    //                                       child: SizedBox(
    //                                         height: 50,
    //                                         width: 320 * fem,
    //                                         child:
    //                                             InternationalPhoneNumberInput(
    //                                           errorMessage: "无效的电话号码",
    //                                           initialValue: phoneNumber,
    //                                           textFieldController:
    //                                               phoneControllerLogin,
    //                                           formatInput: true,
    //                                           selectorConfig:
    //                                               const SelectorConfig(
    //                                                   showFlags: false,
    //                                                   selectorType:
    //                                                       PhoneInputSelectorType
    //                                                           .DROPDOWN),
    //                                           onInputChanged:
    //                                               (PhoneNumber number) {
    //                                             phone = number.phoneNumber
    //                                                 .toString();
    //                                             dialCode =
    //                                                 number.dialCode.toString();
    //                                             countryCode =
    //                                                 number.isoCode.toString();
    //                                           },
    //                                           autoValidateMode: AutovalidateMode
    //                                               .onUserInteraction,
    //                                           cursorColor: kMainBlackColor,
    //                                           inputDecoration: InputDecoration(
    //                                             errorBorder: OutlineInputBorder(
    //                                               borderRadius:
    //                                                   BorderRadius.circular(10),
    //                                               borderSide: const BorderSide(
    //                                                   color: Colors.red,
    //                                                   width: 1.6),
    //                                             ),
    //                                             filled: true,
    //                                             fillColor:
    //                                                 kMainTextFieldGreyColor,
    //                                             contentPadding:
    //                                                 EdgeInsets.fromLTRB(
    //                                                     12 * fem,
    //                                                     0 * fem,
    //                                                     12 * fem,
    //                                                     0 * fem),
    //                                             border: OutlineInputBorder(
    //                                                 borderRadius:
    //                                                     BorderRadius.circular(
    //                                                         8),
    //                                                 borderSide:
    //                                                     BorderSide.none),
    //                                             hintText: '请输入电话号码',
    //                                             hintStyle:
    //                                                 primaryTextFieldHintTextStyle,
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                           primaryButtonComponent(
    //                             text: '提交',
    //                             textStyle: forgotPassSubmitTextStyle,
    //                             buttonColor: kMainYellowColor,
    //                           )
    //                         ],
    //                       )
    //                     ],
    //                   ))
    //           //   ],
    //           // )
    //           );
    //     });
//   }
// }
