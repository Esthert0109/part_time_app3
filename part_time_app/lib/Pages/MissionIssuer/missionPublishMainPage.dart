import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  final TextEditingController descController = TextEditingController();

  String titleInput = "";

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
                        maxLength: 16,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        controller: titleController,
                        onChanged: (input) {
                          setState(() {
                            titleInput = input;
                            print("check input: ${titleInput}");
                          });
                        },
                        cursorColor: kMainYellowColor,
                        decoration: InputDecoration(
                            counterText: "",
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
                          "(${titleInput.length}/16)",
                          maxLines: 1,
                          style: inputCounterTextStyle,
                        ))
                  ],
                ),
              ),
              Container(
                height: 206,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                    color: kMainWhiteColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 8,
                      child: Container(
                        child: TextFormField(
                          maxLength: 120,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          controller: descController,
                          onChanged: (input) {
                            setState(() {});
                          },
                          cursorColor: kMainYellowColor,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                              counterStyle: inputCounterTextStyle,
                              hintText: "正文",
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
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 3,
                            child: GestureDetector(
                              onTap: () {
                                print("get tag");
                              },
                              child: Container(
                                height: 24,
                                margin: EdgeInsets.symmetric(horizontal: 6),
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 10),
                                decoration: BoxDecoration(
                                    color: kThirdGreyColor,
                                    borderRadius: BorderRadius.circular(13)),
                                child: Text(
                                  "选择标签",
                                  textAlign: TextAlign.center,
                                  style: unselectedThirdStatusTextStyle,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 7,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                      6,
                                      (index) => GestureDetector(
                                            onTap: () {
                                              print("delete tag");
                                            },
                                            child: Container(
                                              height: 24,
                                              margin: EdgeInsets.only(right: 6),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 4, horizontal: 10),
                                              decoration: BoxDecoration(
                                                  color: kThirdGreyColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          13)),
                                              child: IntrinsicWidth(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "急招",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          unselectedThirdStatusTextStyle,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 4, 0, 0),
                                                      child: SvgPicture.asset(
                                                        "assets/common/close2.svg",
                                                        width: 8,
                                                        height: 8,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                ),
                              ))
                        ],
                      ),
                    )
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
