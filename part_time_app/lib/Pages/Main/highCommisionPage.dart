// import 'package:flutter/material.dart';

// import '../../Components/Card/missionCardComponent.dart';
// import '../../Constants/textStyleConstant.dart';
// import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

// import '../MockData/missionMockClass.dart';
// import '../MockData/missionMockData.dart';

// class HighCommisionPage extends StatefulWidget {
//   const HighCommisionPage({super.key});

//   @override
//   State<HighCommisionPage> createState() => _HighCommisionPageState();
// }

// class _HighCommisionPageState extends State<HighCommisionPage> {
//   List<MissionMockClass>? missionAvailable = [];
//   final int increment = 10;
//   bool isLoadingVertical = false;


//   @override
//   void initState() {
//     _loadMoreVertical();
//     super.initState();
//   }

//   Future _loadMoreVertical() async {
//     setState(() {
//       isLoadingVertical = true;
//     });

//     // Add in an artificial delay
//     await new Future.delayed(const Duration(seconds: 2));

//     missionAvailable!.addAll(
//         List.generate(increment, (index) => missionAvailable.length + index));

//     setState(() {
//       isLoadingVertical = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("TEST TEST"),
//       ),
//       body: LazyLoadScrollView(
//         onEndOfPage: () => _loadMoreVertical(),
//         child: ListView.builder(
//           itemCount: missionAvailable!.length,
//           itemBuilder: (context, position) {
//             return MissionCardComponent(
//             missionTitle: missionAvailable[index].missionTitle,
//             missionDesc: missionList[index].missionDesc,
//             tagList: missionList[index].tagList ?? [],
//             missionPrice: missionList[index].missionPrice,
//             userAvatar: missionList[index].userAvatar,
//             username: missionList[index].username,
//             missionDate: missionList[index].missionDate,
//             isStatus: missionList[index].isStatus,
//             isFavorite: missionList[index].isFavorite,
//             missionStatus: missionList[index].missionStatus,
//           );
//           },
//         ),
//       ),
//     );
//   }
// }
