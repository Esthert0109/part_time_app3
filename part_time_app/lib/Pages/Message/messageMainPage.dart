import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:part_time_app/Components/Message/messageCardComponent.dart';
import '../../Components/Common/countdownTimer.dart';
import '../../Constants/colorConstant.dart';
import 'package:part_time_app/Components/Button/primaryButtonComponent.dart';
import 'package:part_time_app/Components/Card/missionPublishCheckoutCardComponent.dart';
import 'package:part_time_app/Pages/UserAuth/changePassword.dart';
import 'package:part_time_app/Pages/UserAuth/loginPage.dart';
import 'package:part_time_app/Pages/UserAuth/otpCode.dart';
import 'package:part_time_app/Pages/UserAuth/signupPage.dart';

import '../../Constants/textStyleConstant.dart';
import '../../Components/Title/secondaryTitleComponent.dart';
import '../MockData/missionMockData.dart';

class MessageMainPage extends StatefulWidget {
  const MessageMainPage({Key? key}) : super(key: key);

  @override
  _MessageMainPageState createState() => _MessageMainPageState();
}

class _MessageMainPageState extends State<MessageMainPage> {
  final PageController _controller = PageController();
  int titleSelection = 0;
  late String latestSystemMessageDate;
  late String? latestSystemMessageDescription;
  late String latestMissionMessageDate;
  late String? latestMissionMessageDescription;
  late String latestPaymentMessageDate;
  late String? latestPaymentMessageDescription;
  late String latestPostingMessageDate;
  late String? latestPostingMessageDescription;
  late String latestToolMessageDate;
  late String? latestToolMessageDescription;

  @override
  void initState() {
    super.initState();
    latestSystemMessageDate =
        systemMessageList.isNotEmpty ? systemMessageList.last.createdTime : "";
    latestSystemMessageDescription =
        systemMessageList.isNotEmpty ? systemMessageList.last.description : "";
    latestMissionMessageDate = MissionMessageList.isNotEmpty
        ? MissionMessageList.last.createdTime
        : "";
    latestMissionMessageDescription = MissionMessageList.isNotEmpty
        ? MissionMessageList.last.description
        : "";
    latestPaymentMessageDate = PaymentMessageList.isNotEmpty
        ? PaymentMessageList.last.createdTime
        : "";
    latestPaymentMessageDescription = PaymentMessageList.isNotEmpty
        ? PaymentMessageList.last.description
        : "";
    latestPostingMessageDate = PostingMessageList.isNotEmpty
        ? PostingMessageList.last.createdTime
        : "";
    latestPostingMessageDescription = PostingMessageList.isNotEmpty
        ? PostingMessageList.last.description
        : "";
    latestToolMessageDate =
        ToolMessageList.isNotEmpty ? ToolMessageList.last.createdTime : "";
    latestToolMessageDescription =
        ToolMessageList.isNotEmpty ? ToolMessageList.last.description : "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SecondaryTitleComponent(
            titleList: ["我接收的"],
            selectedIndex: titleSelection,
            onTap: (index) {
              setState(() {
                titleSelection = index;
                _controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                );
              });
            },
          ),
        ),
      ),
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) {
          setState(() {
            titleSelection = index;
          });
        },
        children: <Widget>[
          Container(
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
              child: MessageCardComponent(
                systemDate: latestSystemMessageDate,
                systemDetail: latestSystemMessageDescription,
                missionDate: latestMissionMessageDate,
                missionDetail: latestMissionMessageDescription,
                paymentDate: latestPaymentMessageDate,
                paymentDetail: latestPaymentMessageDescription,
                postingDate: latestPostingMessageDate,
                postingDetail: latestPostingMessageDescription,
                toolDate: latestToolMessageDate,
                toolDetail: latestToolMessageDescription,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
