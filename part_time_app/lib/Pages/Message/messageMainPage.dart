import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:part_time_app/Components/Loading/customRefreshComponent.dart';
import 'package:part_time_app/Components/Message/messageCardComponent.dart';
import 'package:part_time_app/Constants/globalConstant.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';
import '../../Constants/colorConstant.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Components/Title/secondaryTitleComponent.dart';

class MessageMainPage extends StatefulWidget {
  const MessageMainPage({Key? key}) : super(key: key);

  @override
  _MessageMainPageState createState() => _MessageMainPageState();
}

class _MessageMainPageState extends State<MessageMainPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int titleSelection = 0;
  bool _isLoading = true;
  double _scrollPosition = 0;
  late String latestSystemMessageDate;
  late String? latestSystemMessageDescription;
  // late String latestMissionMessageDate;
  // late String? latestMissionMessageDescription;
  // late String latestPaymentMessageDate;
  // late String? latestPaymentMessageDescription;
  // late String latestPostingMessageDate;
  // late String? latestPostingMessageDescription;
  // late String latestToolMessageDate;
  // late String? latestToolMessageDescription;
  int? totalSystemUnread =
      notificationTips?.responseData?['系统通知']?.notificationTotalUnread;

  // test on global

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 2000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 100));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  Future<void> _refresh() async {
    // Add your refresh logic here
    setState(() {
      // Set _isLoading to true to show loading animation
      _isLoading = true;
    });

    // Simulate a delay for demonstration purposes
    await Future.delayed(Duration(seconds: 10));

    setState(() {
      // Set _isLoading to false to hide loading animation
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    latestSystemMessageDate = systemMessageList.isNotEmpty &&
            systemMessageList[0].notifications != null &&
            systemMessageList[0].notifications!.isNotEmpty
        ? systemMessageList[0].notifications![0].createdTime ?? ""
        : "";
    latestSystemMessageDescription = systemMessageList.isNotEmpty &&
            systemMessageList[0].notifications != null &&
            systemMessageList[0].notifications!.isNotEmpty
        ? systemMessageList[0].notifications![0].notificationTitle ?? ""
        : "";
    // latestMissionMessageDate = MissionMessageList.isNotEmpty
    //     ? MissionMessageList.last.createdTime
    //     : "";
    // latestMissionMessageDescription = MissionMessageList.isNotEmpty
    //     ? MissionMessageList.last.description
    //     : "";
    // latestPaymentMessageDate = PaymentMessageList.isNotEmpty
    //     ? PaymentMessageList.last.createdTime
    //     : "";
    // latestPaymentMessageDescription = PaymentMessageList.isNotEmpty
    //     ? PaymentMessageList.last.description
    //     : "";
    // latestPostingMessageDate = PostingMessageList.isNotEmpty
    //     ? PostingMessageList.last.createdTime
    //     : "";
    // latestPostingMessageDescription = PostingMessageList.isNotEmpty
    //     ? PostingMessageList.last.description
    //     : "";
    // latestToolMessageDate =
    //     ToolMessageList.isNotEmpty ? ToolMessageList.last.createdTime : "";
    // latestToolMessageDescription =
    //     ToolMessageList.isNotEmpty ? ToolMessageList.last.description : "";
    getMessageFromSharedPreferences();
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
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Container(
              color: kTransparent,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: SecondaryTitleComponent(
                titleList: ["我接收的"],
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
          child: CustomRefreshComponent(
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              controller: _refreshController,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    MessageCardComponent(
                      systemDate: latestSystemMessageDate,
                      systemDetail: latestSystemMessageDescription,
                      systemTotalMessage: totalSystemUnread,
                      // missionDate: latestMissionMessageDate,
                      // missionDetail: latestMissionMessageDescription,
                      // paymentDate: latestPaymentMessageDate,
                      // paymentDetail: latestPaymentMessageDescription,
                      // postingDate: latestPostingMessageDate,
                      // postingDetail: latestPostingMessageDescription,
                      // toolDate: latestToolMessageDate,
                      // toolDetail: latestToolMessageDescription,
                    ),
                    Text(notificationTips!
                        .responseData!['系统通知']!.notificationTotalUnread
                        .toString()),
                    Text(
                      systemMessageList.isNotEmpty &&
                              systemMessageList[0].notifications != null &&
                              systemMessageList[0].notifications!.isNotEmpty
                          ? systemMessageList[0]
                                  .notifications![0]
                                  .notificationTitle ??
                              ""
                          : "",
                    ),
                    Text(
                      missionMessageList.isNotEmpty &&
                              missionMessageList[0].notifications != null &&
                              missionMessageList[0].notifications!.isNotEmpty
                          ? missionMessageList[0]
                                  .notifications![0]
                                  .notificationTitle ??
                              ""
                          : "",
                    ),
                    Text(
                      paymentMessageList.isNotEmpty &&
                              paymentMessageList[0].notifications != null &&
                              paymentMessageList[0].notifications!.isNotEmpty
                          ? paymentMessageList[0]
                                  .notifications![0]
                                  .notificationTitle ??
                              ""
                          : "",
                    ),
                    Text(
                      publishMessageList.isNotEmpty &&
                              publishMessageList[0].notifications != null &&
                              publishMessageList[0].notifications!.isNotEmpty
                          ? publishMessageList[0]
                                  .notifications![0]
                                  .notificationTitle ??
                              ""
                          : "",
                    ),
                    Text(
                      ticketingMessageList.isNotEmpty &&
                              ticketingMessageList[0].notifications != null &&
                              ticketingMessageList[0].notifications!.isNotEmpty
                          ? ticketingMessageList[0]
                                  .notifications![0]
                                  .notificationTitle ??
                              ""
                          : "",
                    ),
                  ],
                ),
              )),
        ));
  }
}
