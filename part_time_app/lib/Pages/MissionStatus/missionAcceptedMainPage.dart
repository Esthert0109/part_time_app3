import 'package:flutter/material.dart';
import 'package:part_time_app/Components/Selection/thirdStatusSelectionComponent.dart';

class MissionAcceptedMainPage extends StatefulWidget {
  const MissionAcceptedMainPage({super.key});

  @override
  State<MissionAcceptedMainPage> createState() =>
      _MissionAcceptedMainPageState();
}

class _MissionAcceptedMainPageState extends State<MissionAcceptedMainPage> {
  int statusSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ThirdStatusSelectionComponent(
            statusList: const ['待完成', '待审核', '未通过', '待到账', '已到账'],
            selectedIndex: statusSelected,
            onTap: (index) {
              setState(() {
                statusSelected = index;
              });
            })
      ],
    );
  }
}
