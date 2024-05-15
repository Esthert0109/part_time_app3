import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Loading/paymentHistoryLoading.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';
import 'package:part_time_app/Model/Task/missionMockClass.dart';
import 'package:part_time_app/Pages/MockData/missionMockData.dart';

import '../../Components/Loading/customRefreshComponent.dart';
import '../../Components/Loading/missionCardLoading.dart';
import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import 'depositHistoryDetailPage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

bool dataFetchedPaymentHistory = false;

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({super.key});

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(seconds: 1));
    // if failed,use refreshFailed()
    if (mounted) {
      _refreshController.refreshCompleted();
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
                text: "交易记录",
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
        child: CustomRefreshComponent(
            onRefresh: _onRefresh,
            controller: _refreshController,
            child:
                // _isLoading
                //     ? PaymentHistoryLoading()
                //     :
                _buildListView(PaymentHistoryList)),
      ),
    ));
  }

  Widget _buildCard({
    required bool complete,
    required String title,
    required String description,
    required int amount,
    required String date,
  }) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
              onTap: () {
                Get.to(() => PaymentHistoryDetailPage(),
                    transition: Transition.rightToLeft);
              },
              child: Container(
                height: 92,
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: kMainWhiteColor,
                    borderRadius: BorderRadius.circular(8)),
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
                            title,
                            style: messageTitleTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Expanded(
                          flex: 50,
                          child: Text(
                            complete
                                ? (amount < 0 || amount == -0 ? "- " : "+ ") +
                                    amount.abs().toStringAsFixed(2) +
                                    " USDT"
                                : (amount < 0 || amount == -0 ? "- " : "") +
                                    amount.abs().toStringAsFixed(2) +
                                    " USDT",
                            style: complete
                                ? paymentHistoryTextStyle2
                                : paymentHistoryTextStyle1,
                            textAlign: TextAlign.right,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: Text(
                        description,
                        style: messageDescTextStyle2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildListView(List<PaymentMockClass> list) {
    // Sort the list based on time
    list.sort((a, b) => b.date.compareTo(a.date));

    List<Widget> paymentWidgets = [];

    // Determine the number of messages to load
    int messagesToLoad = list.length < 20 ? list.length : 20;

    for (int index = 0; index < messagesToLoad; index++) {
      if (index == 0 || list[index].date != list[index - 1].date) {
        paymentWidgets.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 5),
                  child: Text(
                    list[index].date,
                    style: missionIDtextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              _buildCard(
                complete: list[index].complete,
                title: list[index].title,
                description: list[index].description,
                amount: list[index].amount,
                date: list[index].date,
              ),
            ],
          ),
        );
      } else {
        paymentWidgets.add(
          _buildCard(
            complete: list[index].complete,
            title: list[index].title,
            description: list[index].description,
            amount: list[index].amount,
            date: list[index].date,
          ),
        );
      }
    }

    return ListView(
      padding: EdgeInsets.only(top: 10),
      shrinkWrap: true,
      physics: PageScrollPhysics(),
      children: paymentWidgets,
    );
  }
}
