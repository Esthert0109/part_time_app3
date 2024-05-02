import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:part_time_app/Components/Button/primaryButtonComponent.dart';
import 'package:part_time_app/Components/Card/missionPublishCheckoutCardComponent.dart';
import 'package:part_time_app/Components/TextField/primaryTextFieldComponent.dart';
import 'package:part_time_app/Components/TextField/secondaryTextFieldComponent.dart';
import 'package:part_time_app/Pages/UserAuth/changePassword.dart';
import 'package:part_time_app/Pages/UserAuth/loginPage.dart';
import 'package:part_time_app/Pages/UserAuth/otpCode.dart';
import 'package:part_time_app/Pages/UserAuth/signupPage.dart';

import '../../Constants/textStyleConstant.dart';

class MessageMainPage extends StatefulWidget {
  const MessageMainPage({super.key});

  @override
  State<MessageMainPage> createState() => _MessageMainPageState();
}

class _MessageMainPageState extends State<MessageMainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 50),
          Container(
              child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      builder: (BuildContext context) {
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.9,
                              child: LoginPage(),
                            ));
                      },
                    );
                  },
                  child: Text("Login"))),
          SizedBox(height: 30),
          Container(
              child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      builder: (BuildContext context) {
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.9,
                              child: SignUpPage(),
                            ));
                      },
                    );
                  },
                  child: Text("Sign Up"))),
          primaryTextFieldComponent(hintText: "asdasd"),
          secondaryTextFieldComponent(hintText: "asdasdas"),
          Container(
              child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      builder: (BuildContext context) {
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.9,
                              child: ChangePasswordPage(),
                            ));
                      },
                    );
                  },
                  child: Text("Change Password"))),
          Container(
              child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      builder: (BuildContext context) {
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.9,
                              child: OtpCodePage(),
                            ));
                      },
                    );
                  },
                  child: Text("OTP Code"))),
        ],
      ),
    );
  }
}
