import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:part_time_app/Pages/Explore/collectPage.dart';
import 'package:part_time_app/Pages/Explore/collectPageTest.dart';
import '../../Components/Title/secondaryTitleComponent.dart';
import 'RecommendationPage.dart';

import '../../Components/Title/secondaryTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import 'RecommendationPage.dart';

class ExploreMainPage extends StatefulWidget {
  const ExploreMainPage({super.key});

  @override
  State<ExploreMainPage> createState() => _ExploreMainPageState();
}

class _ExploreMainPageState extends State<ExploreMainPage>
    with AutomaticKeepAliveClientMixin {
  final PageController _controller = PageController();
  int selectIndex = 0;
  List<double> scrollPositions = [0.0, 0.0];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            color: kTransparent,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: SecondaryTitleComponent(
              titleList: ["推荐", "收藏"],
              selectedIndex: selectIndex,
              onTap: (index) {
                setState(() {
                  selectIndex = index;
                  _controller.animateToPage(index,
                      duration: Duration(milliseconds: 600),
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
            selectIndex = index;
          });
        },
        children: <Widget>[
          Container(
            constraints: const BoxConstraints.expand(),
            padding: const EdgeInsets.all(12),
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
            child: const RecommendationPage(),
          ),
          Container(
            constraints: const BoxConstraints.expand(),
            padding: const EdgeInsets.all(12),
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
            child: const CollectPage(),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
