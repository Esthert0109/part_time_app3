import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/List/messageListComponent.dart';
import 'package:part_time_app/Components/Loading/customRefreshComponent.dart';
import 'package:part_time_app/Pages/MockData/missionMockData.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/apiConstant.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/notification/messageModel.dart';
import '../../Services/notification/systemMessageServices.dart';
import '../../Utils/apiUtils.dart';

bool noInitialRefresh = true;

class SystemMessagePage extends StatefulWidget {
  const SystemMessagePage({Key? key}) : super(key: key);

  @override
  State<SystemMessagePage> createState() => _SystemMessagePageState();
}

class _SystemMessagePageState extends State<SystemMessagePage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: noInitialRefresh);
  ScrollController _scrollController = ScrollController();
  List<NotificationData> _notifications = [];
  @override
  void initState() {
    super.initState();
    // Scroll to bottom when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    // Dispose the controller when not needed
    _scrollController.dispose();
    super.dispose();
  }

  _loadData() async {
    String url = port + systemMessage;
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    final response = await getRequest(url, headers);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.responseBody)['data'];
      setState(() {
        _notifications = data
            .map((notification) => NotificationData.fromJson(notification))
            .toList();
      });
      print(response.responseBody);
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> _refresh() async {
    setState(() {
      noInitialRefresh = false;
    });
    _loadData();
    _refreshController.refreshCompleted();
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
                    text: "系统通知",
                  ))),
          body: Container(
            constraints: const BoxConstraints.expand(),
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
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
              onRefresh: _refresh,
              controller: _refreshController,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _notifications.map((notification) {
                    return MessageList(
                      title: notification.notificationTitle,
                      description: notification.notificationContent,
                      createdTime: notification.createdTime,
                      isSystem: true,
                    );
                  }).toList(),
                ),
              ),
            ),
          )),
    );
  }

  @override
  void didUpdateWidget(covariant SystemMessagePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Scroll to bottom whenever the widget updates
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
