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

  int statusSelected = 0;
  bool isLoading = false;
  bool isContinueLoading = true;
  ScrollController _scrollController = ScrollController();

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
      orderModel = await services.getOrderByStatus(i);
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
        if (isLoading) {
          return MissionCardLoadingComponent();
        } else if (orderIncompleted.length > 0) {
          return buildMissionAcceptedListView(orderIncompleted);
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
        } else if (orderWaitReviewed.length > 0) {
          return buildMissionAcceptedListView(orderWaitReviewed);
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
        } else if (orderFailed.length > 0) {
          return buildMissionAcceptedListView(orderFailed);
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
        } else if (orderWaitPayment.length > 0) {
          return buildMissionAcceptedListView(orderWaitPayment);
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
        } else if (orderPaid.length > 0) {
          return buildMissionAcceptedListView(orderPaid);
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
        physics: const NeverScrollableScrollPhysics(),
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
                username: missionList[index].nickname!,
                isStatus: true,
                isPublished: false,
                missionStatus: missionList[index].orderStatus!,
              ),
              onTap: () {
                Get.to(
                    () => MissionDetailRecipientPage(
                          orderId: missionList[index].orderId,
                        ),
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
