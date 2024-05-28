import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../Constants/colorConstant.dart';

class ExplorePageLoading extends StatefulWidget {
  const ExplorePageLoading({super.key});

  @override
  State<ExplorePageLoading> createState() => _ExplorePageLoadingState();
}

class _ExplorePageLoadingState extends State<ExplorePageLoading> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kMainLoadingColor,
      highlightColor: kSecondaryLoadingColor,
      enabled: true,
      child: Container(
        height: 132,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kMainWhiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
