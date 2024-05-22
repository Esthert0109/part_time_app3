import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Loading/customRefreshComponent.dart';
import 'package:part_time_app/Components/Loading/paymentHistoryLoading.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';
import 'package:part_time_app/Model/Task/missionClass.dart';
import 'package:part_time_app/Model/Ticketing/ticketingModel.dart';
import 'package:part_time_app/Pages/MockData/missionMockData.dart';

import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Services/ticketing/ticketingServices.dart';

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
      await TicketingData.fetchComplaintTypes();
      TicketingModel? data = await TicketingService().getTicketingHistory(page);
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
          body:
              // _isLoading
              //     ? PaymentHistoryLoading()
              //     :
              Container(
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
              child: SingleChildScrollView(
                child: _buildListView(ticketingList),
              ),
            ),
          )),
    );
  }

  Widget _buildCard({
    int? complete,
    String? title,
    String? description,
    String? date,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigate to detail page
      },
      child: Container(
        height: 92,
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

  Widget _buildListView(List<TicketingData> list) {
    // Sort the list based on time
    list.sort((a, b) => b.ticketDate!.compareTo(a.ticketDate!));

    List<Widget> ticketWidgets = [];

    // Determine the number of messages to load
    int messagesToLoad = list.length < 20 ? list.length : 20;

    for (int index = 0; index < messagesToLoad; index++) {
      if (index == 0 || list[index].ticketDate != list[index - 1].ticketDate) {
        ticketWidgets.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 5),
                  child: Text(
                    list[index].ticketDate!,
                    style: missionIDtextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              _buildCard(
                complete: list[index].ticketStatus,
                title: list[index].complaintTypeName,
                description: list[index].ticketComplaintDescription,
                date: list[index].ticketDate,
              ),
            ],
          ),
        );
      } else {
        ticketWidgets.add(
          _buildCard(
            complete: list[index].ticketStatus,
            title: list[index].complaintTypeName,
            description: list[index].ticketComplaintDescription,
            date: list[index].ticketDate,
          ),
        );
      }
    }

    return ListView(
      padding: EdgeInsets.only(top: 10),
      shrinkWrap: true,
      physics: PageScrollPhysics(),
      children: ticketWidgets,
    );
  }
}
