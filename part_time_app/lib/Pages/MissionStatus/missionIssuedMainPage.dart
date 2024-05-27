import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:part_time_app/Constants/globalConstant.dart';

import '../../Components/Card/missionCardComponent.dart';
import '../../Components/Loading/missionCardLoading.dart';
import '../../Components/Selection/thirdStatusSelectionComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Services/order/orderServices.dart';
import '../MissionIssuer/missionDetailStatusIssuerPage.dart';
import '../../Model/Task/missionClass.dart';
import '../MockData/missionMockData.dart';

class MissionIssuedMainPage extends StatefulWidget {
  const MissionIssuedMainPage({super.key});

  @override
  State<MissionIssuedMainPage> createState() => _MissionIssuedMainPageState();
}

class _MissionIssuedMainPageState extends State<MissionIssuedMainPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int statusSelected = 0;
  bool isLoading = false;
  bool isContinueLoading = true;
  ScrollController _scrollController = ScrollController();

  OrderServices services = OrderServices();
  OrderModel? taskModel;

  @override
  void initState() {
    super.initState();
    fetchData();
    taskPage = 1;
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  fetchData() async {
    setState(() {
      isLoading = true;
      isContinueLoading = true;
    });

    for (int i = 0; i < 6; i++) {
      taskModel = await services.getTaskByStatus(i);
      if (taskModel != null &&
          taskModel!.data != null &&
          taskModel!.data!.isNotEmpty) {
        setState(() {
          if (i == 0) {
            if (taskModel!.data != []) {
              taskWaitReviewed.addAll(taskModel?.data ?? []);
            }
          } else if (i == 1) {
            if (taskModel!.data != []) {
              taskFailed.addAll(taskModel?.data ?? []);
            }
          } else if (i == 2) {
            if (taskModel!.data != []) {
              taskPassed.addAll(taskModel?.data ?? []);
            }
          } else if (i == 3) {
            if (taskModel!.data != []) {
              taskCompleted.addAll(taskModel?.data ?? []);
            }
          } else if (i == 4) {
            if (taskModel!.data != []) {
              taskWaitReturned.addAll(taskModel?.data ?? []);
            }
          } else if (i == 5) {
            if (taskModel!.data != []) {
              taskReturned.addAll(taskModel?.data ?? []);
            }
          }
        });
      } else {
        setState(() {
          isContinueLoading = false;
        });
      }
    }

    setState(() {
      taskPage++;
      isLoading = false;
    });
  }

  _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 1000) {
      if (!isLoading && isContinueLoading) {
        fetchData();
      }
    }
  }

  Future<void> _refresh() async {
    if (!isLoading && mounted) {
      setState(() {
        taskPage = 1;
        isContinueLoading = true;
        taskWaitReviewed.clear();
        taskFailed.clear();
        taskPassed.clear();
        taskCompleted.clear();
        taskWaitReturned.clear();
        taskReturned.clear();
      });
      await fetchData();
    }
  }

  Widget buildMissionAcceptedListView(List<OrderData> missionList) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: missionList.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == missionList.length) {
            return const MissionCardLoadingComponent();
          } else {
            return GestureDetector(
              child: MissionCardComponent(
                missionTitle: missionList[index].taskTitle!,
                missionDesc: missionList[index].taskContent!,
                tagList: missionList[index]
                        .taskTagNames
                        ?.map((tag) => tag.tagName)
                        .toList() ??
                    [],
                missionPrice: missionList[index].taskSinglePrice!,
                userAvatar: missionList[index].avatar!,
                username: missionList[index].nickname!,
                isStatus: true,
                isPublished: true,
                missionStatus: missionList[index].taskStatus!,
                missionDate: missionList[index].taskUpdatedTime!,
                customerId: missionList[index].customerId!,
              ),
              onTap: () {
                Get.to(
                    () => MissionDetailStatusIssuerPage(
                          taskId: missionList[index].taskId!,
                          isPreview: false,
                          isResubmit: false,
                        ),
                    transition: Transition.rightToLeft);
              },
            );
          }
        });
  }

  Widget buildListView() {
    double screenHeight = MediaQuery.of(context).size.height;
    switch (statusSelected) {
      case 0:
        if (isLoading) {
          return MissionCardLoadingComponent();
        } else if (taskWaitReviewed.length > 0) {
          return buildMissionAcceptedListView(taskWaitReviewed);
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
        if (isLoading) {
          return MissionCardLoadingComponent();
        } else if (taskFailed.length > 0) {
          return buildMissionAcceptedListView(taskFailed);
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
        if (isLoading) {
          return MissionCardLoadingComponent();
        } else if (taskPassed.length > 0) {
          return buildMissionAcceptedListView(taskPassed);
        } else {
          return SizedBox(
            height: screenHeight - 200,
            width: double.infinity,
            child: Center(
              child: SvgPicture.asset("assets/mission/statusNullHandle.svg"),
            ),
          );
        }
      case 3:
        if (isLoading) {
          return MissionCardLoadingComponent();
        } else if (taskCompleted.length > 0) {
          return buildMissionAcceptedListView(taskCompleted);
        } else {
          return SizedBox(
            height: screenHeight - 200,
            width: double.infinity,
            child: Center(
              child: SvgPicture.asset("assets/mission/statusNullHandle.svg"),
            ),
          );
        }
      case 4:
        if (isLoading) {
          return MissionCardLoadingComponent();
        } else if (taskWaitReturned.length > 0) {
          return buildMissionAcceptedListView(taskWaitReturned);
        } else {
          return SizedBox(
            height: screenHeight - 200,
            width: double.infinity,
            child: Center(
              child: SvgPicture.asset("assets/mission/statusNullHandle.svg"),
            ),
          );
        }
      case 5:
        if (isLoading) {
          return MissionCardLoadingComponent();
        } else if (taskReturned.length > 0) {
          return buildMissionAcceptedListView(taskReturned);
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: kTransparent,
        body: RefreshIndicator(
          onRefresh: _refresh,
          color: kMainYellowColor,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ThirdStatusSelectionComponent(
                    statusList: const [
                      '待审核',
                      '未通过',
                      '已通过',
                      '已完成',
                      '待退款',
                      '已退款'
                    ],
                    selectedIndex: statusSelected,
                    onTap: (index) {
                      setState(() {
                        statusSelected = index;
                      });
                    }),
                buildListView(),
              ],
            ),
          ),
        ));
  }
}
