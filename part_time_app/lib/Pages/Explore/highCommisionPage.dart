import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/Card/missionCardComponent.dart';
import '../../Components/Loading/missionCardLoading.dart';
import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

import '../../Model/Task/missionClass.dart';
import '../../Services/explore/exploreServices.dart';
import '../MissionRecipient/missionDetailRecipientPage.dart';

bool noInitialRefresh = true;

class HighCommisionPage extends StatefulWidget {
  const HighCommisionPage({super.key});

  @override
  State<HighCommisionPage> createState() => _HighCommisionPageState();
}

class _HighCommisionPageState extends State<HighCommisionPage> {
  ScrollController _scrollController = ScrollController();
  int page = 1;
  bool isLoading = false;
  bool continueLoading = true;

  List<TaskClass> missionHighCom = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      if (!isLoading && continueLoading) {
        _loadData();
      }
    }
  }

  Future<void> _loadData() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    try {
      final List<TaskClass> data =
          await ExploreService().fetchCategoryList(1, page);
      setState(() {
        if (data.isNotEmpty) {
          missionHighCom.addAll(data);
          page++;
        } else {
          continueLoading = false;
        }
        isLoading = false;
      });
    } catch (e) {
      print('Error in exploreData: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _refresh() async {
    if (!isLoading) {
      setState(() {
        missionHighCom.clear();
        page = 1;
        continueLoading = true;
        _loadData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0.0,
            leading: IconButton(
              iconSize: 15,
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Get.back();
              },
            ),
            centerTitle: true,
            title: Container(
                color: kTransparent,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: thirdTitleComponent(
                  text: "高赏金",
                ))),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFCEEA5), Color(0xFFF9F9F9)],
              stops: [0.0, 0.2],
            ),
            color: Color(0xFFf8f8f8),
          ),
          child: RefreshIndicator(
              onRefresh: _refresh,
              color: kMainYellowColor,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(12),
                controller: _scrollController,
                child: Column(
                  children: [
                    _buildMissionListView(missionHighCom),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget _buildMissionListView(List<TaskClass> missionList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: missionList.length + (continueLoading ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index == missionList.length) {
          return const MissionCardLoadingComponent();
        } else {
          return GestureDetector(
            onTap: () {
              Get.to(
                  () => MissionDetailRecipientPage(
                        taskId: missionList[index].taskId,
                      ),
                  transition: Transition.rightToLeft);
            },
            child: MissionCardComponent(
              taskId: missionList[index].taskId,
              missionTitle: missionList[index].taskTitle ?? "",
              missionDesc: missionList[index].taskContent ?? "",
              tagList: missionList[index]
                      .taskTagNames
                      ?.map((tag) => tag.tagName)
                      .toList() ??
                  [],
              missionPrice: missionList[index].taskSinglePrice ?? 0.0,
              userAvatar: missionList[index].avatar ?? "",
              username: missionList[index].nickname ?? "",
              missionDate: missionList[index].taskUpdatedTime ?? "",
              isFavorite: missionList[index].collectionValid ?? false,
            ),
          );
        }
      },
    );
  }
}
