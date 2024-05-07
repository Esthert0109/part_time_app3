import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:part_time_app/Components/Loading/missionCardLoading.dart';
import 'package:part_time_app/Components/Selection/thirdStatusSelectionComponent.dart';
import 'package:part_time_app/Pages/MissionRecipient/missionDetailRecipientPage.dart';
import 'package:part_time_app/Pages/MockData/missionMockData.dart';

import '../../Components/Card/missionCardComponent.dart';
import '../../Constants/colorConstant.dart';
import '../MissionIssuer/missionDetailStatusIssuerPage.dart';
import '../MockData/missionMockClass.dart';

bool dataFetchedAccepted = false;
bool dataEndAccepted = false;
List<MissionMockClass>? missionWaitComplete = [];
List<MissionMockClass>? missionWaitReview = [];
List<MissionMockClass>? missionFailed = [];
List<MissionMockClass>? missionWaitPayment = [];
List<MissionMockClass>? missionPaid = [];

class MissionAcceptedMainPage extends StatefulWidget {
  const MissionAcceptedMainPage({super.key});

  @override
  State<MissionAcceptedMainPage> createState() =>
      _MissionAcceptedMainPageState();
}

class _MissionAcceptedMainPageState extends State<MissionAcceptedMainPage> {
  int statusSelected = 0;
  bool isLoading = false;
  bool isFirstLaunch = true;
  bool reachEndOfList = false;
  int currentPage = 1;
  int itemsPerPage = 1;
  ScrollController _scrollController = ScrollController();

  //set status on mission detail recipient page
  bool isStarted = false;
  bool isSubmitted = false;
  bool isExpired = false;
  bool isWaitingPaid = false;
  bool isPaid = false;
  bool isFailed = false;

  @override
  void initState() {
    super.initState();
    if (!dataFetchedAccepted && !dataEndAccepted) {
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
    if (!isLoading && !reachEndOfList && !dataEndAccepted) {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(Duration(seconds: 2));
      int start = (currentPage - 1) * itemsPerPage;
      int end = start + itemsPerPage;

      if (MissionAvailableList.length > start) {
        if (isFirstLaunch) {
          missionWaitComplete = MissionAvailableList.sublist(
              start,
              end > MissionAvailableList.length
                  ? MissionAvailableList.length
                  : end);
          isFirstLaunch = false;
        } else {
          missionWaitComplete!.addAll(MissionAvailableList.sublist(
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
          dataEndAccepted = true;
          isLoading = false;
        });
      }
      dataFetchedAccepted = true;
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
        missionWaitComplete = [];
        reachEndOfList = false;
        dataEndAccepted = false;
      });
      await _loadData();
    }
  }

  Widget buildListView() {
    switch (statusSelected) {
      case 0:
        isStarted = true;
        isSubmitted = false;
        isExpired = false;
        isWaitingPaid = false;
        isPaid = false;
        isFailed = false;
        return buildMissionAcceptedListView(missionWaitComplete!);
      case 1:
        isStarted = false;
        isSubmitted = true;
        isExpired = false;
        isWaitingPaid = false;
        isPaid = false;
        isFailed = false;
        return buildMissionAcceptedListView(missionWaitComplete!);
      case 2:
        isStarted = false;
        isSubmitted = false;
        isExpired = false;
        isWaitingPaid = false;
        isPaid = false;
        isFailed = true;
        return buildMissionAcceptedListView(missionWaitComplete!);
      case 3:
        isStarted = false;
        isSubmitted = false;
        isExpired = false;
        isWaitingPaid = true;
        isPaid = false;
        isFailed = false;
        return buildMissionAcceptedListView(missionWaitComplete!);
      case 4:
        isStarted = false;
        isSubmitted = false;
        isExpired = false;
        isWaitingPaid = false;
        isPaid = true;
        isFailed = false;
        return buildMissionAcceptedListView(missionWaitComplete!);
      default:
        return SizedBox();
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
                Get.to(() => MissionDetailRecipientPage(
                    isStarted: isStarted,
                    isSubmitted: isSubmitted,
                    isExpired: isExpired,
                    isWaitingPaid: isWaitingPaid,
                    isFailed: isFailed,
                    isPaid: isPaid));
              },
            );
          } else {
            return MissionCardLoadingComponent();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ThirdStatusSelectionComponent(
            statusList: const ['待完成', '待审核', '未通过', '待到账', '已到账'],
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
              child: buildListView()),
        ))
      ],
    );
  }
}
