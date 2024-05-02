import 'package:flutter/material.dart';

import '../../Components/Card/missionCardComponent.dart';
import '../../Constants/textStyleConstant.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../MockData/missionMockClass.dart';
import '../MockData/missionMockData.dart';

class HighCommisionPage extends StatefulWidget {
  const HighCommisionPage({super.key});

  @override
  State<HighCommisionPage> createState() => _HighCommisionPageState();
}

class _HighCommisionPageState extends State<HighCommisionPage> {
  // List<MissionMockClass> missionAvailable = [];
  // int currentIndex = 0;
  // final int increment = 10;
  // bool isLoadingVertical = false;

  // @override
  // void initState() {
  //   _loadMoreVertical();
  //   super.initState();
  // }

  // Future _loadMoreVertical() async {
  //   setState(() {
  //     isLoadingVertical = true;
  //   });

  //   // Add in an artificial delay
  //   await Future.delayed(const Duration(seconds: 2));

  //   int nextIndex = currentIndex + increment;
  //   if (nextIndex > MissionAvailableList.length) {
  //     nextIndex = MissionAvailableList.length;
  //   }

  //   missionAvailable
  //       .addAll(MissionAvailableList.sublist(currentIndex, nextIndex));
  //   currentIndex = nextIndex;

  //   if (mounted) {
  //     setState(() {
  //       isLoadingVertical = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TEST TEST"),
      ),
      // body:
    );
  }
}
// LazyLoadScrollView(
//         onEndOfPage: () => _loadMoreVertical(),
//         child: ListView.builder(
//           itemCount: missionAvailable.length,
//           itemBuilder: (context, position) {
//             return MissionCardComponent(
//               missionTitle: missionAvailable[position].missionTitle,
//               missionDesc: missionAvailable[position].missionDesc,
//               tagList: missionAvailable[position].tagList ?? [],
//               missionPrice: missionAvailable[position].missionPrice,
//               userAvatar: missionAvailable[position].userAvatar,
//               username: missionAvailable[position].username,
//               missionDate: missionAvailable[position].missionDate,
//               isStatus: missionAvailable[position].isStatus,
//               isFavorite: missionAvailable[position].isFavorite,
//               missionStatus: missionAvailable[position].missionStatus,
//             );
//           },
//         ),
//       ),
