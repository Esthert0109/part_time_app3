import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class MissionDetailDescriptionCardComponent extends StatefulWidget {
  final String title;
  final String detail;
  final List<String> tag;
  final String totalSlot;
  final String leaveSlot;
  final String day;
  final String duration;
  final String date;
  final String price;

  const MissionDetailDescriptionCardComponent({
    Key? key,
    required this.title,
    required this.detail,
    required this.tag,
    required this.totalSlot,
    required this.leaveSlot,
    required this.day,
    required this.duration,
    required this.date,
    required this.price,
  });

  @override
  State<MissionDetailDescriptionCardComponent> createState() =>
      _MissionDetailDescriptionCardComponentState();
}

class _MissionDetailDescriptionCardComponentState
    extends State<MissionDetailDescriptionCardComponent> {
  bool _favoriteClick = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 15),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: kMainWhiteColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: missionDetailText1,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.only(left: 15),
                  highlightColor: kTransparentColor,
                  icon: Icon(
                    size: 24,
                    _favoriteClick
                        ? Icons.favorite_border_outlined
                        : Icons.favorite,
                    color: kTransparentColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _favoriteClick = !_favoriteClick;
                    });
                  },
                ),
              ],
            ),
          ),
          Text(
            widget.detail,
            style: missionDetailText2,
          ),
          SizedBox(height: 8),
          Container(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List.generate(
                        widget.tag.length,
                        (index) => Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: RichText(
                                text: TextSpan(
                                    text: "#",
                                    style: missionHashtagTextStyle,
                                    children: [
                                      TextSpan(
                                          text: widget.tag[index],
                                          style: missionTagTextStyle)
                                    ]),
                              ),
                            )))),
          ),
          SizedBox(height: 8),
          Container(
            child: Row(
              children: [
                Text("总名额", style: missionDetailText4),
                SizedBox(width: 5),
                Text(widget.totalSlot + "人", style: bottomNaviBarTextStyle),
                SizedBox(width: 20),
                Text("剩余名额", style: missionDetailText4),
                SizedBox(width: 5),
                Text(widget.leaveSlot + "人", style: bottomNaviBarTextStyle),
              ],
            ),
          ),
          SizedBox(height: 8),
          Container(
            child: Row(
              children: [
                Text("悬赏时限", style: missionDetailText4),
                SizedBox(width: 5),
                Text(widget.day + "天", style: bottomNaviBarTextStyle),
                SizedBox(width: 20),
                Text("预计耗时", style: missionDetailText4),
                SizedBox(width: 5),
                Text(widget.duration + "小时", style: bottomNaviBarTextStyle),
              ],
            ),
          ),
          SizedBox(height: 8),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("发布日期", style: missionDetailText4),
                SizedBox(width: 5),
                Expanded(
                    child: Text(widget.date, style: bottomNaviBarTextStyle)),
                Text(widget.price + " USDT", style: missionDetailText5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
