import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:part_time_app/Components/Loading/customRefreshComponent.dart';
import 'package:part_time_app/Components/Loading/missionCardLoading.dart';
import 'package:part_time_app/Components/Selection/thirdStatusSelectionComponent.dart';
import 'package:part_time_app/Pages/MissionRecipient/missionDetailRecipientPage.dart';
import 'package:part_time_app/Pages/MockData/missionMockData.dart';

import '../../Components/Card/missionCardComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/globalConstant.dart';
import '../../Services/order/orderServices.dart';
import '../MissionIssuer/missionDetailStatusIssuerPage.dart';
import '../../Model/Task/missionClass.dart';

bool dataFetchedAccepted = false;
bool dataEndAccepted = false;
bool noInitialRefresh = true;

class MissionAcceptedMainPage extends StatefulWidget {
  const MissionAcceptedMainPage({super.key});

  @override
  State<MissionAcceptedMainPage> createState() =>
      _MissionAcceptedMainPageState();
}

class _MissionAcceptedMainPageState extends State<MissionAcceptedMainPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // RefreshController _refreshController =
  //     RefreshController(initialRefresh: noInitialRefresh);
  int statusSelected = 0;
  bool isLoading = false;
  bool isContinueLoading = true;
  // bool isFirstLaunch = true;
  // bool reachEndOfList = false;
  // int currentPage = 1;
  // int itemsPerPage = 5;
  ScrollController _scrollController = ScrollController();

  //set status on mission detail recipient page
  bool isStarted = false;
  bool isSubmitted = false;
  bool isExpired = false;
  bool isWaitingPaid = false;
  bool isPaid = false;
  bool isFailed = false;

  // services
  OrderServices services = OrderServices();
  OrderModel? orderModel;

  @override
  void initState() {
    super.initState();
    orderPage = 1;
    _scrollController.addListener(_scrollListener);
    fetchData();
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

    for (int i = 0; i < 9; i++) {
      orderModel = await services.GetOrderByStatus(i);
      if (orderModel != null &&
          orderModel!.data != null &&
          orderModel!.data!.isNotEmpty) {
        setState(() {
          if (i == 0) {
            if (orderModel!.data != []) {
              orderWaitReviewed.addAll(orderModel?.data ?? []);
            } else {
              setState(() {
                isContinueLoading = false;
              });
            }
          } else if (i == 1) {
            if (orderModel!.data != []) {
              orderIncompleted.addAll(orderModel?.data ?? []);
            } else {
              setState(() {
                isContinueLoading = false;
              });
            }
          } else if (i == 2) {
            if (orderModel!.data != []) {
              orderFailed.addAll(orderModel?.data ?? []);
            } else {
              setState(() {
                isContinueLoading = false;
              });
            }
          } else if (i == 7) {
            if (orderModel!.data != []) {
              orderWaitPayment.addAll(orderModel?.data ?? []);
            } else {
              setState(() {
                isContinueLoading = false;
              });
            }
          } else if (i == 8) {
            if (orderModel!.data != []) {
              orderPaid.addAll(orderModel?.data ?? []);
            } else {
              setState(() {
                isContinueLoading = false;
              });
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
      orderPage++;
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
        orderPage = 1;
        isContinueLoading = true;
        orderIncompleted.clear();
        orderWaitReviewed.clear();
        orderFailed.clear();
        orderWaitPayment.clear();
        orderPaid.clear();
      });
      await fetchData();
    }
  }

  Widget buildListView() {
    double screenHeight = MediaQuery.of(context).size.height;

    switch (statusSelected) {
      case 0:
        isStarted = true;
        isSubmitted = false;
        isExpired = false;
        isWaitingPaid = false;
        isPaid = false;
        isFailed = false;
        if (orderIncompleted.length > 0) {
          return SizedBox(
              height: screenHeight - 200,
              child: buildMissionAcceptedListView(orderIncompleted));
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
        isStarted = false;
        isSubmitted = true;
        isExpired = false;
        isWaitingPaid = false;
        isPaid = false;
        isFailed = false;
        if (orderWaitReviewed.length > 0) {
          return SizedBox(
              height: screenHeight - 200,
              child: buildMissionAcceptedListView(orderWaitReviewed));
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
        isStarted = false;
        isSubmitted = false;
        isExpired = false;
        isWaitingPaid = false;
        isPaid = false;
        isFailed = true;
        if (orderFailed.length > 0) {
          return SizedBox(
              height: screenHeight - 200,
              child: buildMissionAcceptedListView(orderFailed));
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
        isStarted = false;
        isSubmitted = false;
        isExpired = false;
        isWaitingPaid = true;
        isPaid = false;
        isFailed = false;
        if (orderWaitPayment.length > 0) {
          return SizedBox(
              height: screenHeight - 200,
              child: buildMissionAcceptedListView(orderWaitPayment));
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
        isStarted = false;
        isSubmitted = false;
        isExpired = false;
        isWaitingPaid = false;
        isPaid = true;
        isFailed = false;
        if (orderPaid.length > 0) {
          return SizedBox(
              height: screenHeight - 200,
              child: buildMissionAcceptedListView(orderPaid));
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

  Widget buildMissionAcceptedListView(List<OrderData> missionList) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: missionList.length + (isContinueLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == missionList.length) {
            return MissionCardLoadingComponent();
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
                missionPrice: missionList[index].orderSinglePrice!,
                userAvatar: missionList[index].avatar!,
                missionDate: missionList[index].taskUpdatedTime,
                username: missionList[index].username!,
                isStatus: true,
                missionStatus: missionList[index].orderStatus,
              ),
              onTap: () {
                Get.to(
                    () => MissionDetailRecipientPage(
                        isStarted: isStarted,
                        isSubmitted: isSubmitted,
                        isExpired: isExpired,
                        isWaitingPaid: isWaitingPaid,
                        isFailed: isFailed,
                        isPaid: isPaid),
                    transition: Transition.rightToLeft);
              },
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: kTransparent,
      body: RefreshIndicator(
        onRefresh: _refresh,
        color: kMainYellowColor,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ThirdStatusSelectionComponent(
                        statusList: const ['待完成', '待审核', '未通过', '待到账', '已到账'],
                        selectedIndex: statusSelected,
                        onTap: (index) {
                          setState(() {
                            statusSelected = index;
                            // fetchData();
                          });
                        }),
                    buildListView()
                  ],
                ));
          },
        ),
      ),
    );
  }
}
