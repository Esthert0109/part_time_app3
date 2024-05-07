import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Button/primaryButtonComponent.dart';
import 'package:part_time_app/Components/Card/missionDetailDescriptionCardComponent.dart';
import 'package:part_time_app/Components/Card/missionDetailIssuerCardComponent.dart';
import 'package:part_time_app/Components/Card/missionDetailStepsCardComponent.dart';
import 'package:part_time_app/Components/Card/missionNoticeCardComponent.dart';
import 'package:part_time_app/Components/Card/missionPublishCheckoutCardComponent.dart';
import 'package:part_time_app/Components/Title/thirdTitleComponent.dart';
import 'package:part_time_app/Pages/Explore/exploreMainPage.dart';
import 'package:part_time_app/Pages/MissionIssuer/missionPublishMainPage.dart';
import 'package:part_time_app/Pages/MockData/missionMockClass.dart';

import '../../Components/Dialog/alertDialogComponent.dart';
import '../../Components/Loading/missionDetailLoading.dart';
import '../../Components/Status/statusDialogComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/MockModel/missionStepMockModel.dart';
import '../MissionStatus/missionReviewPage.dart';

class MissionDetailStatusIssuerPage extends StatefulWidget {
  final bool isWaiting;
  final bool isFailed;
  final bool isPassed;
  final bool isRemoved;
  const MissionDetailStatusIssuerPage(
      {super.key,
      required this.isWaiting,
      required this.isFailed,
      required this.isPassed,
      required this.isRemoved});

  @override
  State<MissionDetailStatusIssuerPage> createState() =>
      _MissionDetailStatusIssuerPageState();
}

//
// when preview (from publish mission page)
// steps: isCollapsed - false, isCollapseAble - false
// checkout: non-editable
// button: 提交
//
// waiting for review
// steps: isCollapsed - false, isCollapseAble - false
// checkout: non-editable
// button: 待审核
//
// review failed
// - mission delete on right (appbar)
// steps: isCollapsed - false, isCollapseAble - false
// checkout: non-editable
// button: 计时器 + 重新编辑
//
// review passed
// - mission delete on right (appbar): check if got submission waiting for review
// steps: isCollapsed - false, isCollapseAble - false
// checkout: no checkout
// button: 查看悬赏进度
//
// mission removed
// - mission submission on right (appbar): check if got submission waiting for review
// steps: isCollapsed - false, isCollapseAble - false
// checkout: no checkout
// button: 已下架
//

