import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:part_time_app/Components/Card/userProfileCardComponent.dart';
import 'package:part_time_app/Components/Title/secondaryTitleComponent.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';
import 'package:part_time_app/Pages/UserProfile/aboutUsPage.dart';
import 'package:part_time_app/Pages/UserProfile/depositMainPage.dart';
import 'package:part_time_app/Pages/UserProfile/editProfilePage.dart';
import 'package:part_time_app/Pages/UserProfile/paymentHistoryPage.dart';
import 'package:part_time_app/Pages/UserProfile/settingPage.dart';
import 'package:part_time_app/Pages/UserProfile/ticketMainPage.dart';
import 'package:part_time_app/Pages/UserProfile/userProfilePage.dart';

import '../../Constants/globalConstant.dart';
import '../../Model/User/userModel.dart';
import '../../Utils/sharedPreferencesUtils.dart';

class UserProfileMainPage extends StatefulWidget {
  const UserProfileMainPage({super.key});

  @override
  State<UserProfileMainPage> createState() => _UserProfileMainPageState();
}

class _UserProfileMainPageState extends State<UserProfileMainPage> {
  getUserInfo() async {
    UserData? data = await SharedPreferencesUtils.getUserDataInfo()!;
    setState(() {
      userData = data!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SecondaryTitleComponent(
            titleList: ["个人资料"],
            selectedIndex: 0,
            onTap: (index) {},
          ),
        ),
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) {
          setState(() {});
        },
        children: <Widget>[
          Container(
            constraints: const BoxConstraints.expand(),
            // padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: kThirdGreyColor,
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: ListTile(
                        leading: userData?.avatar != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(29),
                                child: Image.network(
                                  userData!.avatar!,
                                  height: 58,
                                  width: 58,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : SvgPicture.asset(
                                "assets/profile/profile_page.svg",
                                height: 58,
                                width: 58,
                              ),
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                userData.nickname ?? "",
                                style: userProfileNameTextStyle,
                              ),
                            ),
                            const SizedBox(width: 20),
                            InkWell(
                                onTap: () {
                                  Get.to(() => EditProfilePage(),
                                      transition: Transition.rightToLeft);
                                },
                                child: SvgPicture.asset(
                                    "assets/profile/edit_profile.svg"))
                          ],
                        ),
                        subtitle: Text(
                          'UID: ${userData.customerId ?? ""}',
                          style: userProfileUIDTextStyle,
                        ),
                        trailing: InkWell(
                            onTap: () {
                              Get.to(
                                  () => UserProfilePage(
                                        isOthers: false,
                                        userID: userData.customerId,
                                      ),
                                  transition: Transition.rightToLeft);
                            },
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
                                  SvgPicture.asset(
                                      "assets/profile/right_chevron.svg")
                                ],
                              ),
                            )),
                      )),
                  SizedBox(height: 15),
                  UserProfileCardComponent(
                    image: "assets/profile/verified_icon.svg",
                    status: "押金认证",
                    ontap: () {
                      Get.to(() => DepositMainPage(),
                          transition: Transition.rightToLeft);
                    },
                  ),
                  UserProfileCardComponent(
                    image: "assets/profile/transaction_icon.svg",
                    status: "交易记录",
                    ontap: () {
                      Get.to(() => PaymentHistoryPage(),
                          transition: Transition.rightToLeft);
                    },
                  ),
                  UserProfileCardComponent(
                    image: "assets/profile/workorder_icon.svg",
                    status: "工单",
                    ontap: () {
                      Get.to(() => TicketMainPage(),
                          transition: Transition.rightToLeft);
                    },
                  ),
                  UserProfileCardComponent(
                    image: "assets/profile/aboutus_icon.svg",
                    status: "关于我们",
                    ontap: () {
                      Get.to(() => AboutUsPage(),
                          transition: Transition.rightToLeft);
                    },
                  ),
                  UserProfileCardComponent(
                    image: "assets/profile/settings_icon.svg",
                    status: "设置",
                    ontap: () {
                      Get.to(() => SettingPage(),
                          transition: Transition.rightToLeft);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
