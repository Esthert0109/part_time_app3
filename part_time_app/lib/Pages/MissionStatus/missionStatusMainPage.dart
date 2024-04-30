import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:part_time_app/Pages/MissionStatus/missionAcceptedMainPage.dart';
import 'package:part_time_app/Pages/MissionStatus/missionIssuedMainPage.dart';

import '../../Components/Title/secondaryTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../Main/RecommendationPage.dart';

class MissionStatusMainPage extends StatefulWidget {
  const MissionStatusMainPage({super.key});

  @override
  State<MissionStatusMainPage> createState() => _MissionStatusMainPageState();
}

class _MissionStatusMainPageState extends State<MissionStatusMainPage> {
  final PageController _controller = PageController();
  int titleSelection = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
          title: Container(
        color: kTransparent,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SecondaryTitleComponent(
          titleList: ["我接收的", "我发布的"],
          selectedIndex: titleSelection,
          onTap: (index) {
            setState(() {
              titleSelection = index;
              _controller.animateToPage(index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            });
          },
        ),
      )),
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) {
          setState(() {
            titleSelection = index;
          });
        },
        children: <Widget>[
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
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
            child: MissionAcceptedMainPage(),
          ),
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
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
            child: MissionIssuedMainPage(),
          ),
        ],
      ),
    );
  }
}
