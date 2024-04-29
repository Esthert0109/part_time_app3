import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';

class missionDetailStepsCardComponent extends StatelessWidget {
  final String stepTitle;
  final String stepDesc;
  final String? stepPic;
  final String stepPicAmount;
  final bool isConfidential;

  const missionDetailStepsCardComponent({
    Key? key,
    required this.stepTitle,
    required this.stepDesc,
    this.stepPic,
    required this.stepPicAmount,
    required this.isConfidential,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      margin: const EdgeInsets.only(left: 12, right: 12),
      color: kMainWhiteColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        title: Text(
          stepTitle,
          style: const TextStyle(
              color: kMainBlackColor,
              fontSize: 14,
              fontWeight: FontWeight.w700),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stepDesc,
                  style: const TextStyle(
                      color: kMainBlackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (isConfidential)
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: 
                              SvgPicture.asset(
                                stepPic!,
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  color: kMainBlackColor.withOpacity(0.5),
                                  height: 28,
                                  child: const Center(
                                    child: Text(
                                      '无法预览图片',
                                      style: TextStyle(
                                        color: kMainWhiteColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (!isConfidential && stepPic != null)
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: SvgPicture.asset(
                                stepPic!,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  'assets/steps/enlarge_icon.svg',
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                Text(
                  stepPicAmount,
                  style: const TextStyle(
                      color: kSecondGreyColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
