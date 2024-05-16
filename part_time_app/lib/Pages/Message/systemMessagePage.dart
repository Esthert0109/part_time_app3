import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/List/messageListComponent.dart';
import 'package:part_time_app/Components/Loading/customRefreshComponent.dart';
import 'package:part_time_app/Pages/MockData/missionMockData.dart';
import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/apiConstant.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/globalConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/notification/messageModel.dart';
import '../../Services/notification/systemMessageServices.dart';

bool noInitialRefresh = true;

class SystemMessagePage extends StatefulWidget {
  const SystemMessagePage({Key? key}) : super(key: key);

  @override
  State<SystemMessagePage> createState() => _SystemMessagePageState();
}

class _SystemMessagePageState extends State<SystemMessagePage> {
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  int page = 2;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      NotificationListModel? data =
          await SystemMessageServices().getNotificationList(0, page);
      print("call the API");
      setState(() {
        if (data != null && data.data != null) {
          systemMessageList.addAll(data.data!);
        } else {
          // Handle the case when data is null or data.data is null
        }
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
      // Handle error
      setState(() {
        isLoading = false;
      });
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
      page = 1;
    });
    systemMessageList = [];
    _loadData();
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
            child: RefreshIndicator(
              onRefresh: _refresh,
              color: kMainYellowColor,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: systemMessageList.reversed.expand((date) {
                    List<Widget> widgets = [];
                    if (date.notifications != null &&
                        date.notifications!.isNotEmpty) {
                      // Add the date
                      widgets.add(
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 5),
                            child: Text(
                              date.date,
                              style: missionIDtextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                      // Add messages for the date
                      widgets.addAll(date.notifications!.map((notification) {
                        return MessageList(
                          title: notification.notificationTitle ?? "",
                          description: notification.notificationContent ?? "",
                          isSystem: true,
                        );
                      }).toList());
                    }
                    return widgets;
                  }).toList(),
                ),
              ),
            ),
          )),
    );
  }
}