class _MissionDetailStatusIssuerPageState
    extends State<MissionDetailStatusIssuerPage> {
  bool picPreview = true;
  bool isLoading = false;
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
              actions: (widget.isFailed || widget.isPassed || widget.isRemoved)
                  ? [
                      GestureDetector(
                        onTap: () {
                          print("complain this mission");

                          (widget.isFailed || widget.isPassed)
                              ? showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialogComponent(
                                      alertTitle: '您即将删除该悬赏',
                                      alertDesc: RichText(
                                        text: TextSpan(
                                          style: alertDialogContentTextStyle,
                                          children: [
                                            TextSpan(text: '点击确认后，所有内容将被删除。\n'),
                                            TextSpan(
                                              text: '已预付的赏金将',
                                            ),
                                            TextSpan(
                                                text: '全额退款',
                                                style: alertDialogTextStyle),
                                            TextSpan(
                                              text: '。是否继续？',
                                            )
                                          ],
                                        ),
                                      ),
                                      descTextStyle:
                                          alertDialogContentTextStyle,
                                      firstButtonText: '返回',
                                      firstButtonTextStyle:
                                          alertDialogFirstButtonTextStyle,
                                      firstButtonColor: kThirdGreyColor,
                                      secondButtonText: '确认',
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
                                        setState(() {
                                          Navigator.pop(context);
                                          Get.back();
                                          Fluttertoast.showToast(
                                              msg: "已删除",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: kMainGreyColor,
                                              textColor: kThirdGreyColor);
                                        });
                                      },
                                    );
                                  })
                              : Get.to(() => MissionReviewPage(),
                                  transition: Transition.rightToLeft);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: SvgPicture.asset(
                            (widget.isFailed || widget.isPassed)
                                ? "assets/mission/delete.svg"
                                : "assets/mission/review.svg",
                            width: 24,
                            height: 24,
                          ),
                        ),
                      )
                    ]
                  : null,
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
            child: isLoading
                ? MissionDetailLoading()
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (widget.isPassed || widget.isRemoved)
                            ? Container()
                            : MissionDetailIssuerCardComponent(
                                image:
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9MU4SwesBOo_JPNEelanllG_YX_v4OWhdffpsPc0Gow&s",
                                title: "墩墩鸡",
                                action: "留言咨询 >",
                                onTap: () {}),
                        const SizedBox(
                          height: 12,
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
                        const SizedBox(
                          height: 12,
                        ),
                        missionDetailStepsCardComponent(
                          steps: mockData,
                          isConfidential: false,
                          isCollapsed: true,
                          isCollapseAble: false,
                        ),
                        (widget.isPassed || widget.isRemoved)
                            ? Container()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: MissionPublishCheckoutCardComponent(
                                  isSubmit: true,
                                  dayInitial: "10",
                                  priceInitial: "20",
                                  peopleInitial: "50",
                                  durationInitial: "60",
                                ),
                              ),
                        (widget.isPassed || widget.isRemoved)
                            ? Container()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "图片预览",
                                    style: missionDetailText6,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: Text(
                                            picPreview ? "开始悬赏可见" : "公开",
                                            style: tStatusFieldText1,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 50,
                                          height: 40,
                                          child: FittedBox(
                                            fit: BoxFit.fill,
                                            child: Switch(
                                                value: picPreview,
                                                activeColor: kMainBlackColor,
                                                activeTrackColor:
                                                    kMainYellowColor,
                                                inactiveTrackColor:
                                                    kTransparent,
                                                inactiveThumbColor:
                                                    kMainBlackColor,
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .padded,
                                                trackOutlineColor:
                                                    MaterialStateProperty
                                                        .resolveWith<Color?>(
                                                  (Set<MaterialState> states) {
                                                    if (picPreview) {
                                                      return kMainBlackColor;
                                                    }
                                                    return kMainBlackColor; // Use the default color.
                                                  },
                                                ),
                                                trackOutlineWidth:
                                                    MaterialStateProperty.all(
                                                        1),
                                                onChanged: null
                                                //  (preview) {
                                                //   setState(() {
                                                //     picPreview = preview;
                                                //   });
                                                // }
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                        (widget.isPassed || widget.isRemoved)
                            ? Container()
                            : Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(top: 12),
                                child: missionNoticeCardComponent(),
                              ),
                        const SizedBox(
                          height: 12,
                        ),
                        (widget.isWaiting ||
                                widget.isFailed ||
                                widget.isPassed ||
                                widget.isRemoved)
                            ? Row(
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: SvgPicture.asset(
                                        "assets/mission/copy.svg",
                                        width: 24,
                                        height: 24,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Container(),
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
            child: widget.isFailed
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: messageDescTextStyle2,
                              children: [
                            TextSpan(text: '剩余时间 '),
                            TextSpan(text: '240:02:09')
                          ])),
                      Padding(
                        padding: EdgeInsets.only(left: 24),
                        child: SizedBox(
                          width: 180,
                          child: primaryButtonComponent(
                            isLoading: isLoading,
                            text: '重新编辑',
                            textStyle: missionRejectButtonTextStyle,
                            buttonColor: kRejectMissionButtonColor,
                            onPressed: () {
                              Get.to(() => MissionPublishMainPage(
                                    isEdit: true,
                                  ));
                            },
                          ),
                        ),
                      )
                    ],
                  )
                : SizedBox(
                    width: double.infinity,
                    child: primaryButtonComponent(
                      isLoading: isLoading,
                      buttonColor: kMainYellowColor,
                      disableButtonColor: kThirdGreyColor,
                      text: widget.isWaiting
                          ? '待审核'
                          : widget.isPassed
                              ? '查看悬赏进度'
                              : widget.isRemoved
                                  ? "已下架"
                                  : '提交',
                      textStyle: (widget.isWaiting || widget.isRemoved)
                          ? disableButtonTextStyle
                          : buttonTextStyle,
                      onPressed: (widget.isWaiting || widget.isRemoved)
                          ? null
                          : widget.isPassed
                              ? () {
                                  Get.to(() => MissionReviewPage(),
                                      transition: Transition.rightToLeft);
                                }
                              : () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialogComponent(
                                          alertTitle: '提交前请检查',
                                          alertDesc: RichText(
                                            text: TextSpan(
                                              style:
                                                  alertDialogContentTextStyle,
                                              children: [
                                                TextSpan(
                                                    text: '是否从相册选择了正确的截图\n'),
                                                TextSpan(
                                                  text: '截图是否符合悬赏要求\n\n',
                                                ),
                                                TextSpan(text: '提交后将无法修改\n'),
                                                TextSpan(
                                                  text: '恶意提交将受到禁止报名/永久封号等惩罚。',
                                                )
                                              ],
                                            ),
                                          ),
                                          descTextStyle:
                                              alertDialogContentTextStyle,
                                          firstButtonText: '检查一下',
                                          firstButtonTextStyle:
                                              alertDialogFirstButtonTextStyle,
                                          firstButtonColor: kThirdGreyColor,
                                          secondButtonText: '确认无误马上提交',
                                          secondButtonTextStyle:
                                              alertDialogSecondButtonTextStyle,
                                          secondButtonColor: kMainYellowColor,
                                          isButtonExpanded: false,
                                          firstButtonOnTap: () {
                                            setState(() {
                                              Navigator.pop(context);
                                            });
                                          },
                                          secondButtonOnTap: () {
                                            setState(() {
                                              Navigator.pop(context);

                                              // Get.back();
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return StatusDialogComponent(
                                                    complete: true,
                                                    successText:
                                                        "系统将审核你的内容，审核通过后将发布该悬赏。",
                                                    onTap: () {
                                                      setState(() {
                                                        Navigator.pop(context);
                                                        Get.offAllNamed(
                                                            '/home');
                                                      });
                                                    },
                                                  );
                                                },
                                              );
                                            });
                                          },
                                        );
                                      });
                                },
                    ),
                  ),
          )),
    );
  }
}

