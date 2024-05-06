import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Pages/Search/searchResultPage.dart';

import '../../Components/Button/primaryButtonComponent.dart';
import '../../Components/Selection/secondaryCategorySelectionComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class SortPage extends StatefulWidget {
  const SortPage({super.key});

  @override
  State<SortPage> createState() => _SortPageState();
}

Map<String, dynamic> sorts = {
  "工作期限": [
    {1, '短期'},
    {2, '长期'}
  ],
  "工作内容": [
    {3, '写作'},
    {4, '录入'},
    {5, '游戏'},
    {6, '发帖'},
    {7, '网页设计'},
    {8, '平面设计'}
  ],
  "工作性质": [
    {9, '新任务'},
    {10, '易审核'},
    {11, '高悬赏'}
  ],
};
List<int> selectedIndex = [];

class _SortPageState extends State<SortPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                scrolledUnderElevation: 0.0,
                surfaceTintColor: Colors.transparent,
                title: Text(
                  "悬赏详情",
                  textAlign: TextAlign.center,
                  style: dialogText2,
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 16,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                flex: 8,
                child: SecondaryCategorySelectionComponent(
                  sorts: sorts,
                ),
              ),
              Container(
                  padding:
                      EdgeInsets.only(bottom: 30, top: 5, left: 10, right: 10),
                  decoration: BoxDecoration(color: Colors.white),
                  width: double.infinity,
                  child: primaryButtonComponent(
                    text: "确认",
                    onPressed: () {
                      setState(() {
                        Get.to(
                            () => SearchResultPage(
                                  selectedTags: selectedIndexName,
                                  byTag: true,
                                ),
                            transition: Transition.rightToLeft);
                      });
                    },
                    buttonColor: kMainYellowColor,
                    textStyle: missionCheckoutTotalPriceTextStyle,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
