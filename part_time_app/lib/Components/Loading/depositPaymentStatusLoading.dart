import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../Constants/colorConstant.dart';

class DepositPaymentStatusLoading extends StatefulWidget {
  const DepositPaymentStatusLoading({super.key});

  @override
  State<DepositPaymentStatusLoading> createState() =>
      _DepositPaymentStatusLoadingState();
}

class _DepositPaymentStatusLoadingState
    extends State<DepositPaymentStatusLoading> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 223,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: Shimmer.fromColors(
              baseColor: kMainLoadingColor,
              highlightColor: kSecondaryLoadingColor,
              enabled: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: kMainWhiteColor,
                        radius: 12,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        height: 16,
                        width: 56,
                        color: kMainWhiteColor,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: kMainWhiteColor,
                        radius: 12,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 12),
                            height: 16,
                            width: 84,
                            color: kMainWhiteColor,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 12),
                            height: 16,
                            width: 187,
                            color: kMainWhiteColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: kMainWhiteColor,
                        radius: 12,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 12),
                            height: 16,
                            width: 56,
                            color: kMainWhiteColor,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 12),
                            height: 16,
                            width: 36,
                            color: kMainWhiteColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
