import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';

class MissionReviewPage extends StatefulWidget {
  const MissionReviewPage({super.key});

  @override
  State<MissionReviewPage> createState() => _MissionReviewPageState();
}

class _MissionReviewPageState extends State<MissionReviewPage> {
  int totalMissionReview = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          actions: [
            GestureDetector(
              onTap: () {
                print("complain this mission");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: SvgPicture.asset(
                  "assets/mission/complaint.svg",
                  width: 16,
                  height: 14,
                ),
              ),
            )
          ],
          centerTitle: true,
          title: Container(
              color: kTransparent,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: thirdTitleComponent(
                text: "悬赏进度（${totalMissionReview.toString()}）",
              ))),
    );
  }
}
