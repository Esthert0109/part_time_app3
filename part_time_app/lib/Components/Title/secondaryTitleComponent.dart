import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';

import '../../Constants/textStyleConstant.dart';

class SecondaryTitleComponent extends StatefulWidget {
  final List<String> titleList;
  final int selectedIndex;
  final Function(int) onTap;
  const SecondaryTitleComponent(
      {super.key,
      required this.titleList,
      required this.selectedIndex,
      required this.onTap});

  @override
  State<SecondaryTitleComponent> createState() =>
      _SecondaryTitleComponentState();
}

class _SecondaryTitleComponentState extends State<SecondaryTitleComponent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(widget.titleList.length, (index) {
          final words = widget.titleList[index];
          double widthSize = 24.0 * words.length;
          return GestureDetector(
            onTap: () {
              setState(() {
                widget.onTap(index);
              });
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 5, 15, 5),
              child: SizedBox(
                width: widthSize,
                height: 30,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: 70,
                        height: 10,
                        color: widget.selectedIndex == index
                            ? kMainYellowColor
                            : kTransparent,
                        curve: Curves.easeIn,
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          widget.titleList[index],
                          style: widget.selectedIndex == index
                              ? selectedSecondaryTitleTextStyle
                              : unselectedSecondaryTitleTextStyle,
                        ))
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
