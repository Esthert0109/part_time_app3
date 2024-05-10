import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:part_time_app/Components/Card/paymentHistoryDetailComponent.dart';
import 'package:part_time_app/Components/Loading/paymentDetailLoading.dart';

import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class PaymentHistoryDetailPage extends StatefulWidget {
  const PaymentHistoryDetailPage({super.key});

  @override
  State<PaymentHistoryDetailPage> createState() =>
      _PaymentHistoryDetailPageState();
}

class _PaymentHistoryDetailPageState extends State<PaymentHistoryDetailPage> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    // Simulate loading delay
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
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
        body: _isLoading
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
                child: const SingleChildScrollView(
                  child: Column(
                    children: [
                      PaymentHistoryDetailComponent(
                        condition: 1,
                        missionTitle: "点赞",
                        missionID: "21659121591261123",
                        name: "洪海仁",
                        date: "2024-4-10, 5:21pm",
                        walletNetwork: "TRX",
                        walletAddress: "TR7NHqjeKQxGTCi8q8ZY4pL8otSzgjLj6t",
                        receiptURL:
                            "https://tronscan.org/#/transaction/4ca87323388d0b202f20e0fee57d2491dd7f3a35ac3841771ca25bdcdcfd74bc",
                        amount: "10.00",
                        image:
                            "https://cdn.britannica.com/70/234870-050-D4D024BB/Orange-colored-cat-yawns-displaying-teeth.jpg",
                      )
                    ],
                  ),
                )),
      ),
    );
  }
}
