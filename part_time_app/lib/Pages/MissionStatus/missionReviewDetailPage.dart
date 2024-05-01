import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/Card/missionDetailDescriptionCardComponent.dart';
import '../../Components/Card/missionDetailIssuerCardComponent.dart';
import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';

class MissionReviewDetailPage extends StatefulWidget {
  const MissionReviewDetailPage({super.key});

  @override
  State<MissionReviewDetailPage> createState() =>
      _MissionReviewDetailPageState();
}

class _MissionReviewDetailPageState extends State<MissionReviewDetailPage> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0.0,
            leading: IconButton(
              iconSize: 15,
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Get.back();
              },
            ),
            centerTitle: true,
            title: Container(
                color: kTransparent,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: thirdTitleComponent(
                  text: "悬赏详情",
                ))),
        body: Container(
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MissionDetailIssuerCardComponent(
                    image:
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9MU4SwesBOo_JPNEelanllG_YX_v4OWhdffpsPc0Gow&s",
                    title: "墩墩鸡",
                    action: "留言咨询 >",
                    onTap: () {}),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: MissionDetailDescriptionCardComponent(
                    title:
                        "文案写作文案写作文文案写作文文案写作文案写作文文案写作文文案写作文案写作文文案写作文文案写作文案写作文文案写作文文案写作文案写作文文案写作文文案写作文案写作文文案写作文",
                    detail:
                        "负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写。负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写。负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写。",
                    tag: ["写作", "写作", "写作", "写作", "写作", "写作", "写作", "写作"],
                    totalSlot: "50",
                    leaveSlot: "45",
                    day: "3",
                    duration: "4",
                    date: "2024.04.30",
                    price: "50",
                    isFavourite: isFavourite,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
