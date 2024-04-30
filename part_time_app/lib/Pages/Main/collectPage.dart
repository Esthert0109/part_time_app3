import 'package:flutter/material.dart';

import '../../Components/Card/missionCardComponent.dart';
import '../../Components/Loading/missionCardLoading.dart';
import '../MockData/missionMockClass.dart';
import '../MockData/missionMockData.dart';

class CollectPage extends StatefulWidget {
  const CollectPage({super.key});

  @override
  State<CollectPage> createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage> {
  List<MissionMockClass>? missionAvailable = [];

  int currentPage = 1;
  int itemsPerPage = 10;
  bool isLoading = false;
  bool isFirstLaunch = true;
  bool reachEndOfList = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData();
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
      List<MissionMockClass> filteredList =
          MissionAvailableList.where((mission) => mission.isFavorite!).toList();
      if (filteredList.length > start) {
        if (isFirstLaunch) {
          missionAvailable = filteredList.sublist(
              start, end > filteredList.length ? filteredList.length : end);
          isFirstLaunch = false;
        } else {
          missionAvailable!.addAll(filteredList.sublist(
              start, end > filteredList.length ? filteredList.length : end));
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
    }
  }

  void _sortMissionAvailable() {
    //control time
    missionAvailable!.sort((a, b) => b.missionDate!.compareTo(a.missionDate!));
  }

  _scrollListener() {
    if (!_scrollController.hasClients || isLoading) return;
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _loadData();
    }
  }

  Future<void> _refresh() async {
    if (!isLoading) {
      setState(() {
        currentPage = 1;
        missionAvailable = [];
        reachEndOfList = false;
      });
      await _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _loadData();
          }
          return true;
        },
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
              padding: EdgeInsets.all(10),
              controller: _scrollController,
              child: buildListView()),
        ),
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      // controller: _scrollController,
      itemCount: missionAvailable!.length + (isLoading ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index < missionAvailable!.length) {
          return MissionCardComponent(
            missionTitle: missionAvailable![index].missionTitle,
            missionDesc: missionAvailable![index].missionDesc,
            tagList: missionAvailable![index].tagList ?? [],
            missionPrice: missionAvailable![index].missionPrice,
            userAvatar: missionAvailable![index].userAvatar,
            username: missionAvailable![index].username,
            missionDate: missionAvailable![index].missionDate,
            isStatus: missionAvailable![index].isStatus,
            isFavorite: missionAvailable![index].isFavorite,
            missionStatus: missionAvailable![index].missionStatus,
          );
        } else {
          return MissionCardLoadingComponent();
        }
      },
    );
  }
}
