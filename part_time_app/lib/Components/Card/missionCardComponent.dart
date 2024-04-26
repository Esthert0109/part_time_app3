import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:part_time_app/Constants/colorConstant.dart';

import '../../Constants/textStyleConstant.dart';

class MissionCardComponent extends StatefulWidget {
  const MissionCardComponent({super.key});

  @override
  State<MissionCardComponent> createState() => _MissionCardComponentState();
}

class _MissionCardComponentState extends State<MissionCardComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 162,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: kMainWhiteColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 9,
                  child: Text(
                    "文案写作文案写作文文案写作文案写作文文案写作文案写作文",
                    style: missionCardTitleTextStyle,
                    overflow: TextOverflow.ellipsis,
                  )),
              Flexible(
                  flex: 1,
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: SvgPicture.asset(
                        "assets/mission/favorite_selected.svg"),
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              "负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写，负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写，负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写，负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写，负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写",
              style: missionCardDescTextStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        5,
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
                                      style: missionHashtagTextStyle,
                                      children: [
                                        TextSpan(
                                            text: '写作',
                                            style: missionTagTextStyle)
                                      ]),
                                ))),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: RichText(
                      textAlign: TextAlign.right,
                      text: TextSpan(
                          text: '500000',
                          style: missionPriceTextStyle,
                          children: [
                            TextSpan(
                                text: ' USDT', style: missionPriceTextStyle)
                          ]),
                    ))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar()
            ],
          )
        ],
      ),
    );
  }
}
