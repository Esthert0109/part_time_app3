import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Pages/MockData/missionMockData.dart';

import '../../Components/Card/missionCardComponent.dart';
import '../../Components/Loading/missionCardLoading.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/Task/missionMockClass.dart';

bool dataFetchedPublish = false;
bool dataEndPublish = false;
List<MissionMockClass>? missionPublished = [];
List<MissionMockClass>? missionCollected = [];

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
  int noPublish = 10;
  int noCollect = 0;

  int currentPage = 1;
  int itemsPerPage = 10;
  bool isLoading = false;
  bool isFirstLaunch = true;
  bool reachEndOfList = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (!dataFetchedPublish && !dataEndPublish) {
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
    if (!isLoading && !reachEndOfList && !dataEndPublish) {
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
          missionPublished = filteredList.sublist(
              start, end > filteredList.length ? filteredList.length : end);
          isFirstLaunch = false;
        } else {
          missionPublished!.addAll(filteredList.sublist(
              start, end > filteredList.length ? filteredList.length : end));
        }

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
          dataEndPublish = true;
          isLoading = false;
        });
      }
      dataFetchedPublish = true;
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

  Widget _buildMissionListView(List<MissionMockClass> missionList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: missionList!.length + (isLoading ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index < missionList!.length) {
          return MissionCardComponent(
            missionTitle: missionList![index].missionTitle,
            missionDesc: missionList![index].missionDesc,
            tagList: missionList![index].tagList ?? [],
            missionPrice: missionList![index].missionPrice,
            userAvatar: missionList![index].userAvatar,
            username: missionList![index].username,
            missionDate: missionList![index].missionDate,
            isStatus: missionList![index].isStatus,
            isFavorite: missionList![index].isFavorite,
            missionStatus: missionList![index].missionStatus,
          );
        } else {
          return MissionCardLoadingComponent();
        }
      },
    );
  }

  Widget buildListView() {
    switch (selectedIndex) {
      case 0:
        return _buildMissionListView(missionPublished!);
      case 1:
        return _buildMissionListView(missionPublished!);
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
            child: Column(
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
                        left: (MediaQuery.of(context).size.width) / 2 - 55,
                        child: CircleAvatar(
                          radius: 43,
                          backgroundColor: kSecondGreyColor,
                          backgroundImage: NetworkImage(
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "金泰亨",
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
                                          ),
                                        )
                                      : SizedBox()
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RichText(
                                      text: TextSpan(
                                          style: missionIDtextStyle,
                                          children: [
                                        TextSpan(text: "UID: "),
                                        TextSpan(text: "34693426720")
                                      ])),
                                  GestureDetector(
                                    onTap: () {
                                      print("copied");
                                      Clipboard.setData(const ClipboardData(
                                          text: "34693426720"));
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
                                    TextSpan(text: "中国")
                                  ])),
                            ),
                            widget.isOthers
                                ? Container(
                                    height: 34,
                                    margin:
                                        const EdgeInsets.only(left: 5, top: 20),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shadowColor: Colors.transparent,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          backgroundColor: kMainYellowColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          elevation: 0),
                                      onPressed: () {},
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        : (selectedIndex == 0 && noPublish == 0)
                            ? Container(
                                height: 159,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: kMainWhiteColor),
                                alignment: Alignment.center,
                                child: Text(
                                  "该用户尚未发布投稿",
                                  style: splashScreenTextStyle,
                                ),
                              )
                            : isAutho
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
