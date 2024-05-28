import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Loading/customRefreshComponent.dart';
import 'package:part_time_app/Components/Loading/paymentHistoryLoading.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';
import 'package:part_time_app/Model/Task/missionClass.dart';
import 'package:part_time_app/Model/Ticketing/ticketingModel.dart';

import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Services/ticketing/ticketingServices.dart';
import 'ticketDetailsRecordPage.dart';

class TicketHistoryPage extends StatefulWidget {
  const TicketHistoryPage({super.key});

  @override
  State<TicketHistoryPage> createState() => _TicketHistoryPageState();
}

class _TicketHistoryPageState extends State<TicketHistoryPage> {
  ScrollController _scrollController = ScrollController();
  List<TicketingData> ticketingList = [];
  bool isLoading = false;
  bool continueLoading = true;
  int page = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadData();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      if (!isLoading && continueLoading) {
        _loadData();
      }
    }
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      await TicketingService.fetchComplaintTypes();
      TicketingModel? data = await TicketingService().getTicketingHistory(page);
      print("call the api");
      setState(() {
        if (data!.data != null) {
          ticketingList.addAll(data.data!);
          page++;
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

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    if (!isLoading && mounted) {
      setState(() {
        ticketingList.clear();
        page = 1;
        // continueLoading = true;
        _loadData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sort ticketingList by date
    ticketingList
        .sort((a, b) => (b.ticketDate ?? "").compareTo(a.ticketDate ?? ""));

// Group tickets by date
    Map<String, List<TicketingData>> groupedTickets = {};
    for (var ticket in ticketingList) {
      final date = ticket.ticketDate!.split(' ')[0];
      if (!groupedTickets.containsKey(date)) {
        groupedTickets[date] = [];
      }
      groupedTickets[date]!.add(ticket);
    }

// Flatten the grouped data
    List<dynamic> flattenedList = [];
    groupedTickets.forEach((date, tickets) {
      flattenedList.add(date);
      flattenedList.addAll(tickets);
    });
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0.0,
            leading: IconButton(
              iconSize: 15,
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Get.back();
              },
            ),
            centerTitle: true,
            title: Container(
                color: kTransparent,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: thirdTitleComponent(
                  text: "工单通知",
                ))),
        body: Container(
          constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
          decoration: const BoxDecoration(
            color: kThirdGreyColor,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                kBackgroundFirstGradientColor,
                kBackgroundSecondGradientColor
              ],
              stops: [0.0, 0.15],
            ),
          ),
          child: RefreshIndicator(
            onRefresh: _refresh,
            color: kMainYellowColor,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: flattenedList.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (isLoading && index == flattenedList.length) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PaymentHistoryLoading(), // Your loading indicator
                    ),
                  );
                }

                final item = flattenedList[index];

                if (item is String) {
                  // Render date header
                  return Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 15),
                      child: Text(
                        item,
                        style:
                            missionIDtextStyle, // Replace with missionIDtextStyle
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else if (item is TicketingData) {
                  // Render ticket card
                  final ticket = item;
                  return _buildCard(
                    title: TicketingData
                            .complaintTypeMap[ticket.complaintTypeId] ??
                        "Unknown",
                    description: ticket.ticketComplaintDescription ?? "",
                    complete: ticket.ticketStatus,
                    ticketId: ticket.ticketId,
                  );
                }

                return SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    int? complete,
    String? title,
    String? description,
    String? date,
    int? ticketId,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(
            () => TicketDetailsRecordPage(
                  ticketID: ticketId,
                ),
            transition: Transition.rightToLeft);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: kMainWhiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 60,
                  child: Text(
                    title!,
                    style: messageTitleTextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  flex: 50,
                  child: Text(
                    complete == 1 ? "已审核" : "待审核",
                    style: complete == 1
                        ? ticketCompleteTextStyle
                        : ticketUncompleteTextStyle,
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 3),
              child: Text(
                description!,
                style: messageDescTextStyle2,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
