import 'package:flutter/material.dart';

import '../../Components/Selection/thirdStatusSelectionComponent.dart';
import '../../Components/Title/secondaryTitleComponent.dart';

class ComponentExample extends StatefulWidget {
  const ComponentExample({super.key});

  @override
  State<ComponentExample> createState() => _ComponentExampleState();
}

class _ComponentExampleState extends State<ComponentExample> {
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SecondaryTitleComponent(
                titleList: ["推荐", "收藏", "我接收的", "我发布的", "发布悬赏"],
                selectedIndex: selectIndex,
                onTap: (index) {
                  setState(() {
                    selectIndex = index;
                  });
                },
              ),
              ThirdStatusSelectionComponent(
                statusList: ["待完成", "待审核", "未通过", "待到账", "已到账"],
                selectedIndex: selectIndex,
                onTap: (index) {
                  setState(() {
                    selectIndex = index;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
