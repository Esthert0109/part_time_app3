import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:part_time_app/Constants/colorConstant.dart';

import '../../Constants/textStyleConstant.dart';

class SecondaryCategorySelectionComponent extends StatefulWidget {
  final Map<String, dynamic>? sorts;
  final Function(List<int> selectedIndex) onSelectionChanged;
  const SecondaryCategorySelectionComponent({
    super.key,
    this.sorts,
    required this.onSelectionChanged,
  });

  @override
  State<SecondaryCategorySelectionComponent> createState() =>
      _SecondaryCategorySelectionComponentState();
}

class _SecondaryCategorySelectionComponentState
    extends State<SecondaryCategorySelectionComponent> {
  List<int> selectedIndex = [];
  List<String> selectedIndexName = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.sorts!.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(entry.key, // Display category name
                    style: categoryTitleKetTextStyle),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: (entry.value as List<Set<Object>>).map((optionSet) {
                    final option = optionSet.first as int;
                    final name = optionSet.last as String;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectedIndex.contains(option) &&
                              selectedIndexName.contains(name)) {
                            selectedIndex.remove(option);
                            selectedIndexName.remove(name);
                          } else {
                            selectedIndex.add(option);
                            selectedIndexName.add(name);
                          }
                          widget.onSelectionChanged(selectedIndex);
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(39),
                            color: selectedIndex.contains(option)
                                ? kSelectedCategoryColor
                                : Colors.transparent,
                            border: Border.all(
                              width: selectedIndex.contains(option) ? 2 : 1.3,
                              style: BorderStyle.solid,
                              color: selectedIndex.contains(option)
                                  ? kSelectedCategoryBorderColor
                                  : kMainBlackColor,
                            ),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                          child: selectedIndex.contains(option)
                              ? IntrinsicWidth(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name,
                                        style: selectedCategoryTextStyle,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(12, 6, 0, 5),
                                        child: SvgPicture.asset(
                                            "assets/common/close.svg"),
                                      )
                                    ],
                                  ),
                                )
                              : Text(
                                  name,
                                  style: unselectedCategoryTextStyle,
                                )),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
