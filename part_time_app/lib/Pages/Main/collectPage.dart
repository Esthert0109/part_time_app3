import 'package:flutter/material.dart';

import '../../Components/Card/missionCardComponent.dart';
import '../../Components/Loading/missionCardLoading.dart';
import '../MockData/missionMockClass.dart';
import '../MockData/missionMockData.dart';

bool dataFetchedCollect = false;
bool dataEndCollect = false;
List<MissionMockClass>? missionAvailableForCollect = [];

class CollectPage extends StatefulWidget {
  const CollectPage({super.key});

  @override
  State<CollectPage> createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage> {
  int currentPage = 1;
  int itemsPerPage = 1;
  bool isLoading = false;
  bool isFirstLaunch = true;
  bool reachEndOfList = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (!dataFetchedCollect && !dataEndCollect) {
      // Fetch data only if it hasn't been fetched before
      _loadData();
    }
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  _loadData() async {
    if (!isLoading && !reachEndOfList && !dataEndCollect) {
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
          missionAvailableForCollect = filteredList.sublist(
              start, end > filteredList.length ? filteredList.length : end);
          isFirstLaunch = false;
        } else {
          missionAvailableForCollect!.addAll(filteredList.sublist(
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
          dataEndCollect = true;
          isLoading = false;
        });
      }
      dataFetchedCollect = true;
    }
  }

  void _sortMissionAvailable() {
    //control time
    missionAvailableForCollect!
        .sort((a, b) => b.missionDate!.compareTo(a.missionDate!));
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
        missionAvailableForCollect = [];
        reachEndOfList = false;
        dataEndCollect = false;
      });
      await _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Padding(
              padding: EdgeInsets.all(10),
              child: buildListView(),
            )),
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      // controller: _scrollController,
      itemCount: missionAvailableForCollect!.length + (isLoading ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index < missionAvailableForCollect!.length) {
          return MissionCardComponent(
            missionTitle: missionAvailableForCollect![index].missionTitle,
            missionDesc: missionAvailableForCollect![index].missionDesc,
            tagList: missionAvailableForCollect![index].tagList ?? [],
            missionPrice: missionAvailableForCollect![index].missionPrice,
            userAvatar: missionAvailableForCollect![index].userAvatar,
            username: missionAvailableForCollect![index].username,
            missionDate: missionAvailableForCollect![index].missionDate,
            isStatus: missionAvailableForCollect![index].isStatus,
            isFavorite: missionAvailableForCollect![index].isFavorite,
            missionStatus: missionAvailableForCollect![index].missionStatus,
          );
        } else {
          return MissionCardLoadingComponent();
        }
      },
    );
  }
}
