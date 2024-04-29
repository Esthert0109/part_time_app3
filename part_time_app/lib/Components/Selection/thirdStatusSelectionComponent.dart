import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';

import '../../Constants/textStyleConstant.dart';

class ThirdStatusSelectionComponent extends StatefulWidget {
  final List<String> statusList;
  final int selectedIndex;
  final Function(int) onTap;
  const ThirdStatusSelectionComponent(
      {super.key,
      required this.statusList,
      required this.selectedIndex,
      required this.onTap});

  @override
  State<ThirdStatusSelectionComponent> createState() =>
      _ThirdStatusSelectionComponentState();
}

class _ThirdStatusSelectionComponentState
    extends State<ThirdStatusSelectionComponent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
            widget.statusList.length,
            (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.onTap(index);
                    });
                  },
                  child: Container(
                    height: 24,
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.only(right: 10),
                    child: Text(
                      widget.statusList[index],
                      style: widget.selectedIndex == index
                          ? selectedThirdStatusTextStyle
                          : unselectedThirdStatusTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )),
      ),
    );
  }
}
