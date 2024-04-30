import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Components/Title/secondaryTitleComponent.dart';
import '../Main/RecommendationPage.dart';

class MissionStatusMainPage extends StatefulWidget {
  const MissionStatusMainPage({super.key});

  @override
  State<MissionStatusMainPage> createState() => _MissionStatusMainPageState();
}

class _MissionStatusMainPageState extends State<MissionStatusMainPage> {
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFCEEA5), Color(0xFFF9F9F9)],
            stops: [0.0, 0.15],
          ),
          color: Color(0xFFf8f8f8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 245.0),
              child: AppBar(
                backgroundColor: Colors.transparent,
                scrolledUnderElevation: 0.0,
                surfaceTintColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: EdgeInsets.only(top: 17),
                    child: SecondaryTitleComponent(
                      titleList: ["推荐", "收藏"],
                      selectedIndex: selectIndex,
                      onTap: (index) {
                        setState(() {
                          selectIndex = index;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: selectIndex == 0 ? RecommendationPage() : null,
            ),
          ],
        ),
      ),
    );
  }
}
