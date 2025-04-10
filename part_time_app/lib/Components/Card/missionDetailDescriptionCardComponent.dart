import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/Collection/collectionModel.dart';
import '../../Services/collection/collectionServices.dart';

class MissionDetailDescriptionCardComponent extends StatefulWidget {
  final int taskId;
  final String title;
  final String detail;
  final List<String?> tag;
  final String totalSlot;
  final String leaveSlot;
  final String day;
  final String duration;
  final String date;
  final String price;
  final String limitUnit;
  final String estimatedUnit;
  bool? isFavourite;

  MissionDetailDescriptionCardComponent(
      {Key? key,
      required this.taskId,
      required this.title,
      required this.detail,
      required this.tag,
      required this.totalSlot,
      required this.leaveSlot,
      required this.day,
      required this.duration,
      required this.date,
      required this.price,
      this.isFavourite,
      required this.limitUnit,
      required this.estimatedUnit});

  @override
  State<MissionDetailDescriptionCardComponent> createState() =>
      _MissionDetailDescriptionCardComponentState();
}

class _MissionDetailDescriptionCardComponentState
    extends State<MissionDetailDescriptionCardComponent> {
  // services
  CollectionService collectService = CollectionService();
  Collection? collection;
  bool _favoriteClick = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _favoriteClick = widget.isFavourite ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: kMainWhiteColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 90,
                  child: Text(
                    widget.title,
                    style: missionDetailText1,
                  ),
                ),
                Flexible(
                    flex: 10,
                    child: GestureDetector(
                      onTap: () async {
                        collection = await collectService.updateCollection(
                            widget.taskId, _favoriteClick);

                        if (collection!.data!) {
                          setState(() {
                            _favoriteClick = !_favoriteClick;
                            print("favourite: ${_favoriteClick}");
                          });
                          Fluttertoast.showToast(
                              msg: _favoriteClick! ? '已收藏' : '取消收藏',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: kMainGreyColor,
                              textColor: kThirdGreyColor);
                        }
                      },
                      child: Align(
                          alignment: Alignment.topRight,
                          child: _favoriteClick
                              ? SvgPicture.asset(
                                  "assets/mission/favorite_selected.svg",
                                  width: 24,
                                  height: 24,
                                )
                              : SvgPicture.asset(
                                  "assets/mission/favorite_unselected.svg",
                                  width: 24,
                                  height: 24,
                                )),
                    ))
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
                Text(widget.day + widget.limitUnit,
                    style: bottomNaviBarTextStyle),
                SizedBox(width: 20),
                Text("预计耗时", style: missionDetailText4),
                SizedBox(width: 5),
                Text(widget.duration + widget.estimatedUnit,
                    style: bottomNaviBarTextStyle),
              ],
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.only(bottom: 5),
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
