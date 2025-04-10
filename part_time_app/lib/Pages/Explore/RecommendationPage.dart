import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Loading/missionCardLoading.dart';
import 'package:part_time_app/Constants/globalConstant.dart';
import 'package:part_time_app/Pages/Explore/easyPassPage.dart';
import 'package:part_time_app/Pages/Explore/highCommisionPage.dart';
import 'package:part_time_app/Pages/Explore/newMissionPage.dart';
import 'package:part_time_app/Pages/Explore/shortTimePage.dart';
import '../../Components/Card/categoryCardComponent.dart';
import '../../Components/Card/missionCardComponent.dart';
import '../../Components/Loading/explorePageLoading.dart';
import '../../Components/SearchBar/searchBarComponent.dart';
import '../../Components/Selection/primaryTagSelectionComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Model/Advertisement/advertisementModel.dart';
import '../../Model/Category/categoryModel.dart';
import '../../Model/User/userModel.dart';
import '../../Services/explore/exploreServices.dart';
import '../../Model/Task/missionClass.dart';
import '../../Services/WebSocket/webSocketService.dart';
import '../../Utils/sharedPreferencesUtils.dart';
import '../Message/user/chatConfig.dart';
import '../MissionRecipient/missionDetailRecipientPage.dart';

String? customerIdforWebsocket;

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController = ScrollController();
  int selectIndex = 0;

  int page = 2;
  bool isLoading = false;
  bool continueLoading = true;
  bool isAdsLoading = false;
  String sortType = "";

  List<CategoryListData> exploreCategory = [];
  List<AdvertisementData> advertisement = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // getUserInfo();
    _scrollController.addListener(_scrollListener);
    _loadData();
    adsLoading();
  }

  adsLoading() async {
    if (advertisementList == [] ||
        exploreCategoryList == [] ||
        advertisementList.isEmpty ||
        exploreCategoryList.isEmpty) {
      setState(() {
        isAdsLoading = true;
      });
    } else {
      setState(() {
        isAdsLoading = false;
      });
    }
    webSocketService.addListener(_updateState);
  }

  void _updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  // getUserInfo() async {
  //   UserData? data = await SharedPreferencesUtils.getUserDataInfo();

  //   setState(() {
  //     userData = data!;
  //   });
  //   bool isLoginTencent = await userTencentLogin(data!.customerId!);
  //   bool isChangeNicknameTencent =
  //       await setNickNameTencent(data.customerId!, data.nickname!);
  //   bool isChangeAvatarTencent =
  //       await setAvatarTencent(data.customerId!, data.avatar!);
  // }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 1000) {
      if (!isLoading && continueLoading) {
        if (selectIndex == 0) {
          _loadData();
        } else {
          _loadDataBySort();
        }
      }
    }
  }

  Future<void> _loadData() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    try {
      final List<TaskClass> data = await ExploreService().fetchExplore(page);
      setState(() {
        if (data.isNotEmpty) {
          missionAvailable.addAll(data);
          page++;
        } else {
          continueLoading = false;
        }
        isLoading = false;
      });
    } catch (e) {
      print('Error in exploreData: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _loadDataBySort() async {
    setState(() {
      isLoading = true;
    });

    try {
      final List<TaskClass> data =
          await ExploreService().fetchExploreByPrice(sortType, page);
      setState(() {
        if (data.isNotEmpty) {
          if (sortType == "sort=asc") {
            missionAvailableAsec.addAll(data);
          } else if (sortType == "sort=desc") {
            missionAvailableDesc.addAll(data);
          }
          page++;
        } else {
          continueLoading = false;
        }
        isLoading = false;
      });
    } catch (e) {
      print('Error in exploreData: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));

    if (!isLoading && mounted) {
      setState(() {
        page = 1;
        continueLoading = true;
      });

      if (selectIndex == 0) {
        missionAvailable.clear();
        await _loadData();
      } else {
        missionAvailableAsec.clear();
        missionAvailableDesc.clear();
        await _loadDataBySort();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: RefreshIndicator(
        onRefresh: _refresh,
        color: kMainYellowColor,
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SearchBarComponent(),
              isAdsLoading
                  ? const ExplorePageLoading()
                  : FlutterCarousel(
                      options: CarouselOptions(
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 10),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 1000),
                        height: 132.0,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        showIndicator: false,
                        indicatorMargin: 2,
                        slideIndicator: const CircularSlideIndicator(
                          itemSpacing: 20,
                          currentIndicatorColor:
                              Color.fromARGB(232, 255, 227, 87),
                        ),
                      ),
                      items: advertisementList.map((advertisement) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              height: 132,
                              decoration: BoxDecoration(
                                color: kSecondGreyColor,
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      advertisement.advertisementImage!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
              CategoryItem(
                list: exploreCategoryList,
                onTapCallbacks: [
                  () => const HighCommisionPage(),
                  () => const ShortTimePage(),
                  () => const EasyPassPage(),
                  () => const NewMissionPage(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 110),
                child: PrimaryTagSelectionComponent(
                  tagList: ["全部", "价格降序", "价格升序"],
                  selectedIndex: selectIndex,
                  onTap: (index) {
                    setState(() {
                      selectIndex = index;
                      continueLoading = true;
                      page = 1;
                      isLoading = true;
                      if (selectIndex == 0) {
                        sortType = "";
                        missionAvailable.clear();
                        _loadData();
                      } else if (selectIndex == 1) {
                        sortType = "sort=asc";
                        missionAvailableAsec.clear();
                        _loadDataBySort();
                      } else if (selectIndex == 2) {
                        sortType = "sort=desc";
                        missionAvailableDesc.clear();
                        _loadDataBySort();
                      }
                    });
                  },
                ),
              ),
              buildListView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListView() {
    switch (selectIndex) {
      case 0:
        return _buildMissionListView(missionAvailable);
      case 1:
        return _buildMissionListView(missionAvailableAsec);
      case 2:
        return _buildMissionListView(missionAvailableDesc);
      default:
        return const SizedBox(); // return some default widget if selectIndex is not 0, 1, or 2
    }
  }

  Widget _buildMissionListView(List<TaskClass> missionList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: missionList.length + (continueLoading ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index == missionList.length) {
          return const MissionCardLoadingComponent();
        } else {
          return GestureDetector(
            onTap: () {
              Get.to(
                  () => MissionDetailRecipientPage(
                        taskId: missionList[index].taskId,
                      ),
                  transition: Transition.rightToLeft);
            },
            child: MissionCardComponent(
              taskId: missionList[index].taskId,
              missionTitle: missionList[index].taskTitle ?? "",
              missionDesc: missionList[index].taskContent ?? "",
              tagList: missionList[index]
                      .taskTagNames
                      ?.map((tag) => tag.tagName)
                      .toList() ??
                  [],
              missionPrice: missionList[index].taskSinglePrice ?? 0.0,
              userAvatar: missionList[index].avatar ?? "",
              username: missionList[index].nickname ?? "",
              missionDate: missionList[index].taskUpdatedTime ?? "",
              isFavorite: missionList[index].collectionValid ?? false,
              customerId: missionList[index].customerId!,
            ),
          );
        }
      },
    );
  }
}
