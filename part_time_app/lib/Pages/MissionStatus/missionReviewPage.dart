import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:part_time_app/Components/Card/missionReviewRecipientCardComponent.dart';
import 'package:part_time_app/Services/order/orderServices.dart';

import '../../Components/Loading/missionReviewLoading.dart';
import '../../Components/Selection/primaryTagSelectionComponent.dart';
import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Model/Task/missionClass.dart';
import 'missionReviewDetailPage.dart';

bool dataFetchedReview = false;
bool dataEndReview = false;

class MissionReviewPage extends StatefulWidget {
  final int taskId;
  const MissionReviewPage({super.key, required this.taskId});

  @override
  State<MissionReviewPage> createState() => _MissionReviewPageState();
}

class _MissionReviewPageState extends State<MissionReviewPage> {
  int totalMissionReview = 0;
  int selectedStatusIndex = 0;
  bool isMissionFailed = true;
  bool isLoading = false;

  bool isFirstLaunch = true;
  bool reachEndOfList = false;
  int currentPage = 1;
  int itemsPerPage = 1;
  ScrollController _scrollController = ScrollController();

  // set status on mission review recipient card component
  bool isReviewing = false;
  bool isCompleted = false;

  // services
  OrderServices services = OrderServices();
  int waitCompleteCount = 0;
  List<CustomerList> waitCompleteList = [];
  int waitReviewCount = 0;
  List<CustomerList> waitReviewList = [];
  int completedCount = 0;
  List<CustomerList> completedList = [];

  calculateTotalMission() {
    setState(() {
      totalMissionReview = waitCompleteCount + waitReviewCount + completedCount;
    });
  }

  @override
  void initState() {
    super.initState();

    fetchData();

    if (!dataFetchedReview && !dataEndReview) {
      // Fetch data only if it hasn't been fetched before
      // _loadData();
    }
    _scrollController.addListener(_scrollListener);
  }

  fetchData() async {
    setState(() {
      isLoading = true;
    });
    for (int i = 0; i < 3; i++) {
      CustomerListModel? model =
          await services.getCustomerListByOrderStatusId(i, widget.taskId, 1);
      if (i == 0) {
        setState(() {
          waitCompleteCount = model?.data?.totalCount ?? 0;
          waitCompleteList = model?.data?.customerList ?? [];
        });
      } else if (i == 1) {
        setState(() {
          waitReviewCount = model?.data?.totalCount ?? 0;
          waitReviewList = model?.data?.customerList ?? [];
        });
      } else if (i == 2) {
        setState(() {
          completedCount = model?.data?.totalCount ?? 0;
          completedList = model?.data?.customerList ?? [];
        });
      }
    }
    calculateTotalMission();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    if (!_scrollController.hasClients || isLoading) return;
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      fetchData();
    }
  }

  Future<void> _refresh() async {
    if (!isLoading) {
      setState(() {
        currentPage = 1;

        reachEndOfList = false;
        dataEndReview = false;
      });
      // await _loadData();
    }
  }

  Widget buildListView() {
    double screenHeight = MediaQuery.of(context).size.height;
    switch (selectedStatusIndex) {
      case 0:
        isReviewing = false;
        isCompleted = false;
        if (waitReviewList.length > 0) {
          return buildMissionAcceptedListView(waitReviewList, false);
        } else {
          return SizedBox(
            height: screenHeight - 200,
            width: double.infinity,
            child: Center(
              child: SvgPicture.asset("assets/mission/statusNullHandle.svg"),
            ),
          );
        }
      case 1:
        isReviewing = true;
        isCompleted = false;
        if (waitCompleteList.length > 0) {
          return buildMissionAcceptedListView(waitCompleteList, false);
        } else {
          return SizedBox(
            height: screenHeight - 200,
            width: double.infinity,
            child: Center(
              child: SvgPicture.asset("assets/mission/statusNullHandle.svg"),
            ),
          );
        }
      case 2:
        isReviewing = false;
        isCompleted = true;
        if (completedList.length > 0) {
          return buildMissionAcceptedListView(completedList, false);
        } else {
          return SizedBox(
            height: screenHeight - 200,
            width: double.infinity,
            child: Center(
              child: SvgPicture.asset("assets/mission/statusNullHandle.svg"),
            ),
          );
        }
      default:
        return SizedBox();
    }
  }

  Widget buildMissionAcceptedListView(
      List<CustomerList> customerList, bool completed) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: customerList.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < customerList.length) {
            return MissionReviewRecipientCardComponent(
                isReviewing: isReviewing,
                isCompleted: isCompleted,
                duration: DateTime.parse(completed
                    ? customerList[index].orderAExpiredTime ??
                        "2024-05-24 17:04:53"
                    : customerList[index].orderBExpiredTime ??
                        "2024-05-24 17:04:53"),
                onTap: () {
                  Get.to(
                      () => MissionReviewDetailPage(
                            isCompleted: isCompleted,
                            orderId: customerList[index].orderId!,
                          ),
                      transition: Transition.rightToLeft);
                },
                userAvatar: customerList[index].avatar,
                username: customerList[index].nickname);
          } else {
            return MissionReviewLoading();
          }
        });
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
                  text: "悬赏进度(${totalMissionReview.toString()})",
                ))),
        body: Container(
          constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: kThirdGreyColor,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                kBackgroundFirstGradientColor,
                kBackgroundSecondGradientColor
              ],
              stops: [0.0, 0.15],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: PrimaryTagSelectionComponent(
                  tagList: [
                    "待完成(${waitReviewCount.toString()})",
                    "待审核(${waitCompleteCount.toString()})",
                    "已完成(${completedCount.toString()})"
                  ],
                  selectedIndex: selectedStatusIndex,
                  onTap: (index) {
                    setState(() {
                      selectedStatusIndex = index;
                    });
                  },
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                controller: _scrollController,
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  color: kMainYellowColor,
                  child: isLoading ? MissionReviewLoading() : buildListView(),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
