import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:part_time_app/Components/List/messageListComponent.dart';
import 'package:part_time_app/Pages/MockData/missionMockData.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class ToolMessagePage extends StatefulWidget {
  const ToolMessagePage({Key? key}) : super(key: key);

  @override
  State<ToolMessagePage> createState() => _ToolMessagePageState();
}

class _ToolMessagePageState extends State<ToolMessagePage> {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: SvgPicture.asset("assets/common/back_button.svg"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const Expanded(
                  flex: 12,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      "工单通知",
                      style: dialogText2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (ToolMessageList.isNotEmpty)
                  MessageList(
                    messageList: ToolMessageList,
                    isSystem: false,
                  ),
              ],
            ),
          ),
        ),
      ),
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
