import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:part_time_app/Components/Title/secondaryTitleComponent.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class UserProfileMainPage extends StatefulWidget {
  const UserProfileMainPage({super.key});

  @override
  State<UserProfileMainPage> createState() => _UserProfileMainPageState();
}

class _UserProfileMainPageState extends State<UserProfileMainPage> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Scaffold(
        body: Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            kBackgroundFirstGradientColor,
            kBackgroundSecondGradientColor
          ],
          stops: [0.0, 0.15],
        ),
      ),
      child: Column(
        children: [
          AppBar(
            title: Container(
              width: 120 * fem,
              height: 35 * fem,
              alignment: Alignment.center,
              child: InkWell(
                child: Stack(
                  children: [
                    SecondaryTitleComponent(
                      titleList: ["个人资料"],
                      selectedIndex: 0,
                      onTap: (int) {},
                    ),
                  ],
                ),
              ),
            ),
            actions: [],
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: ListTile(
                leading: SvgPicture.asset(
                  "assets/profile/profile_page.svg",
                  height: 58,
                  width: 58,
                ),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "金泰亨",
                      style: userProfileNameTextStyle,
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                        onTap: () {
                          Get.toNamed('/editProfile');
                        },
                        child:
                            SvgPicture.asset("assets/profile/edit_profile.svg"))
                  ],
                ),
                subtitle: const Text(
                  'UID: ' + '34693426720',
                  style: userProfileUIDTextStyle,
                ),
                trailing: InkWell(
                    onTap: () {},
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            '我的页面',
                            style: userProfileLinkTextStyle,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          SvgPicture.asset("assets/profile/right_chevron.svg")
                        ],
                      ),
                    )),
              )),
          SizedBox(height: 15),
          InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: kMainWhiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: SvgPicture.asset(
                          "assets/profile/verified_icon.svg",
                          height: 24,
                          width: 24,
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text(
                        "押金认证",
                        style: userProfileMenuTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: kMainWhiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: SvgPicture.asset(
                          "assets/profile/transaction_icon.svg",
                          height: 24,
                          width: 24,
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text(
                        "交易记录",
                        style: userProfileMenuTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: kMainWhiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: SvgPicture.asset(
                          "assets/profile/workorder_icon.svg",
                          height: 24,
                          width: 24,
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text(
                        "工单",
                        style: userProfileMenuTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: kMainWhiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: SvgPicture.asset(
                          "assets/profile/aboutus_icon.svg",
                          height: 24,
                          width: 24,
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text(
                        "关于我们",
                        style: userProfileMenuTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: kMainWhiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: SvgPicture.asset(
                          "assets/profile/settings_icon.svg",
                          height: 24,
                          width: 24,
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text(
                        "设置",
                        style: userProfileMenuTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
