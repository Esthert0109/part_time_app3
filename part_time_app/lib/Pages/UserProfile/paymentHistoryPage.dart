import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Loading/paymentHistoryLoading.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';
import 'package:part_time_app/Model/Payment/paymentModel.dart';
import 'package:part_time_app/Model/Task/missionClass.dart';
import 'package:part_time_app/Pages/MockData/missionMockData.dart';
import 'package:part_time_app/Services/payment/paymentServices.dart';

import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import 'paymentHistoryDetailPage.dart';

bool dataFetchedPaymentHistory = false;

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({super.key});

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  ScrollController _scrollController = ScrollController();
  List<Payment> paymentList = [];
  bool isLoading = false;
  int page = 1;
  bool continueLoading = true;
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
      List<Payment>? data = await PaymentServices().getPaymentHistory(page);
      // print("call the API");
      // print(data);
      setState(() {
        if (data != null && data != null) {
          paymentList.addAll(data);
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
        paymentList.clear();
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
              child: RefreshIndicator(
                onRefresh: _refresh,
                color:
                    kMainYellowColor, // Replace kMainYellowColor with actual color
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: paymentList.length + (isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == paymentList.length) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PaymentHistoryLoading(),
                        ),
                      );
                    }
                    final payment = paymentList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 15),
                            child: Text(
                              payment.date,
                              style:
                                  missionIDtextStyle, // Replace missionIDtextStyle with actual style
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, subIndex) =>
                              SizedBox(height: 10),
                          itemCount: payment.payments.length,
                          itemBuilder: (context, subIndex) {
                            final paymentDetail = payment.payments[subIndex];
                            return _buildCard(
                              title: paymentDetail.paymentHistoryTitle,
                              description:
                                  paymentDetail.paymentHistoryDescription,
                              amount: paymentDetail.paymentTotalAmount,
                              paymentId: paymentDetail.paymentId,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            )));
  }

  Widget _buildCard({
    required String title,
    required String description,
    required String amount,
    String? date,
    int? paymentId,
  }) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
              onTap: () {
                Get.to(
                    () => PaymentHistoryDetailPage(
                          paymentID: paymentId,
                        ),
                    transition: Transition.rightToLeft);
              },
              child: Container(
                height: 92,
                // margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: kMainWhiteColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
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
                            amount,
                            style: paymentHistoryTextStyle1,
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
}
