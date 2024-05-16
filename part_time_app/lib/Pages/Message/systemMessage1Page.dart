import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../Components/Card/missionCardComponent.dart';
import '../../Components/List/messageListComponent.dart';
import '../../Components/Loading/customRefreshComponent.dart';
import '../../Components/Loading/missionCardLoading.dart';
import '../../Constants/apiConstant.dart';
import '../../Model/notification/messageModel.dart';
import '../../Utils/apiUtils.dart';
import '../../Model/Task/missionClass.dart';

class SystemMessage1Page extends StatefulWidget {
  const SystemMessage1Page({super.key});

  @override
  State<SystemMessage1Page> createState() => _SystemMessage1PageState();
}

class _SystemMessage1PageState extends State<SystemMessage1Page> {
  ScrollController _scrollController = ScrollController();
  List<TaskClass> _taskList = [];
  bool _isLoading = false;
  int _page = 1;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchData();
    }
  }

  Future<void> _fetchData() async {
    if (!_isLoading && _hasMore) {
      setState(() {
        _isLoading = true;
      });

      final String url = port + exploreURL + '?page=$_page';
      final Map<String, String> headers = {
        'Content-Type': 'application/json; charset=utf-8',
      };
      final response = await getRequest(url, headers);

      if (response.statusCode == 200) {
        setState(() {
          Map<String, dynamic> jsonResponse =
              json.decode(utf8.decode(response.responseBody.runes.toList()));
          List<dynamic> data = jsonResponse['data'];
          if (data.isNotEmpty) {
            _taskList
                .addAll(data.map((item) => TaskClass.fromJson(item)).toList());
            _page++;
            _isLoading = false;
            setState(() {
              jsonResponse = {};
              data = [];
            });
          } else {
            // Stop loading more data if fetched data is null or empty
            _hasMore = false;
          }
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Infinite Scroll Demo'),
        ),
        body: Container(
            child: Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _taskList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MissionCardComponent(
                      missionTitle: _taskList[index].taskTitle ?? "",
                      missionDesc: _taskList[index].taskContent ?? "",
                      tagList: _taskList[index]
                              .taskTagNames
                              ?.map((tag) => tag.tagName)
                              .toList() ??
                          [],
                      missionPrice: _taskList[index].taskSinglePrice ?? 0.0,
                      userAvatar: _taskList[index].avatar ?? "",
                      username: _taskList[index].nickname ?? "",
                      missionDate: _taskList[index].taskUpdatedTime ?? "",
                    );
                  },
                ),
                if (_hasMore) MissionCardLoadingComponent(),
              ],
            ),
          ),
        )));
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  // Widget _buildMissionListView2(List<TaskClass> missionList) {
  //   return ListView.builder(
  //     padding: EdgeInsets.only(top: 10),
  //     shrinkWrap: true,
  //     physics: NeverScrollableScrollPhysics(),
  //     itemCount: missionList.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       if (index < missionList.length) {
  //         return MissionCardComponent(
  //           missionTitle: missionList[index].taskTitle,
  //           missionDesc: missionList[index].taskContent,
  //           tagList: missionList[index]
  //                   .taskTagNames
  //                   .map((tag) => tag.tagName)
  //                   .toList() ??
  //               [],
  //           missionPrice: missionList[index].taskSinglePrice,
  //           userAvatar: missionList[index].avatar,
  //           username: missionList[index].username,
  //           missionDate: missionList[index].taskUpdatedTime,
  //         );
  //       } else {
  //         return MissionCardLoadingComponent();
  //       }
  //     },
  //   );
  // }
}
