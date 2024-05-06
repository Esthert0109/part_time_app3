import 'package:flutter/material.dart';
import '../../Components/Card/missionCardComponent.dart';
import '../../Components/Loading/missionCardLoading.dart';
import '../../Constants/textStyleConstant.dart';
import '../MockData/missionMockClass.dart';
import '../MockData/missionMockData.dart';

List<MissionMockClass>? missionShortTime = [];

class ShortTimePage extends StatefulWidget {
  const ShortTimePage({super.key});

  @override
  State<ShortTimePage> createState() => _ShortTimePageState();
}

class _ShortTimePageState extends State<ShortTimePage> {
  int currentPage = 1;
  int itemsPerPage = 6;
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
          child: RefreshIndicator(
              onRefresh: _refresh,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
                      scrolledUnderElevation: 0.0,
                      surfaceTintColor: Colors.transparent,
                      title: const Text(
                        "用时短",
                        textAlign: TextAlign.center,
                        style: dialogText2,
                      ),
                      centerTitle: true,
                      leading: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 16,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(15),
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
