import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../Constants/colorConstant.dart';

class PaymentHistoryLoading extends StatefulWidget {
  const PaymentHistoryLoading({super.key});

  @override
  State<PaymentHistoryLoading> createState() => _PaymentHistoryLoadingState();
}

class _PaymentHistoryLoadingState extends State<PaymentHistoryLoading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: kMainWhiteColor, borderRadius: BorderRadius.circular(8)),
      child: Shimmer.fromColors(
        baseColor: kMainLoadingColor,
        highlightColor: kSecondaryLoadingColor,
        enabled: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 65,
                    child: Container(
                      height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                      ),
                    )),
                SizedBox(width: 50),
                Expanded(
                  flex: 35,
                  child: Container(
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
