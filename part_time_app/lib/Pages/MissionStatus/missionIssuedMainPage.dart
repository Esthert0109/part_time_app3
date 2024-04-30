import 'package:flutter/material.dart';

import '../../Components/Selection/thirdStatusSelectionComponent.dart';

class MissionIssuedMainPage extends StatefulWidget {
  const MissionIssuedMainPage({super.key});

  @override
  State<MissionIssuedMainPage> createState() => _MissionIssuedMainPageState();
}

class _MissionIssuedMainPageState extends State<MissionIssuedMainPage> {
  int statusSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ThirdStatusSelectionComponent(
            statusList: const ['待审核', '未通过', '已通过', '已完成', '待退款', '已退款'],
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
