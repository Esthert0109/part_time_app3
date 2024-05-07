import 'package:flutter/material.dart';

import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class SystemMessagePage extends StatefulWidget {
  const SystemMessagePage({super.key});

  @override
  State<SystemMessagePage> createState() => _SystemMessagePageState();
}

class _SystemMessagePageState extends State<SystemMessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
          title: Container(
        color: kTransparent,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Padding(
          padding: EdgeInsets.only(left: 75),
          child: Text("系统通知"),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              systemMessage("8:00am", "2.0版本已更新", "您的版本已更新至 2.0 版本。"),
              systemMessage(
                  "8:00am", "悬赏已成功下架", "您发布的悬赏 (悬赏 ID: 123456789 ) 已成功下架。"),
              systemMessage("8:00am", "悬赏赏金已发放！", "您的悬赏 [标题] 已发放200USDT至B用户。")
            ],
          ),
        ),
      ),
    );
  }
}

Widget systemMessage(
  String time,
  String title,
  String description,
) {
  return Container(
    child: Column(
      children: [
        SizedBox(height: 20),
        Text(time, style: missionIDtextStyle),
        SizedBox(height: 15),
        Container(
          width: 350,
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
              color: kMainWhiteColor, borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: missionCheckoutInputTextStyle,
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10),
              Text(
                description,
                style: missionDetailText2,
              ),
            ],
          ),
        )
      ],
    ),
  );
}
