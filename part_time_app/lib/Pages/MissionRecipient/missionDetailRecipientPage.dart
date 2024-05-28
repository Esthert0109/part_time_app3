import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Card/missionFailedReasonCardComponent.dart';
import 'package:part_time_app/Pages/UserProfile/ticketSubmissionPage.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Components/Button/primaryButtonComponent.dart';
import '../../Components/Card/missionDetailDescriptionCardComponent.dart';
import '../../Components/Card/missionDetailIssuerCardComponent.dart';
import '../../Components/Card/missionDetailStepsCardComponent.dart';
import '../../Components/Card/missionNoticeCardComponent.dart';
import '../../Components/Card/missionSubmissionCardComponent.dart';
import '../../Components/Common/countdownTimer.dart';
import '../../Components/Dialog/alertDialogComponent.dart';
import '../../Components/Loading/missionDetailLoading.dart';
import '../../Components/Status/statusDialogComponent.dart';
import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/Task/missionClass.dart';
import '../../Model/User/userModel.dart';
import '../../Services/order/orderServices.dart';
import 'recipientInfoPage.dart';

class MissionDetailRecipientPage extends StatefulWidget {
  final int? orderId;
  final int? taskId;
  const MissionDetailRecipientPage({super.key, this.orderId, this.taskId});

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
  bool isLoading = false;

  // service
  OrderServices services = OrderServices();
  UserData? userData;
  OrderDetailModel? orderModel;
  OrderData orderDetail = OrderData();
  bool isFavourite = false;
  bool isConfidential = true;
  int? status;
  DateTime? expiredDate;

  // status
  bool isStarted = false;
  bool isSubmitted = false;
  bool isExpired = false;
  bool isWaitingPaid = false;
  bool isPaid = false;
  bool isFailed = false;

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchUserData();

