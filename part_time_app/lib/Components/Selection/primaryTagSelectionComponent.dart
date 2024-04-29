import 'package:flutter/material.dart';

import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class PrimaryTagSelectionComponent extends StatefulWidget {
  final List<String> tagList;
  final int selectedIndex;
  final Function(int) onTap;

  const PrimaryTagSelectionComponent(
      {super.key,
      required this.tagList,
      required this.selectedIndex,
      required this.onTap});

  @override
  State<PrimaryTagSelectionComponent> createState() =>
      _PrimaryTagSelectionComponentState();
}

class _PrimaryTagSelectionComponentState
    extends State<PrimaryTagSelectionComponent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
            widget.tagList.length,
            (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.onTap(index);
                    });
                  },
                  child: Container(
                    height: 24,
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(
                            width: 1.6,
                            color: widget.selectedIndex == index
                                ? kMainBlackColor
                                : kUnselectedTagColor)),
                    child: Text(
                      widget.tagList[index],
                      style: widget.selectedIndex == index
                          ? selectedTagTextStyle
                          : unselectedTagTextStyle,
                    ),
                  ),
                )),
      ),
    );
  }
}
