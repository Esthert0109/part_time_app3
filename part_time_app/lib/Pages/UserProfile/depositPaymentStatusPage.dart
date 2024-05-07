import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Card/missionSuggestCardComponent.dart';

import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class DepositPaymentStatusPage extends StatefulWidget {
  final bool isPass;
  final bool isFailed;
  const DepositPaymentStatusPage(
      {super.key, required this.isPass, required this.isFailed});

  @override
  State<DepositPaymentStatusPage> createState() =>
      _DepositPaymentStatusPageState();
}

class _DepositPaymentStatusPageState extends State<DepositPaymentStatusPage> {
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
                  text: "等待审核",
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
                Container(
                  height: 223,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 15,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                    height: 156,
                                    width: 25,
                                    child: SvgPicture.asset(
                                        "assets/status/statusLine.svg")),
                                Positioned(
                                    top: 0,
                                    child: SvgPicture.asset(
                                      "assets/status/statusPass.svg",
                                      width: 24,
                                      height: 24,
                                    )),
                                Positioned(
                                    top: 60,
                                    child: SvgPicture.asset(
                                        "assets/status/iconWait.svg",
                                        width: 24,
                                        height: 24)),
                                Positioned(
                                    top: 132,
                                    child: SvgPicture.asset(
                                        widget.isPass
                                            ? "assets/status/statusPass.svg"
                                            : widget.isFailed
                                                ? "assets/status/statusFail.svg"
                                                : "assets/status/statusWait.svg",
                                        width: 24,
                                        height: 24)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 85,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Container(
                                height: 180,
                              ),
                              Positioned(
                                top: 2,
                                child: Text(
                                  "提交成功",
                                  style: missionFailedReasonTitleTextStyle,
                                ),
                              ),
                              Positioned(
                                  top: 60,
                                  child: Container(
                                    width: 280,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "等待系统审核",
                                          style:
                                              missionFailedReasonTitleTextStyle,
                                        ),
                                        Text(
                                          "系统将在7天内审核，请耐心等待。",
                                          style: missionIDtextStyle,
                                        )
                                      ],
                                    ),
                                  )),
                              Positioned(
                                  top: 135,
                                  child: Container(
                                    width: 280,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "审核状态",
                                          style: (widget.isPass ||
                                                  widget.isFailed)
                                              ? missionFailedReasonTitleTextStyle
                                              : missionSubmissionNoPicsTextStyle,
                                        ),
                                        RichText(
                                            text: TextSpan(
                                                style: missionIDtextStyle,
                                                children: [
                                              TextSpan(
                                                  text: widget.isPass
                                                      ? "已通过"
                                                      : "等待中"),
                                              TextSpan(
                                                  text: widget.isFailed
                                                      ? " - "
                                                      : ""),
                                              TextSpan(
                                                  text: widget.isFailed
                                                      ? "重新编辑"
                                                      : "",
                                                  style:
                                                      missionNoticeCardBlueTextStyle)
                                            ]))
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                widget.isFailed
                    ? Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: kMainWhiteColor),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "审核反馈",
                                style: missionCheckoutInputTextStyle,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "您所提交的存在图片不够清晰问题，请及时修改及时上传。您所提交的存在图片不够清晰问题，请及时修改及时上传。您所提交的存在图片不够清晰问题，请及时修改及时上传。您所提交的存在图片不够清晰问题，请及时修改及时上传。",
                                style: rejectReasonTextStyle,
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      Container(
                          height: 20,
                          child: Center(
                            child: Text(
                              "继续赚钱",
                              style:
                                  TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                            ),
                          )),
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 15),
                        child: Center(
                          child: Text(
                            "为您精挑细选的悬赏 今日必赚!",
                            style: missionIDtextStyle,
                          ),
                        ),
                      ),
                      Container(
                        height: 190,
                        child: SingleChildScrollView(
                          child: Column(children: [
                            Container(
                              margin: EdgeInsets.all(2),
                              child: MissionSuggestCardComponent(
                                userAvatar:
                                    "https://img12.360buyimg.com/n1/jfs/t1/92208/30/34431/74002/653c811dF23d72da4/a57277448cc9f1ff.jpg",
                                title: '文案写作文案写作文',
                                tags: ["其他", "其他", "其他"],
                                price: '50000',
                                requiredNo: 1046,
                                completedNo: 196,
                              ),
                            ),
                            Divider(
                              color: kThirdGreyColor,
                            ),
                            Container(
                              margin: EdgeInsets.all(2),
                              child: MissionSuggestCardComponent(
                                userAvatar:
                                    "https://img12.360buyimg.com/n1/jfs/t1/92208/30/34431/74002/653c811dF23d72da4/a57277448cc9f1ff.jpg",
                                title: '文案写作文案写作文',
                                tags: ["其他", "其他", "其他"],
                                price: '50000',
                                requiredNo: 1046,
                                completedNo: 852,
                              ),
                            ),
                          ]),
                        ),
                      )
                    ],
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
