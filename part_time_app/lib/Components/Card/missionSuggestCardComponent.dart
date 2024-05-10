import 'package:flutter/material.dart';

import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../Loading/missionSuggestLoading.dart';

class MissionSuggestCardComponent extends StatefulWidget {
  final String userAvatar;
  final String title;
  final List<String> tags;
  final String price;
  final int requiredNo;
  final int completedNo;
  final bool isLoading;

  const MissionSuggestCardComponent(
      {super.key,
      required this.userAvatar,
      required this.title,
      required this.tags,
      required this.price,
      required this.requiredNo,
      required this.completedNo,
      required this.isLoading});

  @override
  State<MissionSuggestCardComponent> createState() =>
      _MissionSuggestCardComponentState();
}

class _MissionSuggestCardComponentState
    extends State<MissionSuggestCardComponent> {
  @override
  Widget build(BuildContext context) {
    int leftNo = widget.requiredNo - widget.completedNo;
    return widget.isLoading
        ? MissionSuggestLoading()
        : Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            height: 77,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(widget.userAvatar),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: suggestTitleTextStyle,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Row(
                        children: List.generate(
                          widget.tags.length,
                          (index) => Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                              child: InkWell(
                                  onTap: () {
                                    // print(
                                    //     "navi to the tag search page: ${widget.tag?[index] ?? 'nothing'}");
                                    // Get.to(() => SearchResultPage(
                                    //       from: 'tag',
                                    //       selectedTag: widget.tag?[index],
                                    //     ));
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                        text: "#",
                                        style: suggestTagTextStyle,
                                        children: [
                                          TextSpan(
                                              text: widget.tags[index],
                                              style: suggestTagTextStyle)
                                        ]),
                                  ))),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LinearProgressIndicator(
                            value: widget.completedNo / widget.requiredNo,
                            backgroundColor: kbarBackgroundColor,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(kMainYellowColor),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          Text(
                            "${widget.completedNo.toString()}人已赚 仅余${leftNo.toString()}名额",
                            style: suggestNoTextStyle,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RichText(
                          text:
                              TextSpan(style: suggestPriceTextStyle, children: [
                        TextSpan(text: widget.price),
                        TextSpan(text: " USDT"),
                      ])),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            backgroundColor: kRejectMissionButtonColor,
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            alignment: Alignment.center,
                            fixedSize: const Size.fromHeight(30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        onPressed: () {},
                        child: Text(
                          "立刻赚钱",
                          style: primaryTextFieldErrorTextStyle,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
