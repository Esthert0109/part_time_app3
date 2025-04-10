import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:part_time_app/Components/Message/messageCardComponent.dart';
import 'package:part_time_app/Constants/globalConstant.dart';
import 'package:part_time_app/Pages/Message/user/chatConfig.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_value_callback.dart';
import 'package:tencent_cloud_chat_uikit/tencent_cloud_chat_uikit.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Components/Title/secondaryTitleComponent.dart';
import '../../Model/notification/messageModel.dart';
import '../../Services/notification/systemMessageServices.dart';
import 'package:provider/provider.dart';
import '../../Services/WebSocket/webSocketService.dart';

List<V2TimConversation> _conversationList = [];

class MessageMainPage extends StatefulWidget {
  const MessageMainPage({Key? key}) : super(key: key);

  @override
  _MessageMainPageState createState() => _MessageMainPageState();
}

class _MessageMainPageState extends State<MessageMainPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int titleSelection = 0;
  bool isLoading = false;
  late String? latestSystemMessageDate;
  late String? latestSystemMessageDescription;
  late String? latestMissionMessageDate;
  late String? latestMissionMessageDescription;
  late String? latestPaymentMessageDate;
  late String? latestPaymentMessageDescription;
  late String? latestPublishMessageDate;
  late String? latestPublishMessageDescription;
  late String? latestTicketingMessageDate;
  late String? latestTicketingMessageDescription;

  @override
  void initState() {
    super.initState();
    webSocketService.addListener(_updateState);

    // _tencent();
    getMessageFromSharedPreferences();
  }

  // Future<void> _tencent() async {
  //   bool isLoginTencent = await userTencentLogin('2206');
  //   print("tencent:${isLoginTencent}");
  // }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      NotificationTipsModel? data =
          await SystemMessageServices().getNotificationTips();
      // print();
      setState(() {
        if (data != null && data.data != null) {
          notificationTips = data.data!;
          print("Received data: $notificationTips"); // Print received data
        } else {
          // Handle the case when data is null or data.data is null
        }
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
      // Handle error
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      ;
    }
  }

  Future<void> _refresh() async {
    if (!isLoading && mounted) {
      setState(() {
        notificationTips?.responseData.clear();
        _loadData();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  getMessageFromSharedPreferences() async {
    systemMessageList = (await SharedPreferencesUtils.getSystemMessageList())!;
    missionMessageList =
        (await SharedPreferencesUtils.getMissionMessageList())!;
    paymentMessageList =
        (await SharedPreferencesUtils.getPaymentMessageList())!;
    publishMessageList =
        (await SharedPreferencesUtils.getPublishMessageList())!;
    ticketingMessageList =
        (await SharedPreferencesUtils.getTicketMessageList())!;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Container(
              color: kTransparent,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: SecondaryTitleComponent(
                titleList: const ["消息"],
                selectedIndex: titleSelection,
                onTap: (index) {},
              ),
            )),
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
          child: RefreshIndicator(
              onRefresh: _refresh,
              color: kMainYellowColor,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    MessageCardComponent(
                      //system
                      systemDate:
                          notificationTips?.responseData['系统通知']?.createdTime,
                      systemDetail: notificationTips
                          ?.responseData['系统通知']?.notificationContent,
                      systemTotalMessage: notificationTips
                          ?.responseData['系统通知']?.notificationTotalUnread,
                      // mission
                      missionDate:
                          notificationTips?.responseData['悬赏通知']?.createdTime,
                      missionDetail: notificationTips
                          ?.responseData['悬赏通知']?.notificationContent,
                      missionTotalMessage: notificationTips
                          ?.responseData['悬赏通知']?.notificationTotalUnread,
                      //payment
                      paymentDate:
                          notificationTips?.responseData['款项通知']?.createdTime,
                      paymentDetail: notificationTips
                          ?.responseData['款项通知']?.notificationContent,
                      paymentTotalMessage: notificationTips
                          ?.responseData['款项通知']?.notificationTotalUnread,
                      //publish
                      postingDate:
                          notificationTips?.responseData['发布通知']?.createdTime,
                      postingDetail: notificationTips
                          ?.responseData['发布通知']?.notificationContent,
                      postingTotalMessage: notificationTips
                          ?.responseData['发布通知']?.notificationTotalUnread,
                      //ticketing
                      toolDate:
                          notificationTips?.responseData['工单通知']?.createdTime,
                      toolDetail: notificationTips
                          ?.responseData['工单通知']?.notificationContent,
                      toolTotalMessage: notificationTips
                          ?.responseData['工单通知']?.notificationTotalUnread,
                      //user
                    ),
                  ],
                ),
              )),
        ));
  }
}
