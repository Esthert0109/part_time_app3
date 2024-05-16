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

Map<String, List<Map<String, dynamic>>> sorts = {
  "工作期限": [
    {"id": 1, "name": '短期'},
    {"id": 2, "name": '长期'}
  ],
  "工作内容": [
    {"id": 3, "name": '写作'},
    {"id": 4, "name": '录入'},
    {"id": 5, "name": '游戏'},
    {"id": 6, "name": '发帖'},
    {"id": 7, "name": '网页设计'},
    {"id": 8, "name": '平面设计'}
  ],
  "工作性质": [
    {"id": 9, "name": '新任务'},
    {"id": 10, "name": '易审核'},
    {"id": 11, "name": '高悬赏'}
  ],
};

class _SortPageState extends State<SortPage> {
  List<int> selectedIndex = [];
  List<String> selectedIndexName = [];
  void updateSelectedIndex(List<int> newSelectedIndex) {
    setState(() {
      selectedIndex = newSelectedIndex;
    });
  }

  void updateSelectedIndexName(List<String> newSelectedIndexName) {
    setState(() {
      selectedIndexName = newSelectedIndexName;
    });
  }

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
                  child: SingleChildScrollView(
                    child: SecondaryCategorySelectionComponent(
                      sorts: sorts,
                      onSelectedIndicesChanged: updateSelectedIndex,
                      onSelectedNameChanged: updateSelectedIndexName,
                    ),
                  )),
              Container(
                  padding:
                      EdgeInsets.only(bottom: 30, top: 5, left: 10, right: 10),
                  decoration: BoxDecoration(color: Colors.white),
                  width: double.infinity,
                  child: primaryButtonComponent(
                    isLoading: false,
                    text: "确认",
                    onPressed: () {
                      setState(() {
                        Get.to(
                            () => SearchResultPage(
                                  selectedTags: selectedIndex,
                                  selectedTagsName: selectedIndexName,
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
