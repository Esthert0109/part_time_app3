import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:part_time_app/Constants/colorConstant.dart';

import '../../Constants/textStyleConstant.dart';

class SecondaryCategorySelectionComponent extends StatefulWidget {
  final Map<String, List<Map<String, dynamic>>>? sorts;
  final ValueChanged<List<int>> onSelectedIndicesChanged;
  final ValueChanged<List<String>> onSelectedNameChanged;

  const SecondaryCategorySelectionComponent({
    super.key,
    this.sorts,
    required this.onSelectedIndicesChanged,
    required this.onSelectedNameChanged,
  });

  @override
  State<SecondaryCategorySelectionComponent> createState() =>
      _SecondaryCategorySelectionComponentState();
}

class _SecondaryCategorySelectionComponentState
    extends State<SecondaryCategorySelectionComponent> {
  List<int> selectedIndex = [];
  List<String> selectedIndexName = [];

  void _onSortItemPressed(int id, String name) {
    setState(() {
      if (selectedIndex.contains(id)) {
        selectedIndex.remove(id);
        selectedIndexName.remove(name);
      } else {
        selectedIndex.add(id);
        selectedIndexName.add(name);
      }
    });
    widget.onSelectedIndicesChanged(selectedIndex);
    widget.onSelectedNameChanged(selectedIndexName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.sorts!.entries.map((entry) {
        String category = entry.key;
        List<Map<String, dynamic>> items = entry.value;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(category, style: categoryTitleKetTextStyle),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: items.map((item) {
                    int id = item["id"];
                    String name = item["name"];

                    return GestureDetector(
                      onTap: () => _onSortItemPressed(id, name),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(39),
                          color: selectedIndex.contains(id)
                              ? kSelectedCategoryColor
                              : Colors.transparent,
                          border: Border.all(
                            width: selectedIndex.contains(id) ? 2 : 1.3,
                            style: BorderStyle.solid,
                            color: selectedIndex.contains(id)
                                ? kSelectedCategoryBorderColor
                                : kMainBlackColor,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 6),
                        child: selectedIndex.contains(id)
                            ? IntrinsicWidth(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: selectedCategoryTextStyle,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(12, 6, 0, 5),
                                      child: SvgPicture.asset(
                                          "assets/common/close.svg"),
                                    )
                                  ],
                                ),
                              )
                            : Text(
                                name,
                                style: unselectedCategoryTextStyle,
                              ),
                      ),
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
