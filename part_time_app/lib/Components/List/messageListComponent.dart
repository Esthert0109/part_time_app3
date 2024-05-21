import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Card/missionMessageCardComponent.dart';
import '../../Pages/UserProfile/depositHistoryDetailPage.dart';
import '../Card/primarySystemMessageCardComponent.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/Task/missionClass.dart';

import 'package:flutter/material.dart';

class MessageList extends StatefulWidget {
  final String title;
  final String description;
  final bool isSystem;
  final bool? isPayment;
  int? paymentID;

  MessageList({
    Key? key,
    required this.title,
    required this.description,
    required this.isSystem,
    this.isPayment,
    this.paymentID,
  }) : super(key: key);

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isSystem ? _buildSystemMessage() : _buildUserMessage(),
      ],
    );
  }

  Widget _buildSystemMessage() {
    return primarySystemMessageCardComponent(
      messageTitle: widget.title,
      messageContent: widget.description,
    );
  }

  Widget _buildUserMessage() {
    return MissionMessageCardComponent(
        messageTitle: widget.title,
        messageDesc: widget.description,
        onTap: () {
          widget.isPayment!
              ? Get.to(
                  () => PaymentHistoryDetailPage(
                        paymentID: widget.paymentID,
                      ),
                  transition: Transition.rightToLeft)
              : print("touch the talala");
        });
  }
}
