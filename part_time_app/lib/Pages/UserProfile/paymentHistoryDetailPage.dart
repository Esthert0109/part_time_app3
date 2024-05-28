import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:part_time_app/Components/Card/paymentHistoryDetailComponent.dart';
import 'package:part_time_app/Components/Dialog/paymentUploadDialogComponent.dart';
import 'package:part_time_app/Components/Loading/paymentDetailLoading.dart';

import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/Payment/paymentModel.dart';
import '../../Services/payment/paymentServices.dart';

class PaymentHistoryDetailPage extends StatefulWidget {
  int? paymentID;
  PaymentHistoryDetailPage({
    super.key,
    this.paymentID,
  });

  @override
  State<PaymentHistoryDetailPage> createState() =>
      _PaymentHistoryDetailPageState();
}

class _PaymentHistoryDetailPageState extends State<PaymentHistoryDetailPage> {
  bool isLoading = false;
  PaymentDetail? paymentDetail;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      PaymentDetail? data =
          await PaymentServices().getPaymentDetail(widget.paymentID!);
      // print("call the API");
      // print(data);
      setState(() {
        if (data != null && data != null) {
          print(data);
          paymentDetail = data;
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
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: SvgPicture.asset(
                      "assets/common/back_button.svg",
                      width: 24,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const Expanded(
                  flex: 12,
                  child: Align(
                    child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: thirdTitleComponent(text: "交易详情"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: isLoading
            ? PaymentDetailLoading()
            : Container(
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      PaymentHistoryDetailComponent(
                        condition: paymentDetail?.paymentTypeStatus(),
                        missionTitle: paymentDetail?.taskTitle,
                        missionID: paymentDetail?.taskId.toString(),
                        receiverName: paymentDetail?.paymentUsername,
                        date: paymentDetail?.paymentCreatedTime,
                        walletNetwork: paymentDetail?.paymentBillingNetwork,
                        walletAddress: paymentDetail?.paymentBillingAddress,
                        image: paymentDetail?.paymentBillingImage,
                        receiptURL: paymentDetail?.paymentBillingUrl,
                        amount: paymentDetail?.paymentAmount,
                        fee: paymentDetail?.paymentFee,
                        totalAmount: paymentDetail?.paymentTotalAmount,
                      )
                    ],
                  ),
                )),
      ),
    );
  }
}
