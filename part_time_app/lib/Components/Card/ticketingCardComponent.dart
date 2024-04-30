import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:part_time_app/Constants/colorConstant.dart';

import '../../Constants/textStyleConstant.dart';

class TicketingCardComponent extends StatefulWidget {
  final String ticketTitle;
  final String ticketDesc;
  final int ticketStatus;

  const TicketingCardComponent(
      {super.key,
      required this.ticketTitle,
      required this.ticketDesc,
      required this.ticketStatus});

  @override
  State<TicketingCardComponent> createState() => _TicketingCardComponentState();
}

class _TicketingCardComponentState extends State<TicketingCardComponent> {
  TextStyle? statusTextStyle;
  String status = "";

  @override
  Widget build(BuildContext context) {
    if (widget.ticketStatus == 0) {
      statusTextStyle = missionStatusOrangeTextStyle;
      status = "待审核";
    } else if (widget.ticketStatus == 1) {
      statusTextStyle = missionStatusGreyTextStyle;
      status = "已完成";
    }

    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: kMainWhiteColor, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 85,
                child: Text(
                  widget.ticketTitle,
                  style: messageTitleTextStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Expanded(
                flex: 15,
                child: Text(
                  status,
                  style: statusTextStyle,
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 3),
            child: Text(
              widget.ticketDesc,
              style: messageDescTextStyle2,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
