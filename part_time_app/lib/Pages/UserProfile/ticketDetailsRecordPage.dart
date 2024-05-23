import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:part_time_app/Components/Card/ticketRecordDetailsComponent.dart';

import 'package:part_time_app/Components/Title/thirdTitleComponent.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

import 'package:part_time_app/Services/ticketing/ticketingServices.dart';

import '../../Model/Ticketing/ticketingModel.dart';

class TicketDetailsRecordPage extends StatefulWidget {
  int? ticketID;

  TicketDetailsRecordPage({
    super.key,
    this.ticketID,
  });

  @override
  State<TicketDetailsRecordPage> createState() =>
      _TicketDetailsRecordPageState();
}

final ImagePicker _picker = ImagePicker();

class _TicketDetailsRecordPageState extends State<TicketDetailsRecordPage> {
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  TicketingData? ticketDetail;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      TicketingData? data =
          await TicketingService().getTicketDetail(widget.ticketID!);
      setState(() {
        if (data != null && data != null) {
          print(data);
          ticketDetail = data;
        } else {
          // Handle the case when data is null or data.data is null
        }
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
      // Handle error
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kTextTabBarHeight),
          child: AppBar(
            leading: IconButton(
              icon: SvgPicture.asset(
                "assets/common/arrow_back.svg",
                // height: 58,
                // width: 58,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    kBackgroundFirstGradientColor,
                    kBackgroundSecondGradientColor
                  ],
                  stops: [0.5, 1.0],
                ),
              ),
            ),
            backgroundColor: const Color(0xFFF9F9F9),
            title: const thirdTitleComponent(
              text: '工单',
            ),
            centerTitle: true,
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Column(children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TicketRecordDetailsComponent(
                  ticketCustomerUsername: ticketDetail?.ticketCustomerUsername,
                  ticketCustomerPhoneNum: ticketDetail?.ticketCustomerPhoneNum,
                  ticketCustomerEmail: ticketDetail?.ticketCustomerEmail,
                  ticketDate: ticketDetail?.ticketDate,
                  taskId: ticketDetail?.taskId,
                  complaintTypeId: ticketDetail?.complaintTypeId,
                  complaintUserId: ticketDetail?.complaintUserId,
                  ticketComplaintDescription:
                      ticketDetail?.ticketComplaintDescription,
                  ticketComplaintAttachment:
                      ticketDetail?.ticketComplaintAttachment,
                  ticketStatus: ticketDetail?.ticketStatus,
                ),
              ),
            ]))),
          ],
        ));
  }
}
