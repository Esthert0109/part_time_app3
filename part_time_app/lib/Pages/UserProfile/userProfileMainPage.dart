import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../Components/Common/countdownTimer.dart';
import '../UserAuth/changePassword.dart';
import '../UserAuth/loginPage.dart';
import '../UserAuth/otpCode.dart';
import '../UserAuth/signupPage.dart';
import 'settingPage.dart';

class UserProfileMainPage extends StatefulWidget {
  const UserProfileMainPage({super.key});

  @override
  State<UserProfileMainPage> createState() => _UserProfileMainPageState();
}

class _UserProfileMainPageState extends State<UserProfileMainPage> {
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
          Container(
              child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => SettingPage());
                  },
                  child: Text("Setting"))),
        ],
      ),
    );
  }
}
