import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:part_time_app/Components/CommonComponents/secondarySystemMessageCardComponent.dart';

class ExploreMainPage extends StatefulWidget {
  const ExploreMainPage({super.key});

  @override
  State<ExploreMainPage> createState() => _ExploreMainPageState();
}

class _ExploreMainPageState extends State<ExploreMainPage> {
  @override
  Widget build(BuildContext context) {
    return secondarySystemMessageCardComponent(
      messageTitle: '举报成功！',
      messageContent:
          '举报理由：XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
      imageUrl: '',
    );
  }
}