    setState(() {
      updateUploadList.clear();
    });
  }

  fetchUserData() async {
    userData = await SharedPreferencesUtils.getUserDataInfo();
  }

  fetchData() async {
    setState(() {
      isLoading = true;
    });

    if (widget.taskId != null) {
      orderModel = await services.getTaskDetailsByTaskId(widget.taskId!);
    } else {
      orderModel = await services.getOrderDetailsByOrderId(widget.orderId!);
    }

    if (orderModel!.data != null) {
      setState(() {
        orderDetail = orderModel!.data!;
      });
      if (orderDetail.collectionValid != null &&
          orderDetail.collectionValid == 1) {
        setState(() {
          isFavourite = true;
        });
      }
      if (orderDetail.taskImagesPreview == 0) {
        setState(() {
          isConfidential = false;
        });
      }
      if (orderDetail.orderBExpiredTime != "" &&
          orderDetail.orderBExpiredTime != null) {
        setState(() {
          expiredDate = DateTime.parse(orderDetail.orderBExpiredTime!);
        });
      }
      setState(() {
        isLoading = false;
        status = orderDetail.orderStatus ?? 9;
      });

      if (status == 0) {
        setState(() {
          isSubmitted = true;
        });
      } else if (status == 1) {
        setState(() {
          isStarted = true;
        });
      } else if (status == 2) {
        setState(() {
          isFailed = true;
        });
      } else if (status == 7) {
        setState(() {
          isWaitingPaid = true;
        });
      } else if (status == 8) {
        isPaid = true;
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
            actions: [
              GestureDetector(
                onTap: () {
                  Get.to(
                      () => TicketSubmissionPage(
                            reportUserIDInitial: orderDetail.customerId,
                            reportTaskIDInitial: orderDetail.taskId,
                            complainType: 0,
                          ),
                      transition: Transition.rightToLeft);
                },
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
          child: isLoading
              ? MissionDetailLoading()
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MissionDetailIssuerCardComponent(
                          image: orderDetail.avatar ??
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9MU4SwesBOo_JPNEelanllG_YX_v4OWhdffpsPc0Gow&s",
                          title: orderDetail.nickname ?? "墩墩鸡",
                          action: "留言咨询 >",
                          onTap: () {}),
                      const SizedBox(
                        height: 12,
                      ),
                      MissionDetailDescriptionCardComponent(
                        taskId: orderDetail.taskId ?? 0,
                        title: orderDetail.taskTitle ?? "",
                        detail: orderDetail.taskContent ?? "",
                        tag: orderDetail.taskTagNames!
                                .map((tag) => tag.tagName)
                                .toList() ??
                            [],
                        totalSlot: orderDetail.taskQuota.toString() ?? "0",
                        leaveSlot: (orderDetail.taskQuota! -
                                    orderDetail.taskReceivedNum!)
                                .toString() ??
                            "0",
                        day: orderDetail.taskTimeLimit.toString() ?? "0",
                        duration:
                            orderDetail.taskEstimateTime.toString() ?? "0",
                        date: orderDetail.taskUpdatedTime.toString() ?? "",
                        price: orderDetail.taskSinglePrice.toString() ?? "",
                        isFavourite: isFavourite,
                        estimatedUnit: orderDetail.taskTimeLimitUnit ?? "天",
                        limitUnit: orderDetail.taskEstimateTimeUnit ?? "天",
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      missionDetailStepsCardComponent(
                        steps: orderDetail.taskProcedures?.step ?? [],
                        isConfidential: isConfidential,
                        isCollapsed: (isSubmitted ||
                                isExpired ||
                                isFailed ||
                                isWaitingPaid ||
                                isPaid)
                            ? false
                            : true,
                        isCollapseAble: (isSubmitted ||
                                isExpired ||
                                isFailed ||
                                isWaitingPaid ||
                                isPaid)
                            ? true
                            : false,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      (isStarted ||
                              isSubmitted ||
                              isExpired ||
                              isFailed ||
                              isWaitingPaid ||
                              isPaid)
                          ? MissionSubmissionCardComponent(
                              isEdit: isStarted ? true : false,
                              submissionPics:
                                  orderDetail.orderScreenshots?.image ?? [],
                              isCollapsed: isStarted ? true : false,
                              isCollapseAble: isStarted ? false : true,
                            )
                          : Container(
                              width: double.infinity,
                              child: missionNoticeCardComponent(),
                            ),
                      isFailed
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: missionFailedReasonCardComponent(
                                  reasonTitle: "拒绝理由",
                                  reasonDesc: orderDetail.orderRejectReason!),
                            )
                          : Container(),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          RichText(
                              text: TextSpan(
                                  style: missionIDtextStyle,
                                  children: [
                                TextSpan(text: "悬赏ID: "),
                                TextSpan(text: orderDetail.taskId.toString())
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: SvgPicture.asset(
                                "assets/mission/copy.svg",
                                width: 24,
                                height: 24,
                              ),
                            ),
                          )
                        ],
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
          child: isStarted
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
                          isLoading: false,
                          text: '提交',
                          textStyle: missionCardTitleTextStyle,
                          buttonColor: kMainYellowColor,
                          onPressed: () {
                            if (updateUploadList == [] ||
                                updateUploadList == null) {
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
                              });
                            } else {
                              setState(() {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialogComponent(
                                        alertTitle: '您即将提交该任务',
                                        alertDesc: RichText(
                                          text: TextSpan(
                                            style: alertDialogContentTextStyle,
                                            children: [
                                              TextSpan(
                                                  text: '点击确认后，该任务将被提交，\n'),
                                              TextSpan(
                                                text: '若审核未通过需自行承担后果(雇主不付款)。\n',
                                              ),
                                              TextSpan(text: '确定提交后不可重新编辑。\n'),
                                              TextSpan(
                                                text: '是否继续？\n',
                                              ),
                                            ],
                                          ),
                                        ),
                                        descTextStyle:
                                            alertDialogContentTextStyle,
                                        firstButtonText: '继续编辑',
                                        firstButtonTextStyle:
                                            alertDialogFirstButtonTextStyle,
                                        firstButtonColor: kThirdGreyColor,
                                        secondButtonText: '确认提交任务',
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
                                            bool? submit =
                                                await services.submitOrder(
                                                    widget.orderId!,
                                                    updateUploadList);

                                            if (submit!) {
                                              setState(() {
                                                Navigator.pop(context);
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
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
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor:
                                                      kMainGreyColor,
                                                  textColor: kThirdGreyColor);
                                            }
                                          } on Exception catch (e) {
                                            print("error in submission: $e");
                                          }
                                        },
                                      );
                                    });
                              });
                            }
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
                      text: isSubmitted
                          ? "待审核"
                          : isExpired
                              ? "已失效"
                              : isFailed
                                  ? "未通过"
                                  : isWaitingPaid
                                      ? "待到账"
                                      : isPaid
                                          ? "已到账"
                                          : "开始悬赏",
                      textStyle: (isSubmitted ||
                              isExpired ||
                              isFailed ||
                              isWaitingPaid ||
                              isPaid)
                          ? disableButtonTextStyle
                          : buttonTextStyle,
                      onPressed: (isSubmitted ||
                              isExpired ||
                              isFailed ||
                              isWaitingPaid ||
                              isPaid)
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
                                      secondButtonOnTap: () async {
                                        print(
                                            "what is the user Data: ${userData!.billingAddress}, and ${userData!.billingNetwork}");
                                        if (userData!.billingAddress != null &&
                                            userData!.billingAddress != "" &&
                                            userData!.billingNetwork != null &&
                                            userData!.billingNetwork != "") {
                                          try {
                                            int? create =
                                                await services.createOrder(
                                                    orderDetail.taskId!);

                                            if (create! != 0) {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              Get.to(() =>
                                                  MissionDetailRecipientPage(
                                                    orderId: create,
                                                  ));
                                              Fluttertoast.showToast(
                                                  msg: "悬赏开始",
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor:
                                                      kMainGreyColor,
                                                  textColor: kThirdGreyColor);
                                            } else {
                                              Navigator.pop(context);
                                              Fluttertoast.showToast(
                                                  msg: "悬赏失败，请重试",
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor:
                                                      kMainGreyColor,
                                                  textColor: kThirdGreyColor);
                                            }
                                          } catch (e) {
                                            Navigator.pop(context);
                                            Fluttertoast.showToast(
                                                msg: "不可重复悬赏",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: kMainGreyColor,
                                                textColor: kThirdGreyColor);
                                          }
                                        } else {
                                          setState(() {
                                            Navigator.pop(context);
                                            Get.to(
                                                () => RecipientInfoPage(
                                                    taskId:
                                                        orderDetail.taskId!),
                                                transition:
                                                    Transition.rightToLeft);
                                          });
                                        }
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
