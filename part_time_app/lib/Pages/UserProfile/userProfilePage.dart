import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Services/User/userServices.dart';
import 'package:part_time_app/Services/collection/collectionServices.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';
import 'package:tencent_cloud_chat_uikit/tencent_cloud_chat_uikit.dart';

import '../../Components/Card/missionCardComponent.dart';
import '../../Components/Loading/missionCardLoading.dart';
import '../../Components/Loading/userProfilePageLoading.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/Task/missionClass.dart';
import '../../Model/User/userModel.dart';
import '../../Services/Chat/chatServices.dart';
import '../Explore/collectPage.dart';
import '../Message/user/chat.dart';
import '../MissionIssuer/missionDetailStatusIssuerPage.dart';
import '../MissionRecipient/missionDetailRecipientPage.dart';
import 'ticketSubmissionPage.dart';

List<OrderData>? taskPublished = [];
List<TaskClass>? taskCollected = [];

class UserProfilePage extends StatefulWidget {
  final bool isOthers;
  final String? userID;

  const UserProfilePage({super.key, required this.isOthers, this.userID});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool isAutho = true;
  bool isPrivate = false;
  int selectedIndex = 0;
  int noPublish = 0;
  int noCollect = 0;

  int currentPage = 1;
  int itemsPerPage = 10;
  bool isLoading = false;
  bool isTaskLoading = false;
  bool isContinueLoading = true;
  ScrollController _scrollController = ScrollController();
  UserData? userDetails;

  // service
  UserServices services = UserServices();
  CollectionService collectionService = CollectionService();
  int page = 1;

