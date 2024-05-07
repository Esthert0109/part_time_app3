import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
          Container(
            height: 74,
            padding: const EdgeInsets.all(12),
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
                    backgroundColor: kMainWhiteColor,
                    radius: 25,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    height: 18,
                    width: 100,
                    color: kMainWhiteColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 255,
            padding: const EdgeInsets.all(12),
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
                    height: 2,
                  ),
                  Container(
                    height: 105,
                    width: double.infinity,
                    color: kMainWhiteColor,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    height: 20,
                    width: 98,
                    color: kMainWhiteColor,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 58,
                        width: 180,
                        color: kMainWhiteColor,
                      ),
                      Container(
                        height: 29,
                        width: 126,
                        color: kMainWhiteColor,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 475,
            padding: const EdgeInsets.all(12),
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
                  Container(
                    height: 23,
                    width: 84,
                    color: kMainWhiteColor,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 46,
                    width: double.infinity,
                    color: kMainWhiteColor,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 46,
                    width: double.infinity,
                    color: kMainWhiteColor,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                      3,
                      (index) => Container(
                        height: 100,
                        width: 157,
                        margin: EdgeInsets.only(right: 6),
                        decoration: BoxDecoration(
                            color: kMainWhiteColor,
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    )),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    height: 17,
                    width: 79,
                    color: kMainWhiteColor,
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Container(
                    height: 46,
                    width: double.infinity,
                    color: kMainWhiteColor,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    width: 157,
                    margin: EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                        color: kMainWhiteColor,
                        borderRadius: BorderRadius.circular(4)),
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
