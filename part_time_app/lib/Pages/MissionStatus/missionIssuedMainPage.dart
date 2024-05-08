import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../Components/Card/missionCardComponent.dart';
import '../../Components/Loading/missionCardLoading.dart';
import '../../Components/Selection/thirdStatusSelectionComponent.dart';
import '../../Constants/colorConstant.dart';
import '../MissionIssuer/missionDetailStatusIssuerPage.dart';
import '../MissionRecipient/missionDetailRecipientPage.dart';
import '../MockData/missionMockClass.dart';
import '../MockData/missionMockData.dart';

bool dataFetchedIssued = false;
bool dataEndIssued = false;
List<MissionMockClass>? missionWaitSystemReview = [];
List<MissionMockClass>? missionSystemFailed = [];
List<MissionMockClass>? missionSystemPassed = [];
List<MissionMockClass>? missionCompleted = [];
List<MissionMockClass>? missionWaitRefund = [];
List<MissionMockClass>? missionRefund = [];

class MissionIssuedMainPage extends StatefulWidget {
  const MissionIssuedMainPage({super.key});

  @override
  State<MissionIssuedMainPage> createState() => _MissionIssuedMainPageState();
}

class _MissionIssuedMainPageState extends State<MissionIssuedMainPage> {
  int statusSelected = 0;
  bool isLoading = false;
  bool isFirstLaunch = true;
  bool reachEndOfList = false;
  int currentPage = 1;
  int itemsPerPage = 1;
  ScrollController _scrollController = ScrollController();

  // set status on mission detail status issuer page
  bool isWaiting = false;
  bool isFailed = false;
  bool isPassed = false;
  bool isRemoved = false;

  @override
  void initState() {
    super.initState();
    if (!dataFetchedIssued && !dataEndIssued) {
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
    if (!isLoading && !reachEndOfList && !dataEndIssued) {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(Duration(seconds: 2));
      int start = (currentPage - 1) * itemsPerPage;
      int end = start + itemsPerPage;

      if (MissionAvailableList.length > start) {
        if (isFirstLaunch) {
          missionWaitSystemReview = MissionAvailableList.sublist(
              start,
              end > MissionAvailableList.length
                  ? MissionAvailableList.length
                  : end);
          isFirstLaunch = false;
        } else {
          missionWaitSystemReview!.addAll(MissionAvailableList.sublist(
              start,
              end > MissionAvailableList.length
                  ? MissionAvailableList.length
                  : end));
        }
        if (mounted) {
          setState(() {
            isLoading = false;
            currentPage++;
          });
        }
      } else {
        setState(() {
          reachEndOfList = true;
          dataEndIssued = true;
          isLoading = false;
        });
      }
      dataFetchedIssued = true;
    }
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
        missionWaitSystemReview = [];
        reachEndOfList = false;
        dataEndIssued = false;
      });
      await _loadData();
    }
  }

  Widget buildMissionAcceptedListView(List<MissionMockClass> missionList) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: missionList.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < missionList.length) {
            return GestureDetector(
              child: MissionCardComponent(
                missionTitle: missionList[index].missionTitle,
                missionDesc: missionList[index].missionDesc,
                tagList: missionList[index].tagList ?? [],
                missionPrice: missionList[index].missionPrice,
                userAvatar: missionList[index].userAvatar,
                username: missionList[index].username,
                isStatus: true,
                missionStatus: missionList[index].missionStatus,
              ),
              onTap: () {
                Get.to(() => MissionDetailStatusIssuerPage(
                    isWaiting: isWaiting,
                    isFailed: isFailed,
                    isPassed: isPassed,
                    isRemoved: isRemoved));
              },
            );
          } else {
            return MissionCardLoadingComponent();
          }
        });
  }

  Widget buildListView() {
    switch (statusSelected) {
      case 0:
        isWaiting = true;
        isFailed = false;
        isPassed = false;
        isRemoved = false;
        return buildMissionAcceptedListView(missionWaitSystemReview!);
      case 1:
        isWaiting = false;
        isFailed = true;
        isPassed = false;
        isRemoved = false;
        return buildMissionAcceptedListView(missionWaitSystemReview!);
      case 2:
        isWaiting = false;
        isFailed = false;
        isPassed = true;
        isRemoved = false;
        return buildMissionAcceptedListView(missionWaitSystemReview!);
      case 3:
        isWaiting = false;
        isFailed = false;
        isPassed = false;
        isRemoved = true;
        return buildMissionAcceptedListView(missionWaitSystemReview!);
      case 4:
        isWaiting = false;
        isFailed = false;
        isPassed = false;
        isRemoved = true;
        return buildMissionAcceptedListView(missionWaitSystemReview!);
      case 5:
        isWaiting = false;
        isFailed = false;
        isPassed = false;
        isRemoved = true;
        return buildMissionAcceptedListView(missionWaitSystemReview!);
      default:
        return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ThirdStatusSelectionComponent(
            statusList: const ['待审核', '未通过', '已通过', '已完成', '待退款', '已退款'],
            selectedIndex: statusSelected,
            onTap: (index) {
              setState(() {
                statusSelected = index;
                _loadData();
              });
            }),
        Expanded(
          child: SingleChildScrollView(
              controller: _scrollController,
              child: RefreshIndicator(
                onRefresh: _refresh,
                color: kMainYellowColor,
                child: buildListView(),
              )),
        )
      ],
    );
  }
}
