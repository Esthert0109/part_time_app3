import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:shimmer/shimmer.dart';
import '../../Constants/textStyleConstant.dart';

class PaymentDetailLoading extends StatefulWidget {
  const PaymentDetailLoading({super.key});

  @override
  State<PaymentDetailLoading> createState() => _PaymentDetailLoadingState();
}

class _PaymentDetailLoadingState extends State<PaymentDetailLoading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 640,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: kMainWhiteColor, borderRadius: BorderRadius.circular(8)),
      child: Shimmer.fromColors(
        baseColor: kMainLoadingColor,
        highlightColor: kSecondaryLoadingColor,
        enabled: true,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
