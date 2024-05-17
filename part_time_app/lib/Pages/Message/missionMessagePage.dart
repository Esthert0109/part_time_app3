import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/List/messageListComponent.dart';
import 'package:part_time_app/Constants/globalConstant.dart';
import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/notification/messageModel.dart';
import '../../Services/notification/systemMessageServices.dart';

class MissionMessagePage extends StatefulWidget {
  const MissionMessagePage({Key? key}) : super(key: key);

  @override
  State<MissionMessagePage> createState() => _MissionMessagePageState();
}

class _MissionMessagePageState extends State<MissionMessagePage> {
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  int page = 2;
  bool continueLoading = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _readStatus();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      if (!isLoading && continueLoading) {
        _loadData();
      }
    }
  }

  Future<void> _readStatus() async {
    try {
      final response = await SystemMessageServices().patchUpdateRead(1);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      NotificationListModel? data =
          await SystemMessageServices().getNotificationList(1, page);

      setState(() {
        if (data != null && data.data != null) {
          missionMessageList.addAll(data.data!);
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

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    if (!isLoading && mounted) {
      setState(() {
        missionMessageList.clear();
        page = 1;
        continueLoading = true;
        _loadData();
      });
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
              centerTitle: true,
              title: Container(
                  color: kTransparent,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: thirdTitleComponent(
                    text: "悬赏通知",
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
                  children: missionMessageList.reversed.expand((date) {
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
                          isSystem: false,
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
