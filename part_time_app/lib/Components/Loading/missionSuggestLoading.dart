import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../Constants/colorConstant.dart';

class MissionSuggestLoading extends StatefulWidget {
  const MissionSuggestLoading({super.key});

  @override
  State<MissionSuggestLoading> createState() => _MissionSuggestLoadingState();
}

class _MissionSuggestLoadingState extends State<MissionSuggestLoading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 77,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Shimmer.fromColors(
        baseColor: kMainLoadingColor,
        highlightColor: kSecondaryLoadingColor,
        enabled: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Flexible(
                flex: 2,
                child: CircleAvatar(
                  backgroundColor: kMainWhiteColor,
                  radius: 25,
                )),
            Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: 108,
                      color: kMainWhiteColor,
                    ),
                    Container(
                      height: 16,
                      width: 30,
                      color: kMainWhiteColor,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 4,
                          width: 165,
                          color: kMainWhiteColor,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 2),
                          height: 16,
                          width: 114,
                          color: kMainWhiteColor,
                        ),
                      ],
                    ),
                  ],
                )),
            Expanded(
                flex: 3,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 16,
                        width: 87,
                        color: kMainWhiteColor,
                      ),
                      Container(
                        height: 30,
                        width: 88,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: kMainWhiteColor,
                        ),
                      ),
                    ]))
          ],
        ),
      ),
    );
  }
}
