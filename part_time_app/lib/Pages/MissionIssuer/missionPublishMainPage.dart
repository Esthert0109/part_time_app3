import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Title/secondaryTitleComponent.dart';

import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class MissionPublishMainPage extends StatefulWidget {
  const MissionPublishMainPage({super.key});

  @override
  State<MissionPublishMainPage> createState() => _MissionPublishMainPageState();
}

class _MissionPublishMainPageState extends State<MissionPublishMainPage> {
  final TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SecondaryTitleComponent(
            titleList: ["发布悬赏"],
            selectedIndex: 0,
            onTap: (int) {},
          ),
        ),
        leadingWidth: double.infinity,
      ),
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: kMainWhiteColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 85,
                      child: TextFormField(
                        controller: titleController,
                        onTap: () {
                          setState(() {
                            // isSearching = false;
                          });
                        },
                        decoration: InputDecoration(
                            hintText: "标题",
                            hintStyle: messageDescTextStyle2,
                            border: InputBorder.none),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '请输入标题';
                          }
                          return null;
                        },
                      ),
                    ),
                    Flexible(
                        flex: 15,
                        child: Text(
                          "(0/16)",
                          maxLines: 1,
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
