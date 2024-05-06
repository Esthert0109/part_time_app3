import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:part_time_app/Components/Message/messageCardComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Components/Title/secondaryTitleComponent.dart';

class MessageMainPage extends StatefulWidget {
  const MessageMainPage({super.key});

  @override
  State<MessageMainPage> createState() => _MessageMainPageState();
}

class _MessageMainPageState extends State<MessageMainPage> {
  final PageController _controller = PageController();
  int titleSelection = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
          title: Container(
        color: kTransparent,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SecondaryTitleComponent(
          titleList: ["我接收的"],
          selectedIndex: titleSelection,
          onTap: (index) {
            setState(() {
              titleSelection = index;
              _controller.animateToPage(index,
                  duration: Duration(milliseconds: 600),
                  curve: Curves.easeInOut);
            });
          },
        ),
      )),
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
            child: MessageCardComponent(),
          ),
        ],
      ),
    );
  }
}
