import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../Components/Selection/primaryTagSelectionComponent.dart';
import '../../Components/Selection/thirdStatusSelectionComponent.dart';
import '../../Components/Title/secondaryTitleComponent.dart';
import '../../Constants/textStyleConstant.dart';

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
                statusList: ["待完成", "待审核", "未通过", "待到账", "已到账", "已退款"],
                selectedIndex: selectIndex,
                onTap: (index) {
                  setState(() {
                    selectIndex = index;
                  });
                },
              ),
              Row(
                children: [
                  Expanded(
                      flex: 8,
                      child: PrimaryTagSelectionComponent(
                        tagList: ["全部", "价格降序", "价格升序", "价格升序", "价格升序"],
                        selectedIndex: selectIndex,
                        onTap: (index) {
                          setState(() {
                            selectIndex = index;
                          });
                        },
                      )),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "64条相关",
                      style: unselectedTagTextStyle,
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
