import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Pages/Message/missionMessagePage.dart';
import 'package:part_time_app/Pages/Message/paymentMessagePage.dart';
import 'package:part_time_app/Pages/Message/systemMessagePage.dart';
import 'package:part_time_app/Pages/Message/ticketingMessagePage.dart';
import 'package:part_time_app/Pages/Message/user/userMessagePage.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import 'package:badges/badges.dart' as badges;

import '../../Pages/Message/publishMessagePage.dart';
import '../../Pages/Message/systemMessage1Page.dart';

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
  void _resetCountAndNavigate(String type, VoidCallback onTap) {
    setState(() {
      if (type == '系统通知') {
        widget.systemTotalMessage = 0;
      } else if (type == '悬赏通知') {
        widget.missionTotalMessage = 0;
      } else if (type == '款项通知') {
        widget.paymentTotalMessage = 0;
      } else if (type == '发布通知') {
        widget.postingTotalMessage = 0;
      } else if (type == '工单通知') {
        widget.toolTotalMessage = 0;
      } else if (type == '用户消息') {
        widget.userTotalMessage = 0;
      }
    });
    onTap();
  }

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
            _resetCountAndNavigate('系统通知', () {
              Get.to(() => const SystemMessagePage(),
                  transition: Transition.rightToLeft);
            });
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
            _resetCountAndNavigate('悬赏通知', () {
              Get.to(() => const MissionMessagePage(),
                  transition: Transition.rightToLeft);
            });
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
            _resetCountAndNavigate('款项通知', () {
              Get.to(() => const PaymentMessagePage(),
                  transition: Transition.rightToLeft);
            });
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
            _resetCountAndNavigate('发布通知', () {
              Get.to(() => const PublishMessagePage(),
                  transition: Transition.rightToLeft);
            });
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
            _resetCountAndNavigate('工单通知', () {
              Get.to(() => const TicketingMessagePage(),
                  transition: Transition.rightToLeft);
            });
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
            _resetCountAndNavigate('用户消息', () {
              Get.to(() => const UserMessagePage(),
                  transition: Transition.rightToLeft);
            });
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
                      child: Expanded(
                        child: Text(
                          detail ?? '',
                          style: messageText1,
                          overflow: TextOverflow.ellipsis,
                        ),
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
