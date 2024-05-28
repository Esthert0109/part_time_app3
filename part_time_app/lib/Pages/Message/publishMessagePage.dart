import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Constants/globalConstant.dart';
import '../../Components/List/messageListComponent.dart';
import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/notification/messageModel.dart';
import '../../Services/notification/systemMessageServices.dart';

class PublishMessagePage extends StatefulWidget {
  const PublishMessagePage({Key? key}) : super(key: key);

  @override
  State<PublishMessagePage> createState() => _PublishMessagePageState();
}

class _PublishMessagePageState extends State<PublishMessagePage> {
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  int page = 2;
  bool continueLoading = true;

  @override
  void initState() {
    super.initState();
    _readStatus();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
      final response = await SystemMessageServices().patchUpdateRead(3);
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
          await SystemMessageServices().getNotificationList(3, page);
      setState(() {
        if (data != null && data.data!.isNotEmpty) {
          publishMessageList.addAll(data.data!);
          page++;
        } else {
          continueLoading = false;
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
        publishMessageList.clear();
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
                    text: "发布通知",
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
                  children: publishMessageList.reversed.expand((date) {
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
                          isPayment: false,
                          isMission: true,
                          taskID: notification.taskId,
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

  @override
  void didUpdateWidget(covariant PublishMessagePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Scroll to bottom whenever the widget updates
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
