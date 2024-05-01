import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:part_time_app/Pages/Main/collectPage.dart';
import 'package:part_time_app/Pages/Main/collectPageTest.dart';
import '../../Components/Title/secondaryTitleComponent.dart';
import '../Main/RecommendationPage.dart';

class ExploreMainPage extends StatefulWidget {
  const ExploreMainPage({super.key});

  @override
  State<ExploreMainPage> createState() => _ExploreMainPageState();
}

class _ExploreMainPageState extends State<ExploreMainPage> {
  final PageController _controller = PageController();
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
                          _controller.animateToPage(index,
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.easeInOut);
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index) {
                  setState(() {
                    selectIndex = index;
                  });
                },
                children: [RecommendationPage(), CollectPage()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
