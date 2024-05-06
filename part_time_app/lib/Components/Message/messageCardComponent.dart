import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Pages/Message/userMessagePage.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import 'package:badges/badges.dart' as badges;

import '../../Pages/Message/chatConfig.dart';

class MessageCardComponent extends StatefulWidget {
  String? systemDetail;
  String? systemDate;
  int? systemTotalMessage;
  String? missionDetail;
  String? missionDate;
  int? missionTotalMessage;
  String? paymentDetail;
  String? paymentDate;
  int? paymentTotalMessage;
  String? postingDetail;
  String? postingDate;
  int? postingTotalMessage;
  String? toolDetail;
  String? toolDate;
  int? toolTotalMessage;
  String? userDetail;
  String? userDate;
  int? userTotalMessage;

  MessageCardComponent({
    super.key,
    this.systemDetail,
    this.systemDate,
    this.systemTotalMessage,
    this.missionDetail,
    this.missionDate,
    this.missionTotalMessage,
    this.paymentDetail,
    this.paymentDate,
    this.paymentTotalMessage,
    this.postingDetail,
    this.postingDate,
    this.postingTotalMessage,
    this.toolDetail,
    this.toolDate,
    this.toolTotalMessage,
    this.userDetail,
    this.userDate,
    this.userTotalMessage,
  });

  @override
  State<MessageCardComponent> createState() => _MessageCardComponentState();
}

class _MessageCardComponentState extends State<MessageCardComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMessageCard(
          "系统通知",
          widget.systemDetail,
          "assets/message/messageSystem.svg",
          widget.systemDate,
          widget.systemTotalMessage,
          () {
            print("touch the talala");
          },
        ),
        const SizedBox(height: 10),
        _buildMessageCard(
          "悬赏通知",
          widget.missionDetail,
          "assets/message/messageMission.svg",
          widget.missionDate,
          widget.missionTotalMessage,
          () {
            print("touch the talala");
          },
        ),
        const SizedBox(height: 10),
        _buildMessageCard(
          "款项通知",
          widget.paymentDetail,
          "assets/message/messagePayment.svg",
          widget.paymentDate,
          widget.paymentTotalMessage,
          () {
            print("touch the talala");
          },
        ),
        const SizedBox(height: 10),
        _buildMessageCard(
          "发布通知",
          widget.postingDetail,
          "assets/message/messagePosting.svg",
          widget.postingDate,
          widget.postingTotalMessage,
          () {
            print("touch the talala");
          },
        ),
        const SizedBox(height: 10),
        _buildMessageCard(
          "工单通知",
          widget.toolDetail,
          "assets/message/messageTool.svg",
          widget.toolDate,
          widget.toolTotalMessage,
          () {
            print("touch the talala");
          },
        ),
        const SizedBox(height: 10),
        _buildMessageCard(
          "用户消息",
          widget.userDetail,
          "assets/message/messageUser.svg",
          widget.userDate,
          widget.userTotalMessage,
          () {
            Get.to(() => UserMessagePage(), transition: Transition.rightToLeft);
          },
        ),
      ],
    );
  }
}

Widget _buildMessageCard(
  String title,
  String? detail,
  String icon,
  String? date,
  int? totalMessage,
  void Function()? onTap,
) {
  return Container(
    height: totalMessage != null && totalMessage >= 100 ? 75 : 67,
    decoration: BoxDecoration(
      color: kMainWhiteColor,
      borderRadius: BorderRadius.circular(8),
    ),
    padding: EdgeInsets.all(10),
    child: GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 44,
            child: SvgPicture.asset(
              icon,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: missionDetailText6,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Text(
                      date ?? '',
                      style: messageText1,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 236,
                      child: Text(
                        detail ?? '',
                        style: messageText1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (totalMessage != null && totalMessage >= 1)
                      Container(
                        padding: totalMessage != null && totalMessage >= 100
                            ? EdgeInsets.only(left: 30)
                            : EdgeInsets.only(left: 35),
                        child: badges.Badge(
                          badgeContent: Text(
                            totalMessage.toString(),
                            style: messageText2,
                          ),
                          position: badges.BadgePosition.bottomEnd(),
                          badgeStyle: badges.BadgeStyle(
                            shape: badges.BadgeShape.circle,
                            badgeColor: kMainRedColor,
                            padding: EdgeInsets.all(5),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
