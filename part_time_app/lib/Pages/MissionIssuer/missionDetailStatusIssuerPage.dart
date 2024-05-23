import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Button/primaryButtonComponent.dart';
import 'package:part_time_app/Components/Card/missionDetailDescriptionCardComponent.dart';
import 'package:part_time_app/Components/Card/missionDetailIssuerCardComponent.dart';
import 'package:part_time_app/Components/Card/missionDetailStepsCardComponent.dart';
import 'package:part_time_app/Components/Card/missionFailedReasonCardComponent.dart';
import 'package:part_time_app/Components/Card/missionNoticeCardComponent.dart';
import 'package:part_time_app/Components/Card/missionPublishCheckoutCardComponent.dart';
import 'package:part_time_app/Components/Title/thirdTitleComponent.dart';
import 'package:part_time_app/Model/User/userModel.dart';
import 'package:part_time_app/Pages/MissionIssuer/missionPublishMainPage.dart';
import 'package:part_time_app/Model/Task/missionClass.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';

import '../../Components/Common/countdownTimer.dart';
import '../../Components/Dialog/alertDialogComponent.dart';
import '../../Components/Dialog/paymentUploadDialogComponent.dart';
import '../../Components/Loading/missionDetailLoading.dart';
import '../../Components/Status/statusDialogComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/MockModel/missionStepMockModel.dart';
import '../../Services/Upload/uploadServices.dart';
import '../../Services/order/orderServices.dart';
import '../MissionStatus/missionReviewPage.dart';

class MissionDetailStatusIssuerPage extends StatefulWidget {
  final int taskId;
  final bool isPreview;
  final OrderData? orderData;
  final bool isResubmit;
  const MissionDetailStatusIssuerPage(
      {super.key,
      required this.taskId,
      required this.isPreview,
      this.orderData,
      required this.isResubmit});

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
  bool picPreview = false;
  bool isLoading = false;

  UserData userDetails = UserData();

  // service
  OrderServices services = OrderServices();
  OrderDetailModel? orderModel;
  OrderData orderDetail = OrderData();
  bool isFavourite = false;
  int? status;
  int noRecipient = 0;
  DateTime? expiredDate;

  // status
  bool isWaiting = false;
  bool isFailed = false;
  bool isPassed = false;
  bool isRemoved = false;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();

