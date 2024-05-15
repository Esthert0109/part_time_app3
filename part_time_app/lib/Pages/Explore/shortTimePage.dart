import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../Components/Card/missionCardComponent.dart';
import '../../Components/Loading/customRefreshComponent.dart';
import '../../Components/Loading/missionCardLoading.dart';
import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/Task/missionClass.dart';
import '../MockData/missionMockData.dart';

bool noInitialRefresh = true;
List<MissionMockClass>? missionShortTime = [];

class ShortTimePage extends StatefulWidget {
  const ShortTimePage({super.key});

  @override
  State<ShortTimePage> createState() => _ShortTimePageState();
}

class _ShortTimePageState extends State<ShortTimePage> {
  final RefreshController _refreshRecommendationController =
      RefreshController(initialRefresh: noInitialRefresh);
  int currentPage = 1;
  int itemsPerPage = 6;
  bool isLoading = false;
  bool isFirstLaunch = true;
  bool reachEndOfList = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  _loadData() async {
    if (!isLoading && !reachEndOfList) {
      setState(() {
        isLoading = true;
      });
      // Simulate fetching data
      await Future.delayed(Duration(seconds: 2));
      int start = (currentPage - 1) * itemsPerPage;
      int end = start + itemsPerPage;

      if (MissionAvailableList.length > start) {
        if (isFirstLaunch) {
          missionShortTime = MissionAvailableList.sublist(
              start,
              end > MissionAvailableList.length
                  ? MissionAvailableList.length
                  : end);
          isFirstLaunch = false;
        } else {
          missionShortTime!.addAll(MissionAvailableList.sublist(
              start,
              end > MissionAvailableList.length
                  ? MissionAvailableList.length
                  : end));
        }

        // Sort the missionAvailable list
        _sortMissionAvailable();

        if (mounted) {
          setState(() {
            isLoading = false;
            currentPage++;
          });
        }
      } else {
        // No more data to load
        setState(() {
          reachEndOfList = true;
          isLoading = false;
        });
      }
      noInitialRefresh = false;
    }
  }

  void _sortMissionAvailable() {
    //control time
    missionShortTime!.sort((a, b) => b.missionDate!.compareTo(a.missionDate!));
  }

  _scrollListener() {
    if (!_scrollController.hasClients || isLoading) return;
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _loadData();
    }
    _refreshRecommendationController.refreshCompleted();
  }

  Future<void> _refresh() async {
    if (!isLoading) {
      setState(() {
        currentPage = 1;
        missionShortTime = [];
        reachEndOfList = false;
      });
      await _loadData();
    }
    _refreshRecommendationController.refreshCompleted();
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
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: true,
          title: Container(
              color: kTransparent,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: const thirdTitleComponent(
                text: "用时短",
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
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!isLoading &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              _loadData();
            }
            return true;
          },
          child: CustomRefreshComponent(
              onRefresh: _refresh,
              controller: _refreshRecommendationController,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildMissionListView(missionShortTime!),
                          ],
                        )),
                  ],
                ),
              )),
        ),
      ),
    ));
  }

  Widget _buildMissionListView(List<MissionMockClass> missionList) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      shrinkWrap: true,
      physics: PageScrollPhysics(),
      itemCount: missionList.length + (isLoading ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index < missionList.length) {
          return MissionCardComponent(
            missionTitle: missionList[index].missionTitle,
            missionDesc: missionList[index].missionDesc,
            tagList: missionList[index].tagList ?? [],
            missionPrice: missionList[index].missionPrice,
            userAvatar: missionList[index].userAvatar,
            username: missionList[index].username,
            missionDate: missionList[index].missionDate,
            isStatus: missionList[index].isStatus,
            isFavorite: missionList[index].isFavorite,
            missionStatus: missionList[index].missionStatus,
          );
        } else {
          return const MissionCardLoadingComponent();
        }
      },
    );
  }
}
