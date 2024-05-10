import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:shimmer/shimmer.dart';

class MissionReviewLoading extends StatefulWidget {
  const MissionReviewLoading({super.key});

  @override
  State<MissionReviewLoading> createState() => _MissionReviewLoadingState();
}

class _MissionReviewLoadingState extends State<MissionReviewLoading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: kMainWhiteColor),
      child: Shimmer.fromColors(
        baseColor: kMainLoadingColor,
        highlightColor: kSecondaryLoadingColor,
        enabled: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: kMainWhiteColor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 16,
                width: 100,
                color: kMainWhiteColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