    if (widget.isPreview) {
      orderDetail = widget.orderData!;
      if (orderDetail.taskImagesPreview == 1) {
        setState(() {
          picPreview = true;
        });
      }
    } else {
      fetchData();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchUserDetails() async {
    UserData? userData = await SharedPreferencesUtils.getUserDataInfo();
    setState(() {
      userDetails = userData!;
    });
  }

  checkNoRecipient() async {
    for (int i = 0; i < 3; i++) {
      CustomerListModel? model =
          await services.getCustomerListByOrderStatusId(i, widget.taskId, 1);
      setState(() {
        noRecipient += model?.data?.totalCount ?? 0;
        print("check number: $noRecipient");
      });
    }
  }

  fetchData() async {
    setState(() {
      isLoading = true;
    });

    orderModel = await services.getTaskDetailsByTaskId(widget.taskId!);

    if (orderModel!.data != null) {
      setState(() {
        orderDetail = orderModel!.data!;
        if (orderDetail.collectionValid != null &&
            orderDetail.collectionValid == 1) {
          isFavourite = true;
        }
        if (orderDetail.taskImagesPreview != 0) {
          picPreview = true;
        }

        isLoading = false;

        status = orderDetail.taskStatus!;

        checkNoRecipient();
      });

      if (orderDetail.taskReeditTime != "" &&
          orderDetail.taskReeditTime != null) {
        setState(() {
          expiredDate = DateTime.parse(orderDetail.taskReeditTime!);
        });
      }

      if (status == 0) {
        setState(() {
          isWaiting = true;
        });
      } else if (status == 1) {
        setState(() {
          isFailed = true;
        });
      } else if (status == 2) {
        setState(() {
          isPassed = true;
        });
      } else if (status == 3 || status == 4 || status == 5) {
        setState(() {
          isRemoved = true;
        });
      }
    }
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
              actions: (isFailed || isPassed || isRemoved)
                  ? [
                      GestureDetector(
                        onTap: () {
                          (isFailed)
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
                                                style:
                                                    alertDialogContentTextStyle2),
                                            TextSpan(
                                              text: '。是否继续？\n',
                                            ),
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
                                      secondButtonOnTap: () async {
                                        bool? unshelf = false;
                                        unshelf =
                                            await services.unshelfTaskByTaskId(
                                                orderDetail.taskId!);

                                        if (unshelf!) {
                                          setState(() {
                                            Navigator.pop(context);
                                            Get.offAllNamed('/home');
                                            Fluttertoast.showToast(
                                                msg: "已下架",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: kMainGreyColor,
                                                textColor: kThirdGreyColor);
                                          });
                                        } else {
                                          Navigator.pop(context);
                                          Fluttertoast.showToast(
                                              msg: "下架失败",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: kMainGreyColor,
                                              textColor: kThirdGreyColor);
                                        }
                                      },
                                    );
                                  })
                              : (isPassed)
                                  ? (checkNoRecipient == 0)
                                      ? showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialogComponent(
                                              alertTitle: '下架悬赏',
                                              alertDesc: RichText(
                                                text: TextSpan(
                                                  style:
                                                      alertDialogRejectButtonTextStyle,
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            '仍有已提交的悬赏尚未审核，\n'),
                                                    TextSpan(
                                                      text:
                                                          '您必须先完成所有审核才可下架悬赏。\n',
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '若坚决下架，系统将一律通过未审核的悬赏，并发放所有赏金。\n',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              descTextStyle:
                                                  alertDialogContentTextStyle,
                                              firstButtonText: '仍然下架',
                                              firstButtonTextStyle:
                                                  alertDialogRejectButtonTextStyle,
                                              firstButtonColor:
                                                  kRejectMissionButtonColor,
                                              secondButtonText: '取消下架',
                                              secondButtonTextStyle:
                                                  alertDialogSecondButtonTextStyle,
                                              secondButtonColor:
                                                  kMainYellowColor,
                                              isButtonExpanded: true,
                                              firstButtonOnTap: () {
                                                setState(() {
                                                  Navigator.pop(context);

                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialogComponent(
                                                          alertTitle: '下架悬赏',
                                                          alertDesc: RichText(
                                                            text: TextSpan(
                                                              style:
                                                                  alertDialogContentTextStyle,
                                                              children: [
                                                                TextSpan(
                                                                    text:
                                                                        '该悬赏将被下架，下架后不会在发现里展示。\n'),
                                                                TextSpan(
                                                                  text:
                                                                      '已开始悬赏的用户将受到推送通知。\n\n',
                                                                ),
                                                                TextSpan(
                                                                  text:
                                                                      '系统将在3-5天内把所剩余的赏金退款(不包括手续费)\n',
                                                                ),
                                                                TextSpan(
                                                                  text:
                                                                      '是否继续？\n',
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          descTextStyle:
                                                              alertDialogContentTextStyle,
                                                          firstButtonText: '返回',
                                                          firstButtonTextStyle:
                                                              alertDialogFirstButtonTextStyle,
                                                          firstButtonColor:
                                                              kThirdGreyColor,
                                                          secondButtonText:
                                                              '下架悬赏',
                                                          secondButtonTextStyle:
                                                              alertDialogRejectButtonTextStyle,
                                                          secondButtonColor:
                                                              kRejectMissionButtonColor,
                                                          isButtonExpanded:
                                                              true,
                                                          firstButtonOnTap: () {
                                                            setState(() {
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          },
                                                          secondButtonOnTap:
                                                              () async {
                                                            bool? unshelf =
                                                                false;
                                                            unshelf = await services
                                                                .unshelfTaskByTaskId(
                                                                    orderDetail
                                                                        .taskId!);

                                                            if (unshelf!) {
                                                              setState(() {
                                                                Navigator.pop(
                                                                    context);
                                                                Get.offAllNamed(
                                                                    '/home');
                                                                Fluttertoast.showToast(
                                                                    msg: "已下架",
                                                                    toastLength:
                                                                        Toast
                                                                            .LENGTH_LONG,
                                                                    gravity:
                                                                        ToastGravity
                                                                            .BOTTOM,
                                                                    backgroundColor:
                                                                        kMainGreyColor,
                                                                    textColor:
                                                                        kThirdGreyColor);
                                                              });
                                                            } else {
                                                              Navigator.pop(
                                                                  context);
                                                              Fluttertoast.showToast(
                                                                  msg: "下架失败",
                                                                  toastLength: Toast
                                                                      .LENGTH_LONG,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .BOTTOM,
                                                                  backgroundColor:
                                                                      kMainGreyColor,
                                                                  textColor:
                                                                      kThirdGreyColor);
                                                            }
                                                          },
                                                        );
                                                      });
                                                });
                                              },
                                              secondButtonOnTap: () {
                                                setState(() {
                                                  Navigator.pop(context);
                                                });
                                              },
                                            );
                                          })
                                      : showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialogComponent(
                                              alertTitle: '下架悬赏',
                                              alertDesc: RichText(
                                                text: TextSpan(
                                                  style:
                                                      alertDialogContentTextStyle,
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            '该悬赏将被下架，下架后不会在发现里展示。\n'),
                                                    TextSpan(
                                                      text:
                                                          '已开始悬赏的用户将受到推送通知。\n\n',
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '系统将在3-5天内把所剩余的赏金退款(不包括手续费)\n',
                                                    ),
                                                    TextSpan(
                                                      text: '是否继续？\n',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              descTextStyle:
                                                  alertDialogContentTextStyle,
                                              firstButtonText: '返回',
                                              firstButtonTextStyle:
                                                  alertDialogFirstButtonTextStyle,
                                              firstButtonColor: kThirdGreyColor,
                                              secondButtonText: '下架悬赏',
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
                                              secondButtonOnTap: () async {
                                                bool? unshelf = false;
                                                unshelf = await services
                                                    .unshelfTaskByTaskId(
                                                        orderDetail.taskId!);

                                                if (unshelf!) {
                                                  setState(() {
                                                    Navigator.pop(context);
                                                    Get.offAllNamed('/home');
                                                    Fluttertoast.showToast(
                                                        msg: "已下架",
                                                        toastLength:
                                                            Toast.LENGTH_LONG,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        backgroundColor:
                                                            kMainGreyColor,
                                                        textColor:
                                                            kThirdGreyColor);
                                                  });
                                                } else {
                                                  Navigator.pop(context);
                                                  Fluttertoast.showToast(
                                                      msg: "下架失败",
                                                      toastLength:
                                                          Toast.LENGTH_LONG,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      backgroundColor:
                                                          kMainGreyColor,
                                                      textColor:
                                                          kThirdGreyColor);
                                                }
                                              },
                                            );
                                          })
                                  : Get.to(
                                      () => MissionReviewPage(
                                            taskId: widget.taskId,
                                          ),
                                      transition: Transition.rightToLeft);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: SvgPicture.asset(
                            (isFailed || isPassed)
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
                        (isPassed || isRemoved)
                            ? Container()
                            : MissionDetailIssuerCardComponent(
                                image: orderDetail.avatar ??
                                    userDetails.avatar ??
                                    "",
                                title: orderDetail.nickname ??
                                    userDetails.nickname ??
                                    "",
                                action: "留言咨询 >",
                                onTap: () {}),
                        const SizedBox(
                          height: 12,
                        ),
                        MissionDetailDescriptionCardComponent(
                          title: orderDetail.taskTitle ?? "",
                          detail: orderDetail.taskContent ?? "",
                          tag: orderDetail.taskTagNames
                                  ?.map((tag) => tag.tagName)
                                  .toList() ??
                              [],
                          totalSlot: orderDetail.taskQuota.toString() ?? "0",
                          leaveSlot: (orderDetail.taskQuota! -
                                      (orderDetail.taskReceivedNum ?? 0))
                                  .toString() ??
                              "0",
                          day: orderDetail.taskTimeLimit.toString() ?? "0",
                          duration:
                              orderDetail.taskEstimateTime.toString() ?? "0",
                          date: orderDetail.taskUpdatedTime.toString() ?? "",
                          price: orderDetail.taskSinglePrice.toString() ?? "",
                          taskId: orderDetail.taskId ?? 0,
                          limitUnit: orderDetail.taskTimeLimitUnit ?? "",
                          estimatedUnit: orderDetail.taskEstimateTimeUnit ?? '',
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        isFailed
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: missionFailedReasonCardComponent(
                                    reasonTitle: "拒绝理由",
                                    reasonDesc:
                                        orderDetail.taskRejectReason ?? ""),
                              )
                            : Container(),
                        missionDetailStepsCardComponent(
                          steps: orderDetail.taskProcedures?.step ?? [],
                          isConfidential:
                              orderDetail.taskImagesPreview == 0 ? false : true,
                          isCollapsed: true,
                          isCollapseAble: false,
                        ),
                        (isPassed || isRemoved)
                            ? Container()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: MissionPublishCheckoutCardComponent(
                                  isSubmit: true,
                                  dayInitial:
                                      orderDetail.taskTimeLimit.toString() ??
                                          "0",
                                  priceInitial:
                                      orderDetail.taskSinglePrice.toString() ??
                                          "",
                                  peopleInitial:
                                      orderDetail.taskQuota.toString() ?? "0",
                                  durationInitial:
                                      orderDetail.taskEstimateTime.toString() ??
                                          "0",
                                ),
                              ),
                        (isPassed || isRemoved)
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
                                                onChanged: null),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                        (isPassed || isRemoved)
                            ? Container()
                            : Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(top: 12),
                                child: missionNoticeCardComponent(),
                              ),
                        const SizedBox(
                          height: 12,
                        ),
                        (isWaiting || isFailed || isPassed || isRemoved)
                            ? Row(
                                children: [
                                  RichText(
                                      text: TextSpan(
                                          style: missionIDtextStyle,
                                          children: [
                                        TextSpan(text: "悬赏ID: "),
                                        TextSpan(
                                            text: orderDetail.taskId.toString())
                                      ])),
                                  GestureDetector(
                                    onTap: () {
                                      print("copied");
                                      Clipboard.setData(ClipboardData(
                                          text: orderDetail.taskId.toString()));
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
            child: isFailed
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CountdownTimer(
                        isOTP: false,
                        isReview: false,
                        expiredDate: expiredDate!,
                      ),
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
                              Get.to(
                                  () => MissionPublishMainPage(
                                        isEdit: true,
                                        taskReedit: orderDetail,
                                      ),
                                  transition: Transition.rightToLeft);
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
                      text: isWaiting
                          ? '待审核'
                          : isPassed
                              ? '查看悬赏进度'
                              : isRemoved
                                  ? "已下架"
                                  : '提交',
                      textStyle: (isWaiting || isRemoved)
                          ? disableButtonTextStyle
                          : buttonTextStyle,
                      onPressed: (isWaiting || isRemoved)
                          ? null
                          : widget.isResubmit
                              ? () {
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
                                                    text:
                                                        '恶意提交将受到禁止报名/永久封号等惩罚。',
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
                                            secondButtonOnTap: () async {
                                              try {
                                                bool? update =
                                                    await services.resubmitTask(
                                                        orderDetail,
                                                        widget.taskId);

                                                if (update!) {
                                                  setState(() {
                                                    Navigator.pop(context);
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return StatusDialogComponent(
                                                          complete: true,
                                                          successText:
                                                              "雇主将在48小时内审核您的悬赏成果。",
                                                          onTap: () {
                                                            setState(() {
                                                              Navigator.pop(
                                                                  context);
                                                              Get.offAllNamed(
                                                                  '/home');
                                                            });
                                                          },
                                                        );
                                                      },
                                                    );
                                                  });
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg: "提交失败，请重试",
                                                      toastLength:
                                                          Toast.LENGTH_LONG,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      backgroundColor:
                                                          kMainGreyColor,
                                                      textColor:
                                                          kThirdGreyColor);
                                                }
                                              } on Exception catch (e) {
                                                Fluttertoast.showToast(
                                                    msg: "$e",
                                                    toastLength:
                                                        Toast.LENGTH_LONG,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    backgroundColor:
                                                        kMainGreyColor,
                                                    textColor: kThirdGreyColor);

                                                print(
                                                    "error in submission: $e");
                                              }
                                            });
                                      });
                                }
                              : isPassed
                                  ? () {
                                      Get.to(
                                          () => MissionReviewPage(
                                                taskId: widget.taskId,
                                              ),
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
                                                        text:
                                                            '是否从相册选择了正确的截图\n'),
                                                    TextSpan(
                                                      text: '截图是否符合悬赏要求\n\n',
                                                    ),
                                                    TextSpan(
                                                        text: '提交后将无法修改\n'),
                                                    TextSpan(
                                                      text:
                                                          '恶意提交将受到禁止报名/永久封号等惩罚。',
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
                                              secondButtonColor:
                                                  kMainYellowColor,
                                              isButtonExpanded: false,
                                              firstButtonOnTap: () {
                                                setState(() {
                                                  Navigator.pop(context);
                                                });
                                              },
                                              secondButtonOnTap: () async {
                                                try {
                                                  OrderData? orderSubmitted =
                                                      await services.createTask(
                                                          orderDetail);

                                                  print(
                                                      "check return: $orderSubmitted");

                                                  if (orderSubmitted != null) {
                                                    setState(() {
                                                      Navigator.pop(context);
                                                      orderDetail.taskId =
                                                          orderSubmitted.taskId;

                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return PaymentUploadDialogComponent(
                                                              orderDetails:
                                                                  orderDetail,
                                                            );
                                                          });
                                                    });
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg: "提交失败，请重试",
                                                        toastLength:
                                                            Toast.LENGTH_LONG,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        backgroundColor:
                                                            kMainGreyColor,
                                                        textColor:
                                                            kThirdGreyColor);
                                                  }
                                                } catch (e) {
                                                  Fluttertoast.showToast(
                                                      msg: "提交失败，请重试",
                                                      toastLength:
                                                          Toast.LENGTH_LONG,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      backgroundColor:
                                                          kMainGreyColor,
                                                      textColor:
                                                          kThirdGreyColor);
                                                }
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
