import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:part_time_app/Constants/globalConstant.dart';
import 'package:part_time_app/Pages/ComponentDisplayPage/componentExamplePage.dart';
import 'package:part_time_app/Pages/Explore/exploreMainPage.dart';
import 'package:part_time_app/Pages/Message/messageMainPage.dart';
import 'package:part_time_app/Pages/MissionIssuer/missionPublishMainPage.dart';
import 'package:part_time_app/Pages/MissionStatus/missionStatusMainPage.dart';
import 'package:part_time_app/Pages/UserProfile/userProfileMainPage.dart';
import 'package:part_time_app/Services/User/userServices.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';

import '../Constants/colorConstant.dart';
import '../Constants/textStyleConstant.dart';
import '../Model/User/userModel.dart';
import 'UserAuth/loginPage.dart';
import 'UserProfile/depositMainPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectionIndex = 0;
  double size = 24;

  UserServices service = UserServices();

  @override
  void initState() {
    super.initState();
  }

  fetchUserData() async {
    await service.getUserInfo();
    UserData? user = await SharedPreferencesUtils.getUserDataInfo()!;
    setState(() {
      userData = user;
    });
  }

  void homePageOnTap(int option) {
    if (option == 0 || option == 4 || isLogin) {
      setState(() {
        selectionIndex = option;
      });
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (BuildContext context) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: const LoginPage(),
              ));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchUserData();
    List<Widget> homePageOptions = <Widget>[
      ExploreMainPage(),
      MissionStatusMainPage(),
      userData?.validIdentity == 1
          ? MissionPublishMainPage(
              isEdit: false,
            )
          : DepositMainPage(
              isHome: true,
            ),
      MessageMainPage(),
      UserProfileMainPage()
    ];

    return Scaffold(
      body: Center(
        child: homePageOptions.elementAt(selectionIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kMainWhiteColor,
        currentIndex: selectionIndex,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        selectedItemColor: kMainBlackColor,
        unselectedItemColor: kMainBlackColor,
        selectedLabelStyle: bottomNaviBarTextStyle,
        unselectedLabelStyle: bottomNaviBarTextStyle,
        onTap: homePageOnTap,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: selectionIndex == 0
                  ? SvgPicture.asset(
                      "assets/bottomNaviBar/explore_selected.svg",
                      width: size,
                      height: size,
                    )
                  : SvgPicture.asset(
                      "assets/bottomNaviBar/explore_unselected.svg",
                      width: size,
                      height: size,
                    ),
              label: '发现'),
          BottomNavigationBarItem(
              icon: selectionIndex == 1
                  ? SvgPicture.asset(
                      "assets/bottomNaviBar/mission_selected.svg",
                      width: size,
                      height: size,
                    )
                  : SvgPicture.asset(
                      "assets/bottomNaviBar/mission_unselected.svg",
                      width: size,
                      height: size,
                    ),
              label: '悬赏'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/bottomNaviBar/publish.svg",
                width: 36,
                height: 36,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: selectionIndex == 3
                  ? SvgPicture.asset(
                      "assets/bottomNaviBar/message_selected.svg",
                      width: size,
                      height: size,
                    )
                  : SvgPicture.asset(
                      "assets/bottomNaviBar/message_unselected.svg",
                      width: size,
                      height: size,
                    ),
              label: '消息'),
          BottomNavigationBarItem(
              icon: selectionIndex == 4
                  ? SvgPicture.asset(
                      "assets/bottomNaviBar/user_selected.svg",
                      width: size,
                      height: size,
                    )
                  : SvgPicture.asset(
                      "assets/bottomNaviBar/user_unselected.svg",
                      width: size,
                      height: size,
                    ),
              label: '我的')
        ],
      ),
    );
  }
}
