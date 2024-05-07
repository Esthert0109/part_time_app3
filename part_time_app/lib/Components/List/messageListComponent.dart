import 'package:flutter/cupertino.dart';
import 'package:part_time_app/Components/Card/missionMessageCardComponent.dart';
import '../Card/primarySystemMessageCardComponent.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Pages/MockData/missionMockClass.dart';

class MessageList extends StatefulWidget {
  final List<MessageMockClass> messageList;
  final bool isSystem;
  const MessageList(
      {super.key, required this.messageList, required this.isSystem});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildSystemMessages(),
    );
  }

  List<Widget> _buildSystemMessages() {
    List<Widget> messageWidgets = [];

    for (int index = 0; index < widget.messageList.length; index++) {
      if (index == 0 ||
          widget.messageList[index].createdTime !=
              widget.messageList[index - 1].createdTime) {
        messageWidgets.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 5),
                  child: Text(
                    widget.messageList[index].createdTime,
                    style: missionIDtextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              widget.isSystem
                  ? primarySystemMessageCardComponent(
                      messageTitle: widget.messageList[index].title,
                      messageContent:
                          widget.messageList[index].description ?? "",
                    )
                  : MissionMessageCardComponent(
                      messageTitle: widget.messageList[index].title,
                      messageDesc: widget.messageList[index].description ?? "",
                      onTap: () {
                        print("Touch the talala");
                      })
            ],
          ),
        );
      } else {
        messageWidgets.add(widget.isSystem
            ? primarySystemMessageCardComponent(
                messageTitle: widget.messageList[index].title,
                messageContent: widget.messageList[index].description ?? "",
              )
            : MissionMessageCardComponent(
                messageTitle: widget.messageList[index].title,
                messageDesc: widget.messageList[index].description ?? "",
                onTap: () {
                  print("Touch the talala");
                }));
      }
    }

    return messageWidgets;
  }
}
