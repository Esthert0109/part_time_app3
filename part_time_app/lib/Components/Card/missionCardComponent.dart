import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:part_time_app/Constants/colorConstant.dart';

import '../../Constants/textStyleConstant.dart';

class MissionCardComponent extends StatefulWidget {
  final String missionTitle;
  final String missionDesc;
  final List<String> tagList;
  final double missionPrice;
  final String userAvatar;
  final String username;
  final bool isStatus;
  final String? missionDate;
  final bool? isFavorite;
  final int? missionStatus;

  const MissionCardComponent({
    super.key,
    required this.missionTitle,
    required this.missionDesc,
    required this.tagList,
    required this.missionPrice,
    required this.userAvatar,
    required this.username,
    required this.isStatus,
    this.missionDate,
    this.isFavorite,
    this.missionStatus,
  });

  @override
  State<MissionCardComponent> createState() => _MissionCardComponentState();
}

class _MissionCardComponentState extends State<MissionCardComponent> {
  int? status;
  TextStyle? statusTextStyle;
  String? statusText;

  @override
  Widget build(BuildContext context) {
    bool isFavorite = widget.isFavorite ?? false;

    // set status color and text style
    status = widget.missionStatus;
    if (status != null) {
      switch (status) {
        case 0:
          statusTextStyle = missionStatusOrangeTextStyle;
          statusText = "待审核";
          break;
        case 1:
          statusTextStyle = missionStatusOrangeTextStyle;
          statusText = "待完成";
          break;
        case 2:
          statusTextStyle = missionStatusRedTextStyle;
          statusText = "未通过";
          break;
        case 3:
          statusTextStyle = missionStatusGreenTextStyle;
          statusText = "已通过";
          break;
        case 4:
          statusTextStyle = missionStatusGreyTextStyle;
          statusText = "已完成";
          break;
        case 5:
          statusTextStyle = missionStatusOrangeTextStyle;
          statusText = "待退款";
          break;
        case 6:
          statusTextStyle = missionStatusGreyTextStyle;
          statusText = "已退款";
          break;
        case 7:
          statusTextStyle = missionStatusOrangeTextStyle;
          statusText = "待到账";
          break;
        case 8:
          statusTextStyle = missionStatusGreyTextStyle;
          statusText = "已到账";
          break;
      }
    }

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
                  child: SizedBox(
                    height: 24,
                    child: Text(
                      widget.missionTitle,
                      style: missionCardTitleTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
              widget.isStatus
                  ? Flexible(
                      flex: 2,
                      child: SizedBox(
                        height: 24,
                        // width: 24,
                        child: Text(
                          textAlign: TextAlign.start,
                          statusText!,
                          style: statusTextStyle,
                        ),
                      ))
                  : Flexible(
                      flex: 1,
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: isFavorite
                            ? SvgPicture.asset(
                                "assets/mission/favorite_selected.svg")
                            : SvgPicture.asset(
                                "assets/mission/favorite_unselected.svg"),
                      ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              widget.missionDesc,
              style: missionCardDescTextStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 5,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        widget.tagList.length,
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
                                            text: widget.tagList[index],
                                            style: missionTagTextStyle)
                                      ]),
                                ))),
                      ),
                    ),
                  ),
                ),
                Flexible(
                    flex: 5,
                    child: RichText(
                      textAlign: TextAlign.right,
                      text: TextSpan(
                          text: widget.missionPrice.toString(),
                          style: missionPriceTextStyle,
                          children: [
                            TextSpan(
                                text: ' USDT', style: missionPriceTextStyle)
                          ]),
                    ))
              ],
            ),
          ),
          Container(
            height: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: kSecondGreyColor,
                  foregroundImage: NetworkImage(widget.userAvatar),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    widget.username,
                    style: missionUsernameTextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                status == 0
                    ? Container()
                    : RichText(
                        textAlign: TextAlign.right,
                        text: TextSpan(
                            text: "发布日期 ",
                            style: missionDateTextStyle,
                            children: [
                              TextSpan(
                                  text: widget.missionDate,
                                  style: missionDateTextStyle)
                            ]))
              ],
            ),
          )
        ],
      ),
    );
  }
}
