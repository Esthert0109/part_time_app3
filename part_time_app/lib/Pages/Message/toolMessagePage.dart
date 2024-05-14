import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/List/messageListComponent.dart';
import 'package:part_time_app/Pages/MockData/missionMockData.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../Components/Loading/customRefreshComponent.dart';
import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

bool noInitialRefresh = true;

class ToolMessagePage extends StatefulWidget {
  const ToolMessagePage({Key? key}) : super(key: key);

  @override
  State<ToolMessagePage> createState() => _ToolMessagePageState();
}

class _ToolMessagePageState extends State<ToolMessagePage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: noInitialRefresh);
  ScrollController _scrollController = ScrollController();
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
    await Future.delayed(Duration(seconds: 1));
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
                    text: "工单通知",
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
                  children: [
                    // if (ToolMessageList.isNotEmpty)
                    //   MessageList(
                    //     messageList: ToolMessageList,
                    //     isSystem: false,
                    //   ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  @override
  void didUpdateWidget(covariant ToolMessagePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Scroll to bottom whenever the widget updates
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
