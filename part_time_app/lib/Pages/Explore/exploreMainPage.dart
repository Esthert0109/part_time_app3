import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Components/Title/secondaryTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../Main/RecommendationPage.dart';

class ExploreMainPage extends StatefulWidget {
  const ExploreMainPage({super.key});

  @override
  State<ExploreMainPage> createState() => _ExploreMainPageState();
}

class _ExploreMainPageState extends State<ExploreMainPage> {
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
            colors: [
              kBackgroundFirstGradientColor,
              kBackgroundSecondGradientColor
            ],
            stops: [0.0, 0.15],
          ),
          color: kInputBackGreyColor,
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
