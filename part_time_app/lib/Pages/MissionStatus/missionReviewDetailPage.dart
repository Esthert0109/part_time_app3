import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Card/missionFailedReasonCardComponent.dart';
import 'package:part_time_app/Components/Card/missionSubmissionCardComponent.dart';

import '../../Components/Button/primaryButtonComponent.dart';
import '../../Components/Card/missionDetailDescriptionCardComponent.dart';
import '../../Components/Card/missionDetailIssuerCardComponent.dart';
import '../../Components/Dialog/alertDialogComponent.dart';
import '../../Components/Dialog/rejectReasonDialogComponent.dart';
import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class MissionReviewDetailPage extends StatefulWidget {
  final bool isCompleted;
  const MissionReviewDetailPage({super.key, required this.isCompleted});

  @override
  State<MissionReviewDetailPage> createState() =>
      _MissionReviewDetailPageState();
}

class _MissionReviewDetailPageState extends State<MissionReviewDetailPage> {
  bool isFavourite = false;
  bool isMissionFailed = true;

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
                  ),
                  MissionSubmissionCardComponent(
                    isEdit: false,
                    submissionPics: [
                      "https://cf.shopee.tw/file/tw-11134201-7r98s-lrv9ysusrzlec9",
                      "https://img.biggo.com/01mTTg9SjvnNQulIQRSz4oBNPjMqWuD3o3cjyhg37Ac/fit/0/0/sm/1/aHR0cHM6Ly90c2hvcC5yMTBzLmNvbS84N2QvYzQzLzJhMjgvZWEzZC9jMDA3LzhhM2QvYzMyZS8xMTg0ZWVhNzI0MDI0MmFjMTEwMDA0LmpwZw.jpg",
                      "https://img.feebee.tw/i/oAbGGHUxE2jJlIURo-Sd2gc-NEeaMhE980abq5vNsT8/372/aHR0cHM6Ly9jZi5zaG9wZWUudHcvZmlsZS9zZy0xMTEzNDIwMS03cmNjNy1sdHMzamVscTI3eGg4NA.webp"
                    ],
                  ),
                  (widget.isCompleted && isMissionFailed)
                      ? Container(
                          width: double.infinity,
                          child: missionFailedReasonCardComponent(
                              reasonTitle: "拒绝理由",
                              reasonDesc:
                                  "评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价"),
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        RichText(
                            text: TextSpan(
                                style: missionIDtextStyle,
                                children: [
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
                                backgroundColor: kMainGreyColor,
                                textColor: kThirdGreyColor);
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
          bottomNavigationBar: Container(
              height: 84,
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(color: kMainWhiteColor, boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000),
                  offset: Offset(1, 0),
                  blurRadius: 2,
                  spreadRadius: 0,
                ),
              ]),
              child: widget.isCompleted
                  ? SizedBox(
                      width: double.infinity,
                      child: primaryButtonComponent(
                        buttonColor: kMainYellowColor,
                        disableButtonColor: kThirdGreyColor,
                        text: '已通过',
                        textStyle: disableButtonTextStyle,
                        onPressed: null,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: primaryButtonComponent(
                            buttonColor: kRejectMissionButtonColor,
                            text: '拒绝',
                            textStyle: missionRejectButtonTextStyle,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialogComponent(
                                      alertTitle: '您是否确认拒绝该悬赏提交',
                                      alertDesc: RichText(
                                        text: TextSpan(
                                          style: alertDialogContentTextStyle,
                                          children: [
                                            TextSpan(text: '该用户的悬赏提交将被拒绝,\n'),
                                            TextSpan(
                                                text: '赏金将不被发放。\n',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            TextSpan(text: '是否继续？'),
                                          ],
                                        ),
                                      ),
                                      descTextStyle:
                                          alertDialogContentTextStyle,
                                      firstButtonText: '返回',
                                      firstButtonTextStyle:
                                          alertDialogFirstButtonTextStyle,
                                      firstButtonColor: kThirdGreyColor,
                                      secondButtonText: '拒绝',
                                      secondButtonTextStyle:
                                          alertDialogRejectButtonTextStyle,
                                      secondButtonColor:
                                          kRejectMissionButtonColor,
                                      isButtonExpanded: true,
                                      firstButtonOnTap: () {
                                        setState(() {
                                          Navigator.pop(context);
                                        });
                                      },
                                      secondButtonOnTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return RejectReasonDialogComponent();
                                          },
                                        );
                                      },
                                    );
                                  });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: primaryButtonComponent(
                            buttonColor: kMainYellowColor,
                            text: '通过',
                            textStyle: missionDetailText1,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialogComponent(
                                      alertTitle: '您是否确认通过该悬赏提交',
                                      alertDesc: RichText(
                                        text: TextSpan(
                                          style: alertDialogContentTextStyle,
                                          children: [
                                            TextSpan(text: '该用户的悬赏提交将被通过,\n'),
                                            TextSpan(
                                                text: '赏金将发放给该用户。\n',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            TextSpan(text: '是否继续？'),
                                          ],
                                        ),
                                      ),
                                      descTextStyle:
                                          alertDialogContentTextStyle,
                                      firstButtonText: '返回',
                                      firstButtonTextStyle:
                                          alertDialogFirstButtonTextStyle,
                                      firstButtonColor: kThirdGreyColor,
                                      secondButtonText: '通过',
                                      secondButtonTextStyle:
                                          alertDialogSecondButtonTextStyle,
                                      secondButtonColor: kMainYellowColor,
                                      isButtonExpanded: true,
                                      firstButtonOnTap: () {
                                        setState(() {
                                          Navigator.pop(context);
                                        });
                                      },
                                      secondButtonOnTap: () {
                                        Navigator.pop(context);
                                        Get.back();
                                      },
                                    );
                                  });
                            },
                          ),
                        ),
                      ],
                    ))),
    );
  }
}
