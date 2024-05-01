import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Card/missionDetailDescriptionCardComponent.dart';
import 'package:part_time_app/Components/Card/missionDetailIssuerCardComponent.dart';
import 'package:part_time_app/Components/Card/missionNoticeCardComponent.dart';
import 'package:part_time_app/Components/Card/missionPublishCheckoutCardComponent.dart';
import 'package:part_time_app/Components/Title/thirdTitleComponent.dart';

import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class MissionDetailStatusIssuerPage extends StatefulWidget {
  const MissionDetailStatusIssuerPage({super.key});

  @override
  State<MissionDetailStatusIssuerPage> createState() =>
      _MissionDetailStatusIssuerPageState();
}

class _MissionDetailStatusIssuerPageState
    extends State<MissionDetailStatusIssuerPage> {
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
                text: "开始悬赏",
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
                    title: "文案写作文案写作文",
                    detail:
                        "负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写。负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写。负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写。",
                    tag: ["写作", "写作", "写作", "写作", "写作", "写作", "写作", "写作"],
                    totalSlot: "50",
                    leaveSlot: "45",
                    day: "3",
                    duration: "4",
                    date: "2024.04.30",
                    price: "50"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: MissionPublishCheckoutCardComponent(
                  isSubmit: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: missionNoticeCardComponent(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    RichText(
                        text: TextSpan(style: missionIDtextStyle, children: [
                      TextSpan(text: "悬赏ID: "),
                      TextSpan(text: "0292938DHFKAAUBCVAVC")
                    ])),
                    GestureDetector(
                      onTap: () {
                        print("copied");
                        Clipboard.setData(
                            ClipboardData(text: "0292938DHFKAAUBCVAVC"));
                        Fluttertoast.showToast(
                            msg: "已复制",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: kMainYellowColor,
                            textColor: kMainBlackColor);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: SvgPicture.asset(
                          "assets/mission/copy.svg",
                          width: 24,
                          height: 24,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
