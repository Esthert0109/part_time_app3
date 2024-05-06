import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Card/missionFailedReasonCardComponent.dart';

import '../../Components/Button/primaryButtonComponent.dart';
import '../../Components/Card/missionDetailDescriptionCardComponent.dart';
import '../../Components/Card/missionDetailIssuerCardComponent.dart';
import '../../Components/Card/missionDetailStepsCardComponent.dart';
import '../../Components/Card/missionNoticeCardComponent.dart';
import '../../Components/Card/missionSubmissionCardComponent.dart';
import '../../Components/Dialog/alertDialogComponent.dart';
import '../../Components/Status/statusDialogComponent.dart';
import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../MissionIssuer/missionDetailStatusIssuerPage.dart';
import 'recipientInfoPage.dart';

class MissionDetailRecipientPage extends StatefulWidget {
  final bool isStarted;
  final bool isSubmitted;
  final bool isExpired;
  final bool isWaitingPaid;
  final bool isPaid;
  final bool isFailed;
  const MissionDetailRecipientPage(
      {super.key,
      required this.isStarted,
      required this.isSubmitted,
      required this.isExpired,
      required this.isWaitingPaid,
      required this.isFailed,
      required this.isPaid});

  @override
  State<MissionDetailRecipientPage> createState() =>
      _MissionDetailRecipientPageState();
}

//
// yet started
// Mission Detail Steps Card Component (Not foldable)
//
// started
// No Mission Notice Card Component
// Use Mission Detail Steps Card Component (foldable, default as not folded)
// Use Mission Submission Card Component (not foldable, editable)
//
// submitted
// Use Mission Detail Steps Card Component (foldable, default as folded)
// Use Mission Submission Card Component (foldable, not editable)
//
// expired
// Use Mission Detail Steps Card Component (foldable, default as folded)
// Use Mission Submission Card Component (foldable, not editable)
//
// waiting for paid
// Use Mission Detail Steps Card Component (foldable, default as folded)
// Use Mission Submission Card Component (foldable, not editable, default as folded)
//
// paid
// Use Mission Detail Steps Card Component (foldable, default as folded)
// Use Mission Submission Card Component (foldable, not editable, default as folded)
//
// failed
// Use Mission Detail Steps Card Component (foldable, default as folded)
// Use Mission Submission Card Component (foldable, not editable, default as folded)
//