  void _handleOnConvItemTaped(
      V2TimConversation? selectedConv, String peopleToChatId) async {
    ChatService().sendMessage(peopleToChatId);
    // ChatService().sendImageMessage();
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Chat(
            selectedConversation: selectedConv!,
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    fetchUserHomePageData();
    fetchData();
  }

  fetchUserHomePageData() async {
    setState(() {
      isLoading = true;
    });

    UserData? user = await services.getCustomerHomePage(widget.userID!);
    int? noTask = await services.getCustomerTaskTotalCount(widget.userID!);
    int? noCollection =
        await services.getCustomerCollectionCount(widget.userID!);

    setState(() {
      userDetails = user;
      if (userDetails!.validIdentity == 0) {
        isAutho = false;
      }
      noPublish = noTask ?? 0;
      noCollect = noCollection ?? 0;

      isLoading = false;
    });
  }

  fetchData() async {
    setState(() {
      isTaskLoading = true;
    });

    try {
      OrderModel? model =
          await services.getCustomerHomePageTask(widget.userID!, page);

      List<TaskClass>? collection =
          await collectionService.fetchCollection(page);

      if (model != null && model.data != null && model.data!.isNotEmpty) {
        setState(() {
          if (model.data != []) {
            taskPublished?.addAll(model.data ?? []);
          }
        });
      } else {
        setState(() {
          isContinueLoading = false;
        });
      }
      if (collection != [] && collection.isNotEmpty) {
        setState(() {
          taskCollected?.addAll(collection ?? []);
        });
      } else {
        setState(() {
          isContinueLoading = false;
        });
      }
    } on Exception catch (e) {
      print("check error: $e");
    }

    setState(() {
      isTaskLoading = false;
      page++;
    });
  }

  @override
  void dispose() {
    setState(() {
      taskPublished!.clear();
      taskCollected!.clear();
    });
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();

    super.dispose();
  }

  _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      if (!isLoading && isContinueLoading) {
        fetchData();
      }
    }
  }

  Widget _buildMissionListView(List<OrderData> missionList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: missionList!.length + (isContinueLoading ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index == missionList.length) {
          return const MissionCardLoadingComponent();
        } else {
          return MissionCardComponent(
            taskId: missionList![index].taskId,
            missionTitle: missionList![index].taskTitle!,
            missionDesc: missionList![index].taskContent!,
            tagList: missionList[index]
                    .taskTagNames
                    ?.map((tag) => tag.tagName)
                    .toList() ??
                [],
            missionPrice: missionList[index].taskSinglePrice!,
            userAvatar: missionList[index].avatar!,
            username: missionList[index].nickname!,
            missionDate: missionList[index].taskUpdatedTime,
            isFavorite: missionList![index].collectionValid == 1 ? true : false,
            missionStatus: missionList![index].taskStatus,
            isPublished: true,
            customerId: missionList[index].customerId!,
          );
        }
      },
    );
  }

  Widget buildListViewList() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: taskCollected!.length + (isContinueLoading ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index == taskCollected!.length) {
          return const MissionCardLoadingComponent();
        } else {
          return GestureDetector(
            onTap: () {
              if (userDetails?.customerId == taskCollected![index].customerId) {
                Get.to(
                    () => MissionDetailStatusIssuerPage(
                          taskId: taskCollected![index].taskId!,
                          isPreview: false,
                          isResubmit: false,
                        ),
                    transition: Transition.rightToLeft);
              } else {
                Get.to(
                    () => MissionDetailRecipientPage(
                          taskId: taskCollected![index].taskId,
                        ),
                    transition: Transition.rightToLeft);
              }
            },
            child: MissionCardComponent(
              taskId: taskCollected![index].taskId,
              missionTitle: taskCollected![index].taskTitle ?? "",
              missionDesc: taskCollected![index].taskContent ?? "",
              tagList: taskCollected![index]
                      .taskTagNames
                      ?.map((tag) => tag.tagName)
                      .toList() ??
                  [],
              missionPrice: taskCollected![index].taskSinglePrice ?? 0.0,
              userAvatar: taskCollected![index].avatar ?? "",
              username: taskCollected![index].nickname ?? "",
              missionDate: taskCollected![index].updatedTime,
              isFavorite: true,
              customerId: taskCollected![index].customerId!,
            ),
          );
        }
      },
    );
  }

  Widget buildListView() {
    switch (selectedIndex) {
      case 0:
        return _buildMissionListView(taskPublished!);
      case 1:
        return buildListViewList();
      default:
        return SizedBox(); // return some default widget if selectIndex is not 0
    }
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
        ),
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
          child: SingleChildScrollView(
            controller: _scrollController,
            child: isLoading
                ? UserProfilePageLoading()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: widget.isOthers ? 232 : 186,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: widget.isOthers ? 192 : 146,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: kMainWhiteColor),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left:
                                  (MediaQuery.of(context).size.width) / 2 - 55,
                              child: CircleAvatar(
                                radius: 43,
                                backgroundColor: kSecondGreyColor,
                                backgroundImage: NetworkImage(userDetails
                                        ?.avatar ??
                                    "https://stickershop.line-scdn.net/stickershop/v1/product/22297449/LINEStorePC/main.png?v=1"),
                              ),
                            ),
                            widget.isOthers
                                ? Positioned(
                                    top: 35,
                                    right: 0,
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: GestureDetector(
                                        onTap: () {
                                          print("complain");
                                          Get.to(
                                              () => TicketSubmissionPage(
                                                    reportUserIDInitial:
                                                        userDetails
                                                                ?.customerId ??
                                                            "",
                                                    complainType: 0,
                                                  ),
                                              transition:
                                                  Transition.rightToLeft);
                                        },
                                        child: SvgPicture.asset(
                                          "assets/mission/complaint.svg",
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ))
                                : SizedBox(),
                            Positioned(
                              top: 82,
                              left: 0,
                              right: 0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, top: 12, bottom: 3),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          userDetails?.nickname ?? "金泰亨",
                                          style: dialogText1,
                                        ),
                                        isAutho
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, top: 3),
                                                child: SvgPicture.asset(
                                                  "assets/userProfile/authorized.svg",
                                                  width: 16,
                                                  height: 18,
                                                ))
                                            : SizedBox()
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, bottom: 3),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        RichText(
                                            text: TextSpan(
                                                style: missionIDtextStyle,
                                                children: [
                                              TextSpan(text: "UID: "),
                                              TextSpan(
                                                  text:
                                                      userDetails?.customerId ??
                                                          "")
                                            ])),
                                        GestureDetector(
                                          onTap: () {
                                            print("copied");
                                            Clipboard.setData(ClipboardData(
                                                text: userDetails?.customerId ??
                                                    ""));
                                            Fluttertoast.showToast(
                                                msg: "已复制",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: kMainGreyColor,
                                                textColor: kThirdGreyColor);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 2),
                                            child: SvgPicture.asset(
                                              "assets/mission/copy.svg",
                                              width: 24,
                                              height: 24,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: RichText(
                                        text: TextSpan(
                                            style: missionIDtextStyle,
                                            children: [
                                          TextSpan(text: "所在地: "),
                                          TextSpan(
                                              text:
                                                  userDetails?.country ?? "--")
                                        ])),
                                  ),
                                  widget.isOthers
                                      ? Container(
                                          height: 34,
                                          margin: const EdgeInsets.only(
                                              left: 5, top: 20),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shadowColor: Colors.transparent,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                backgroundColor:
                                                    kMainYellowColor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                elevation: 0),
                                            onPressed: () {
                                              V2TimConversation conversation =
                                                  new V2TimConversation(
                                                      conversationID:
                                                          "c2c_${userDetails?.customerId}",
                                                      type: 1,
                                                      userID:
                                                          "${userDetails?.customerId}",
                                                      showName:
                                                          "${userDetails?.nickname}");
                                              // V2TimConversation conversation = new V2TimConversation(
                                              //     conversationID: "c2c_CS_5", type: 1, userID: "CS_5");
                                              _handleOnConvItemTaped(
                                                  conversation, "2206");
                                            },
                                            child: Text(
                                              "发送私信",
                                              style: splashScreenTextStyle,
                                            ),
                                          ))
                                      : SizedBox()
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      isAutho
                          ? Container(
                              height: 42,
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              padding: const EdgeInsets.all(12),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: kMainWhiteColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = 0;
                                      });
                                    },
                                    child: Text(
                                      "投稿（${noPublish.toString()}）",
                                      style: selectedIndex == 0
                                          ? missionUsernameTextStyle
                                          : missionDetailText2,
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: kDividerColor,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = 1;
                                      });
                                    },
                                    child: Text(
                                      "收藏（${noCollect.toString()}）",
                                      style: selectedIndex == 1
                                          ? missionUsernameTextStyle
                                          : missionDetailText2,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      (selectedIndex == 1 && isAutho)
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      isPrivate ? "仅自己可见" : "所有人可见",
                                      style: missionDetailImgNumTextStyle,
                                    ),
                                    SvgPicture.asset(isPrivate
                                        ? "assets/userProfile/lock.svg"
                                        : "assets/userProfile/unlock.svg")
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(),
                      (selectedIndex == 1 && isPrivate)
                          ? Container(
                              height: 159,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: kMainWhiteColor),
                              alignment: Alignment.center,
                              child: Text(
                                "该用户收藏仅自己可见",
                                style: splashScreenTextStyle,
                              ),
                            )
                          : (selectedIndex == 1 && noCollect == 0)
                              ? Container(
                                  height: 159,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: kMainWhiteColor),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "该用户尚未收藏兼职",
                                    style: splashScreenTextStyle,
                                  ),
                                )
                              : (selectedIndex == 0 &&
                                      noPublish == 0 &&
                                      isAutho)
                                  ? Container(
                                      height: 159,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: kMainWhiteColor),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "该用户尚未发布投稿",
                                        style: splashScreenTextStyle,
                                      ),
                                    )
                                  : isAutho
                                      // ? isTaskLoading
                                      //     ? MissionCardLoadingComponent()
                                      ? buildListView()
                                      : SizedBox()
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
