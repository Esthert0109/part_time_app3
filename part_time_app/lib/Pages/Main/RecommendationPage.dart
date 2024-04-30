import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../Components/SearchBar/searchBarComponent.dart';
import '../../Components/Selection/primaryTagSelectionComponent.dart';
import '../../Constants/textStyleConstant.dart';

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SearchBarComponent(),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Image.asset("assets/main/banner.png"),
                  _buildCategoryComponent(),
                  Padding(
                      padding: EdgeInsets.only(top: 15, right: 120),
                      child: PrimaryTagSelectionComponent(
                        tagList: ["全部", "价格降序", "价格升序"],
                        selectedIndex: selectIndex,
                        onTap: (index) {
                          setState(() {
                            selectIndex = index;
                          });
                        },
                      ))
                ],
              ),
            ),
          ))
        ],
      ),
    ));
  }
}

Widget _buildCategoryComponent() {
  return Container(
    padding: EdgeInsets.only(top: 25),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: GestureDetector(
            child: Column(
              children: [
                SvgPicture.asset("assets/main/hightCom.svg"),
                SizedBox(height: 10),
                Text("高赏金", style: messageText1),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: GestureDetector(
            child: Column(
              children: [
                SvgPicture.asset("assets/main/shortTime.svg"),
                SizedBox(height: 10),
                Text("用时短", style: messageText1),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: GestureDetector(
            child: Column(
              children: [
                SvgPicture.asset("assets/main/easyGo.svg"),
                SizedBox(height: 10),
                Text("易审核", style: messageText1),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: GestureDetector(
            child: Column(
              children: [
                SvgPicture.asset("assets/main/newMission.svg"),
                SizedBox(height: 10),
                Text("新悬赏", style: messageText1),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