class _MissionDetailRecipientPageState
    extends State<MissionDetailRecipientPage> {
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
            actions: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: SvgPicture.asset(
                    "assets/mission/complaint.svg",
                    width: 24,
                    height: 24,
                  ),
                ),
              )
            ],
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: MissionDetailIssuerCardComponent(
                      image:
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9MU4SwesBOo_JPNEelanllG_YX_v4OWhdffpsPc0Gow&s",
                      title: "墩墩鸡",
                      action: "留言咨询 >",
                      onTap: () {}),
                ),
                MissionDetailDescriptionCardComponent(
                  title: "文案写作文案写作文",
                  detail:
                      "负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写。负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写。负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写。",
                  tag: ["写作", "写作", "写作", "写作", "写作", "写作", "写作", "写作"],
                  totalSlot: "50",
                  leaveSlot: "45",
                  day: "3",
                  duration: "4",
                  date: "2024.04.30",
                  price: "50",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: missionDetailStepsCardComponent(
                    steps: mockData,
                    isConfidential: true,
                    isCollapsed: (widget.isSubmitted ||
                            widget.isExpired ||
                            widget.isFailed ||
                            widget.isWaitingPaid ||
                            widget.isPaid)
                        ? false
                        : true,
                    isCollapseAble: (widget.isSubmitted ||
                            widget.isExpired ||
                            widget.isFailed ||
                            widget.isWaitingPaid ||
                            widget.isPaid)
                        ? true
                        : false,
                  ),
                ),
                (widget.isStarted ||
                        widget.isSubmitted ||
                        widget.isExpired ||
                        widget.isFailed ||
                        widget.isWaitingPaid ||
                        widget.isPaid)
                    ? MissionSubmissionCardComponent(
                        isEdit: widget.isStarted ? true : false,
                        submissionPics: [
                          "https://cf.shopee.tw/file/tw-11134201-7r98s-lrv9ysusrzlec9",
                          "https://img.biggo.com/01mTTg9SjvnNQulIQRSz4oBNPjMqWuD3o3cjyhg37Ac/fit/0/0/sm/1/aHR0cHM6Ly90c2hvcC5yMTBzLmNvbS84N2QvYzQzLzJhMjgvZWEzZC9jMDA3LzhhM2QvYzMyZS8xMTg0ZWVhNzI0MDI0MmFjMTEwMDA0LmpwZw.jpg",
                          "https://img.feebee.tw/i/oAbGGHUxE2jJlIURo-Sd2gc-NEeaMhE980abq5vNsT8/372/aHR0cHM6Ly9jZi5zaG9wZWUudHcvZmlsZS9zZy0xMTEzNDIwMS03cmNjNy1sdHMzamVscTI3eGg4NA.webp"
                        ],
                        isCollapsed: widget.isStarted ? true : false,
                        isCollapseAble: widget.isStarted ? false : true,
                      )
                    : Container(
                        width: double.infinity,
                        child: missionNoticeCardComponent(),
                      ),
                widget.isFailed
                    ? missionFailedReasonCardComponent(
                        reasonTitle: "拒绝理由",
                        reasonDesc:
                            "啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊")
                    : Container(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
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
                          Clipboard.setData(const ClipboardData(
                              text: "0292938DHFKAAUBCVAVC"));
                          Fluttertoast.showToast(
                              msg: "已复制",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: kMainGreyColor,
                              textColor: kThirdGreyColor);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: SvgPicture.asset(
                            "assets/mission/copy.svg",
                            width: 24,
                            height: 24,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 37,
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
          child: widget.isStarted
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(style: messageDescTextStyle2, children: [
                      TextSpan(text: '剩余时间 '),
                      TextSpan(text: '240:02:09')
                    ])),
                    Padding(
                      padding: EdgeInsets.only(left: 24),
                      child: SizedBox(
                        width: 180,
                        child: primaryButtonComponent(
                          text: '提交',
                          textStyle: missionCardTitleTextStyle,
                          buttonColor: kMainYellowColor,
                          onPressed: () {
                            setState(() {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatusDialogComponent(
                                    complete: false,
                                    unsuccessText: "请上传任务截图",
                                    onTap: () {
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    },
                                  );
                                },
                              );
                              // showDialog(
                              //     context: context,
                              //     builder: (context) {
                              //       return AlertDialogComponent(
                              //         alertTitle: '您即将提交该任务',
                              //         alertDesc: RichText(
                              //           text: TextSpan(
                              //             style: alertDialogContentTextStyle,
                              //             children: [
                              //               TextSpan(text: '点击确认后，该任务将被提交，\n'),
                              //               TextSpan(
                              //                 text: '若审核未通过需自行承担后果(雇主不付款)。\n',
                              //               ),
                              //               TextSpan(text: '确定提交后不可重新编辑。\n'),
                              //               TextSpan(
                              //                 text: '是否继续？\n',
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //         descTextStyle:
                              //             alertDialogContentTextStyle,
                              //         firstButtonText: '继续编辑',
                              //         firstButtonTextStyle:
                              //             alertDialogFirstButtonTextStyle,
                              //         firstButtonColor: kThirdGreyColor,
                              //         secondButtonText: '确认提交任务',
                              //         secondButtonTextStyle:
                              //             alertDialogSecondButtonTextStyle,
                              //         secondButtonColor: kMainYellowColor,
                              //         isButtonExpanded: false,
                              //         firstButtonOnTap: () {
                              //           setState(() {
                              //             Navigator.pop(context);
                              //           });
                              //         },
                              //         secondButtonOnTap: () {
                              //           setState(() {
                              //             Navigator.pop(context);
                              //             showDialog(
                              //               context: context,
                              //               builder: (BuildContext context) {
                              //                 return StatusDialogComponent(
                              //                   complete: true,
                              //                   successText:
                              //                       "雇主将在48小时内审核您的悬赏成果。",
                              //                   onTap: () {
                              //                     setState(() {
                              //                       Navigator.pop(context);
                              //                       Get.offAllNamed('/home');
                              //                     });
                              //                   },
                              //                 );
                              //               },
                              //             );
                              //           });
                              //         },
                              //       );
                              //     });
                            });
                          },
                        ),
                      ),
                    )
                  ],
                )
              : SizedBox(
                  width: double.infinity,
                  child: primaryButtonComponent(
                      buttonColor: kMainYellowColor,
                      disableButtonColor: kThirdGreyColor,
                      text: widget.isSubmitted
                          ? "待审核"
                          : widget.isExpired
                              ? "已失效"
                              : widget.isFailed
                                  ? "未通过"
                                  : widget.isWaitingPaid
                                      ? "待到账"
                                      : widget.isPaid
                                          ? "已到账"
                                          : "开始悬赏",
                      textStyle: (widget.isSubmitted ||
                              widget.isExpired ||
                              widget.isFailed ||
                              widget.isWaitingPaid ||
                              widget.isPaid)
                          ? disableButtonTextStyle
                          : buttonTextStyle,
                      onPressed: (widget.isSubmitted ||
                              widget.isExpired ||
                              widget.isFailed ||
                              widget.isWaitingPaid ||
                              widget.isPaid)
                          ? null
                          : () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialogComponent(
                                      alertTitle: '您即将开始悬赏',
                                      alertDesc: RichText(
                                        text: TextSpan(
                                          style: alertDialogContentTextStyle,
                                          children: [
                                            TextSpan(
                                                text: '该悬赏的限时为3天（72小时）。\n'),
                                            TextSpan(
                                              text: '请注意，用户不能重复开始同一悬赏。\n\n',
                                            ),
                                            TextSpan(
                                                text: '开始悬赏后将无法终止或放弃悬赏，\n'),
                                            TextSpan(
                                              text: '直至该悬赏过期/被下架。\n\n',
                                            ),
                                            TextSpan(text: '是否继续？\n'),
                                          ],
                                        ),
                                      ),
                                      descTextStyle:
                                          alertDialogContentTextStyle,
                                      firstButtonText: '返回',
                                      firstButtonTextStyle:
                                          alertDialogFirstButtonTextStyle,
                                      firstButtonColor: kThirdGreyColor,
                                      secondButtonText: '开始悬赏',
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
                                        setState(() {
                                          Navigator.pop(context);
                                          Get.to(() => RecipientInfoPage(),
                                              transition:
                                                  Transition.rightToLeft);

                                          Fluttertoast.showToast(
                                              msg: "悬赏开始",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: kMainGreyColor,
                                              textColor: kThirdGreyColor);
                                        });
                                      },
                                    );
                                  });
                            }),
                ),
        ),
      ),
    );
  }
}
