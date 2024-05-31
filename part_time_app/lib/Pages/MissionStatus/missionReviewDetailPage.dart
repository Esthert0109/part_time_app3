import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Card/missionDetailStepsCardComponent.dart';
import 'package:part_time_app/Components/Card/missionFailedReasonCardComponent.dart';
import 'package:part_time_app/Components/Card/missionSubmissionCardComponent.dart';
import 'package:part_time_app/Model/Task/missionClass.dart';
import 'package:part_time_app/Pages/MissionIssuer/missionDetailStatusIssuerPage.dart';
import 'package:part_time_app/Services/order/orderServices.dart';

import '../../Components/Button/primaryButtonComponent.dart';
import '../../Components/Card/missionDetailDescriptionCardComponent.dart';
import '../../Components/Card/missionDetailIssuerCardComponent.dart';
import '../../Components/Dialog/alertDialogComponent.dart';
import '../../Components/Dialog/rejectReasonDialogComponent.dart';
import '../../Components/Loading/missionDetailLoading.dart';
import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class MissionReviewDetailPage extends StatefulWidget {
  final int orderId;
  final bool isCompleted;
  const MissionReviewDetailPage({
    super.key,
    required this.isCompleted,
    required this.orderId,
  });

  @override
  State<MissionReviewDetailPage> createState() =>
      _MissionReviewDetailPageState();
}

class _MissionReviewDetailPageState extends State<MissionReviewDetailPage> {
  bool isFavourite = false;

  // if mission failed, show reason card
  bool isMissionFailed = false;

  // services
  OrderServices services = OrderServices();
  OrderData? orderDetails;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    setState(() {
      isLoading = true;
    });
    OrderDetailModel? orderModel =
        await services.getOrderDetailsByOrderId(widget.orderId!);

    if (orderModel!.data != null) {
      setState(() {
        orderDetails = orderModel!.data!;
        if (orderDetails!.orderStatus == 2) {
          isMissionFailed = true;
        }
      });
    }

    setState(() {
      isLoading = false;
    });
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
                        MissionDetailIssuerCardComponent(
                            image: orderDetails?.avatar ??
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9MU4SwesBOo_JPNEelanllG_YX_v4OWhdffpsPc0Gow&s",
                            title: orderDetails?.nickname ?? "墩墩鸡",
                            action: "留言咨询 >",
                            onTap: () {}),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: MissionDetailDescriptionCardComponent(
                            title: orderDetails?.taskTitle ?? "",
                            detail: orderDetails?.taskContent ?? "",
                            tag: orderDetails?.taskTagNames!
                                    .map((tag) => tag.tagName)
                                    .toList() ??
                                [],
                            totalSlot:
                                orderDetails?.taskQuota.toString() ?? "0",
                            leaveSlot: (orderDetails!.taskQuota! -
                                        orderDetails!.taskReceivedNum!)
                                    .toString() ??
                                "0",
                            day: orderDetails!.taskTimeLimit.toString() ?? "0",
                            duration:
                                orderDetails!.taskEstimateTime.toString() ??
                                    "0",
                            date:
                                orderDetails!.taskUpdatedTime.toString() ?? "",
                            price:
                                orderDetails!.taskSinglePrice.toString() ?? "",
                            isFavourite: isFavourite,
                            taskId: 0,
                            limitUnit: orderDetails!.taskTimeLimitUnit ?? "天",
                            estimatedUnit:
                                orderDetails!.taskEstimateTimeUnit ?? "天",
                          ),
                        ),
                        missionDetailStepsCardComponent(
                          steps: orderDetails?.taskProcedures?.step ?? [],
                          isConfidential: false,
                          isCollapsed: false,
                          isCollapseAble: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: MissionSubmissionCardComponent(
                            isEdit: false,
                            submissionPics:
                                orderDetails?.orderScreenshots?.image ?? [],
                            isCollapsed: widget.isCompleted ? false : true,
                            isCollapseAble: true,
                          ),
                        ),
                        (widget.isCompleted && isMissionFailed)
                            ? Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(bottom: 12),
                                child: missionFailedReasonCardComponent(
                                    reasonTitle: "拒绝理由",
                                    reasonDesc:
                                        orderDetails?.orderRejectReason ?? ""),
                              )
                            : Container(),
                        Row(
                          children: [
                            RichText(
                                text: TextSpan(
                                    style: missionIDtextStyle,
                                    children: [
                                  TextSpan(text: "悬赏ID: "),
                                  TextSpan(
                                      text:
                                          orderDetails?.taskId.toString() ?? "")
                                ])),
                            GestureDetector(
                              onTap: () {
                                print("copied");
                                Clipboard.setData(ClipboardData(
                                    text:
                                        orderDetails?.taskId.toString() ?? ""));
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

              // if mission completed, the button can't be pressed
              child: (widget.isCompleted || isMissionFailed)
                  ? SizedBox(
                      width: double.infinity,
                      child: primaryButtonComponent(
                        isLoading: false,
                        buttonColor: kMainYellowColor,
                        disableButtonColor: kThirdGreyColor,
                        text: isMissionFailed ? "未通过" : '已通过',
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
                            isLoading: false,
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
                                            return RejectReasonDialogComponent(
                                              orderId:
                                                  orderDetails?.orderId ?? 0,
                                            );
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
                            isLoading: false,
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
                                      secondButtonOnTap: () async {
                                        try {
                                          bool? accept =
                                              await services.acceptRejectOrder(
                                                  true,
                                                  orderDetails!.orderId!,
                                                  "");
                                          if (accept!) {
                                            setState(() {
                                              Navigator.pop(context);
                                              Get.back();
                                              Fluttertoast.showToast(
                                                  msg: "已通过",
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor:
                                                      kMainGreyColor,
                                                  textColor: kThirdGreyColor);
                                            });
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "通过失败，请重试",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: kMainGreyColor,
                                                textColor: kThirdGreyColor);
                                          }
                                        } catch (e) {
                                          Fluttertoast.showToast(
                                              msg: "$e",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: kMainGreyColor,
                                              textColor: kThirdGreyColor);
                                        }
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
