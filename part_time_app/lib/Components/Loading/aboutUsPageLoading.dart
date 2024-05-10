import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:part_time_app/Components/Button/PrimaryButtonComponent.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:shimmer/shimmer.dart';
import '../../Constants/textStyleConstant.dart';

class AboutUsLoadingComponent extends StatefulWidget {
  const AboutUsLoadingComponent({super.key});

  @override
  State<AboutUsLoadingComponent> createState() =>
      _AboutUsLoadingComponentState();
}

class _AboutUsLoadingComponentState extends State<AboutUsLoadingComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Shimmer.fromColors(
          baseColor: kMainLoadingColor,
          highlightColor: kSecondaryLoadingColor,
          enabled: true,
          child: Column(
            children: [
              Container(
                height: 70,
                width: 70,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kMainWhiteColor,
                ),
              ),
              const SizedBox(height: 3),
              Container(
                height: 14,
                width: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kMainWhiteColor,
                ),
              ),
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 16,
                  width: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kMainWhiteColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kMainWhiteColor,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Container(
                          height: 28,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kMainWhiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kMainWhiteColor,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Container(
                          height: 14,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kMainWhiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kMainWhiteColor,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Container(
                          height: 28,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kMainWhiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kMainWhiteColor,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Container(
                          height: 14,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kMainWhiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kMainWhiteColor,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Container(
                          height: 14,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kMainWhiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kMainWhiteColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 30,
                      // width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kMainWhiteColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          height: 17,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kMainWhiteColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 17,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kMainWhiteColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
