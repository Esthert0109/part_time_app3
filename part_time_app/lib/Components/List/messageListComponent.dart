import 'package:flutter/cupertino.dart';
import 'package:part_time_app/Components/Card/missionMessageCardComponent.dart';
import '../Card/primarySystemMessageCardComponent.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/Task/missionMockClass.dart';

import 'package:flutter/material.dart';

class MessageList extends StatefulWidget {
  final String title;
  final String description;
  final String createdTime;
  final bool isSystem;

  const MessageList({
    Key? key,
    required this.title,
    required this.description,
    required this.createdTime,
    required this.isSystem,
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
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 5),
            child: Text(
              widget.createdTime,
              style: missionIDtextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
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
          print("Touch the talala");
        });
  }
}
