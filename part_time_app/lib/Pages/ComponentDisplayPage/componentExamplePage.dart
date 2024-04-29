import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../Components/Card/missionCardComponent.dart';
import '../../Components/Card/missionReviewRecipientCardComponent.dart';
import '../../Components/SearchBar/searchBarComponent.dart';
import '../../Components/Selection/primaryTagSelectionComponent.dart';
import '../../Components/Selection/secondaryCategorySelectionComponent.dart';
import '../../Components/Selection/thirdStatusSelectionComponent.dart';
import '../../Components/Title/secondaryTitleComponent.dart';
import '../../Constants/textStyleConstant.dart';

class ComponentExample extends StatefulWidget {
  const ComponentExample({super.key});

  @override
  State<ComponentExample> createState() => _ComponentExampleState();
}

class _ComponentExampleState extends State<ComponentExample> {
  int selectIndex = 0;
  List<String> selectedCategory = [];
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SecondaryTitleComponent(
                titleList: ["推荐", "收藏", "我接收的", "我发布的", "发布悬赏"],
                selectedIndex: selectIndex,
                onTap: (index) {
                  setState(() {
                    selectIndex = index;
                  });
                },
              ),
              ThirdStatusSelectionComponent(
                statusList: ["待完成", "待审核", "未通过", "待到账", "已到账", "已退款"],
                selectedIndex: selectIndex,
                onTap: (index) {
                  setState(() {
                    selectIndex = index;
                  });
                },
              ),
              Row(
                children: [
                  Expanded(
                      flex: 8,
                      child: PrimaryTagSelectionComponent(
                        tagList: ["全部", "价格降序", "价格升序", "价格升序", "价格升序"],
                        selectedIndex: selectIndex,
                        onTap: (index) {
                          setState(() {
                            selectIndex = index;
                          });
                        },
                      )),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "64条相关",
                      style: unselectedTagTextStyle,
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
              const SearchBarComponent(),
              MissionReviewRecipientCardComponent(
                isReviewing: false,
                isCompleted: true,
                duration: "48:00:00",
                userAvatar:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkGXX7KS0tl9-flc6R2PR8D_2qHR-baQXsmeAGWix4pg&s',
                username: '新鲜哥',
              ),
              MissionReviewRecipientCardComponent(
                isReviewing: false,
                isCompleted: true,
                duration: "48:00:00",
                userAvatar:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNaT5SvBkYftSASmuj1yAmOFONXoWFqRlJ0mO7ZI_njw&s',
                username: '微笑姐',
              ),
              MissionReviewRecipientCardComponent(
                isReviewing: false,
                isCompleted: true,
                duration: "48:00:00",
                userAvatar:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkGXX7KS0tl9-flc6R2PR8D_2qHR-baQXsmeAGWix4pg&s',
                username: '新鲜哥',
              ),
              MissionCardComponent(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
