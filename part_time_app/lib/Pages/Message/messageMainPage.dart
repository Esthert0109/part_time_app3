import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:part_time_app/Components/Loading/customRefreshComponent.dart';
import 'package:part_time_app/Components/Message/messageCardComponent.dart';
import '../../Components/Common/countdownTimer.dart';
import '../../Constants/colorConstant.dart';
import 'package:part_time_app/Components/Button/primaryButtonComponent.dart';
import 'package:part_time_app/Components/Card/missionPublishCheckoutCardComponent.dart';
import 'package:part_time_app/Pages/UserAuth/changePassword.dart';
import 'package:part_time_app/Pages/UserAuth/loginPage.dart';
import 'package:part_time_app/Pages/UserAuth/otpCode.dart';
import 'package:part_time_app/Pages/UserAuth/signupPage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Components/Title/secondaryTitleComponent.dart';

class MessageMainPage extends StatefulWidget {
  const MessageMainPage({super.key});

  @override
  State<MessageMainPage> createState() => _MessageMainPageState();
}

class _MessageMainPageState extends State<MessageMainPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int titleSelection = 0;
  bool _isLoading = true;
  double _scrollPosition = 0;

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

  Widget _buildLoadingIndicator() {
    return LoadingAnimationWidget.stretchedDots(
        color: kMainYellowColor, size: 50);
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
                    MessageCardComponent(),
                  ],
                ),
              )),
        ));
  }
}