List<MissionStepMockModel> mockData = [
  MissionStepMockModel(
    stepDesc: "打开飞常准APP，如果没有复制口令，去应用商城搜索后下载安装即可，无需注册",
    stepPicList: [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRJVwTTcr_HwmVjCna8OuS2C_6WbqasMLSoqsXGBQbIA&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTA_FELx_NE42Is0hKZcgutgCQjhNBtjXgdsc7FsMaBLg&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQj8WIyofD3WvhzI1GuT3i-wu1ndIQi_4166eeFpMpnhw&s"
    ],
  ),
  MissionStepMockModel(
    stepDesc: "打开飞常准APP，如果没有复制口令，去应用商城搜索后下载安装即可，无需注册",
    stepPicList: [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRJVwTTcr_HwmVjCna8OuS2C_6WbqasMLSoqsXGBQbIA&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTA_FELx_NE42Is0hKZcgutgCQjhNBtjXgdsc7FsMaBLg&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQj8WIyofD3WvhzI1GuT3i-wu1ndIQi_4166eeFpMpnhw&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQj8WIyofD3WvhzI1GuT3i-wu1ndIQi_4166eeFpMpnhw&s"
    ],
  ),
  MissionStepMockModel(
    stepDesc: "打开飞常准APP，如果没有复制口令，去应用商城搜索后下载安装即可，无需注册",
    stepPicList: [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQj8WIyofD3WvhzI1GuT3i-wu1ndIQi_4166eeFpMpnhw&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQj8WIyofD3WvhzI1GuT3i-wu1ndIQi_4166eeFpMpnhw&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRJVwTTcr_HwmVjCna8OuS2C_6WbqasMLSoqsXGBQbIA&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTA_FELx_NE42Is0hKZcgutgCQjhNBtjXgdsc7FsMaBLg&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQj8WIyofD3WvhzI1GuT3i-wu1ndIQi_4166eeFpMpnhw&s"
    ],
  )
];
