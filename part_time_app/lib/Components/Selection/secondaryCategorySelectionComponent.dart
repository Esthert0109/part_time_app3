// import 'package:flutter/material.dart';
// import 'package:part_time_app/Constants/colorConstant.dart';

// import '../../Constants/textStyleConstant.dart';

// class SecondaryCategorySelectionComponent extends StatefulWidget {
//   final List<String> categoryList;
//   final List<String> selectedCategory;
//   final bool isSelected;
//   final Function(String) onTap;
//   const SecondaryCategorySelectionComponent(
//       {super.key,
//       required this.categoryList,
//       required this.onTap,
//       required this.selectedCategory,
//       required this.isSelected});

//   @override
//   State<SecondaryCategorySelectionComponent> createState() =>
//       _SecondaryCategorySelectionComponentState();
// }

// class _SecondaryCategorySelectionComponentState
//     extends State<SecondaryCategorySelectionComponent> {
//   List<String> selectedList = [];
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       direction: Axis.horizontal,
//       spacing: 10,
//       runSpacing: 12,
//       children: List.generate(
//         widget.categoryList.length,
//         (index) {
//           isSelected = selectedList.contains(widget.categoryList[index]);
//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 print("check: ${widget.categoryList[index]}");
//                 print("check list: ${selectedList}");
//                 print("check boolean: ${isSelected}");

//                 if (isSelected) {
//                   setState(() {
//                     selectedList.remove(widget.categoryList[index]);
//                   });
//                 } else {
//                   setState(() {
//                     selectedList.add(widget.categoryList[index]);
//                   });
//                 }

//                 widget.onTap(widget.categoryList[index]);
//               });
//             },
//             child: Container(
//               height: 29,
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(39),
//                   border: Border.all(color: kMainBlackColor, width: 1.3),
//                   color: kTransparent),
//               child: Text(
//                 widget.categoryList[index],
//                 style: unselectedCategoryTextStyle,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
