import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:shimmer/shimmer.dart';

class MissionDetailLoading extends StatefulWidget {
  const MissionDetailLoading({super.key});

  @override
  State<MissionDetailLoading> createState() => _MissionDetailLoadingState();
}

class _MissionDetailLoadingState extends State<MissionDetailLoading> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: kMainLoadingColor,
            highlightColor: kSecondaryLoadingColor,
            enabled: true,
            child: Container(
              height: 74,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: kMainWhiteColor),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 255,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: kMainWhiteColor),
            child: Shimmer.fromColors(
              baseColor: kMainLoadingColor,
              highlightColor: kSecondaryLoadingColor,
              enabled: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 26, width: 300, color: kMainWhiteColor),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 105,
                    width: 327,
                    color: kMainWhiteColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [],
          )
        ],
      ),
    );
  }
}
