import 'package:flutter/material.dart';

import '../../Components/Button/primaryButtonComponent.dart';
import '../../Components/Card/missionCardComponent.dart';
import '../../Components/Loading/missionCardLoading.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../MockData/missionMockClass.dart';
import '../MockData/missionMockData.dart';

List<MissionMockClass>? missionHighCom = [];

class HighCommisionPage extends StatefulWidget {
  const HighCommisionPage({super.key});

  @override
  State<HighCommisionPage> createState() => _HighCommisionPageState();
}

class _HighCommisionPageState extends State<HighCommisionPage> {
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
          missionHighCom = MissionAvailableList.sublist(
              start,
              end > MissionAvailableList.length
                  ? MissionAvailableList.length
                  : end);
          isFirstLaunch = false;
        } else {
          missionHighCom!.addAll(MissionAvailableList.sublist(
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
    missionHighCom!.sort((a, b) => b.missionDate!.compareTo(a.missionDate!));
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
        missionHighCom = [];
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
              color: kMainYellowColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
                      scrolledUnderElevation: 0.0,
                      surfaceTintColor: Colors.transparent,
                      title: const Text(
                        "高赏金",
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
                        padding: EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildMissionListView(missionHighCom!),
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


// List<MissionMockClass> missionAvailable = [];
  // int currentIndex = 0;
  // final int increment = 10;
  // bool isLoadingVertical = false;

  // @override
  // void initState() {
  //   _loadMoreVertical();
  //   super.initState();
  // }

  // Future _loadMoreVertical() async {
  //   setState(() {
  //     isLoadingVertical = true;
  //   });

  //   // Add in an artificial delay
  //   await Future.delayed(const Duration(seconds: 2));

  //   int nextIndex = currentIndex + increment;
  //   if (nextIndex > MissionAvailableList.length) {
  //     nextIndex = MissionAvailableList.length;
  //   }

  //   missionAvailable
  //       .addAll(MissionAvailableList.sublist(currentIndex, nextIndex));
  //   currentIndex = nextIndex;

  //   if (mounted) {
  //     setState(() {
  //       isLoadingVertical = false;
  //     });
  //   }
  // }

// LazyLoadScrollView(
//         onEndOfPage: () => _loadMoreVertical(),
//         child: ListView.builder(
//           itemCount: missionAvailable.length,
//           itemBuilder: (context, position) {
//             return MissionCardComponent(
//               missionTitle: missionAvailable[position].missionTitle,
//               missionDesc: missionAvailable[position].missionDesc,
//               tagList: missionAvailable[position].tagList ?? [],
//               missionPrice: missionAvailable[position].missionPrice,
//               userAvatar: missionAvailable[position].userAvatar,
//               username: missionAvailable[position].username,
//               missionDate: missionAvailable[position].missionDate,
//               isStatus: missionAvailable[position].isStatus,
//               isFavorite: missionAvailable[position].isFavorite,
//               missionStatus: missionAvailable[position].missionStatus,
//             );
//           },
//         ),
//       ),
