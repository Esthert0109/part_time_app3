import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../Components/Card/missionCardComponent.dart';
import '../../Components/Selection/thirdStatusSelectionComponent.dart';
import '../../Constants/colorConstant.dart';

class MissionIssuedMainPage extends StatefulWidget {
  const MissionIssuedMainPage({super.key});

  @override
  State<MissionIssuedMainPage> createState() => _MissionIssuedMainPageState();
}

class _MissionIssuedMainPageState extends State<MissionIssuedMainPage> {
  int statusSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ThirdStatusSelectionComponent(
            statusList: const ['待审核', '未通过', '已通过', '已完成', '待退款', '已退款'],
            selectedIndex: statusSelected,
            onTap: (index) {
              setState(() {
                statusSelected = index;
              });
            }),
        Expanded(
          child: LazyLoadScrollView(
            onEndOfPage: () {
              print("load more");
            },
            child: RefreshIndicator(
              color: kMainYellowColor,
              onRefresh: () async {
                print("refresh everything");
                setState(() {
                  statusSelected = 0;
                });
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: List.generate(
                    15,
                    (index) => MissionCardComponent(
                      missionTitle: '文案写作文案写作文文案写作文案写作文文案写作文案写作文',
                      missionDesc:
                          '负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写，负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写，负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写，负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写，负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写',
                      tagList: ["写作", "写作", "写作", "写作", "写作", "写作", "写作", "写作"],
                      missionPrice: 886222.51,
                      userAvatar:
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNaT5SvBkYftSASmuj1yAmOFONXoWFqRlJ0mO7ZI_njw&s",
                      username: "微笑姐微笑姐",
                      missionDate: "2024-04-29",
                      isStatus: true,
                      isFavorite: false,
                      missionStatus: 0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
