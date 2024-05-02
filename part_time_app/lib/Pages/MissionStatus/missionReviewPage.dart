import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:part_time_app/Components/Card/missionReviewRecipientCardComponent.dart';

import '../../Components/Selection/primaryTagSelectionComponent.dart';
import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import 'missionReviewDetailPage.dart';

class MissionReviewPage extends StatefulWidget {
  const MissionReviewPage({super.key});

  @override
  State<MissionReviewPage> createState() => _MissionReviewPageState();
}

class _MissionReviewPageState extends State<MissionReviewPage> {
  int totalMissionReview = 0;
  int selectedStatusIndex = 0;
  int missionImcomplete = 2;
  int missionReviewing = 6;
  int missionCompleted = 9;
  bool isMissionFailed = true;

  calculateTotalMission() {
    totalMissionReview =
        missionImcomplete + missionReviewing + missionCompleted;
  }

  @override
  void initState() {
    super.initState();
    calculateTotalMission();
  }

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
                  text: "悬赏进度(${totalMissionReview.toString()})",
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: PrimaryTagSelectionComponent(
                  tagList: [
                    "待完成(${missionImcomplete.toString()})",
                    "待审核(${missionReviewing.toString()})",
                    "已完成(${missionCompleted.toString()})"
                  ],
                  selectedIndex: selectedStatusIndex,
                  onTap: (index) {
                    setState(() {
                      selectedStatusIndex = index;
                    });
                  },
                ),
              ),
              Expanded(
                child: LazyLoadScrollView(
                  onEndOfPage: () {
                    print("load more");
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                          10,
                          (index) => MissionReviewRecipientCardComponent(
                              isReviewing: false,
                              isCompleted: true,
                              duration: "240:00:00",
                              onTap: () {
                                Get.to(
                                    () => MissionReviewDetailPage(
                                          isCompleted: true,
                                        ),
                                    transition: Transition.rightToLeft);
                              },
                              userAvatar:
                                  "https://cf.shopee.tw/file/tw-11134201-7r98s-lrv9ysusrzlec9",
                              username: "鸡鸡鸡鸡鸡鸡鸡鸡鸡鸡鸡鸡鸡鸡鸡鸡鸡鸡鸡鸡")),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
