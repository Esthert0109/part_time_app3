import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../Constants/colorConstant.dart';

class UserProfilePageLoading extends StatefulWidget {
  const UserProfilePageLoading({super.key});

  @override
  State<UserProfilePageLoading> createState() => _UserProfilePageLoadingState();
}

class _UserProfilePageLoadingState extends State<UserProfilePageLoading> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 186,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 146,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kMainWhiteColor),
                ),
              ),
              Positioned(
                top: 0,
                left: (MediaQuery.of(context).size.width) / 2 - 55,
                child: Shimmer.fromColors(
                  baseColor: kMainLoadingColor,
                  highlightColor: kSecondaryLoadingColor,
                  enabled: true,
                  child: CircleAvatar(
                    radius: 43,
                    backgroundColor: kSecondGreyColor,
                  ),
                ),
              ),
              Positioned(
                top: 82,
                left: 0,
                right: 0,
                child: Shimmer.fromColors(
                  baseColor: kMainLoadingColor,
                  highlightColor: kSecondaryLoadingColor,
                  enabled: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 0, top: 12, bottom: 10),
                          child: Container(
                            height: 21,
                            width: 100,
                            color: kMainWhiteColor,
                          )),
                      Padding(
                          padding: const EdgeInsets.only(left: 0, bottom: 10),
                          child: Container(
                            height: 14,
                            width: 124,
                            color: kMainWhiteColor,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Container(
                          height: 14,
                          width: 66,
                          color: kMainWhiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Shimmer.fromColors(
          baseColor: kMainLoadingColor,
          highlightColor: kSecondaryLoadingColor,
          enabled: true,
          child: Container(
            height: 42,
            width: double.infinity,
            color: kMainWhiteColor,
            margin: EdgeInsets.symmetric(vertical: 12),
          ),
        )
      ],
    );
  }
}
