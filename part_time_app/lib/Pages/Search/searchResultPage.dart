import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Model/User/userModel.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';
import '../../Components/Card/missionCardComponent.dart';
import '../../Components/Loading/missionCardLoading.dart';
import '../../Components/Selection/primaryTagSelectionComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/Task/missionClass.dart';
import '../../Services/explore/exploreServices.dart';
import '../MissionIssuer/missionDetailStatusIssuerPage.dart';
import '../MissionRecipient/missionDetailRecipientPage.dart';

class SearchResultPage extends StatefulWidget {
  final String? searchKeyword;
  final List<int>? selectedTags;
  final List<String>? selectedTagsName;
  bool byTag;

  SearchResultPage({
    super.key,
    this.searchKeyword,
    this.selectedTags,
    this.selectedTagsName,
    required this.byTag,
  });

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  late String keyword;
  ScrollController _scrollController = ScrollController();
  List<TaskClass> missionSearch = [];
  List<TaskClass> missionSearchDesc = [];
  dynamic tag = '';
  dynamic tagName = '';
  int selectIndex = 0;
  int page = 1;
  bool isLoading = false;
  bool continueLoading = true;
  String sortType = "";
  bool isEmpty = false;
  int totalResult = 0;
  late bool bytag;
  UserData? userDetails;

  String listToCommaSeparatedString(List<int>? list) {
    return list?.join(',') ?? '';
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();

    keyword = widget.searchKeyword ?? '';
    tag = listToCommaSeparatedString(widget.selectedTags);
    tagName = widget.selectedTagsName;
    bytag = widget.byTag;
    _scrollController.addListener(_scrollListener);
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  fetchUserData() async {
    userDetails = await SharedPreferencesUtils.getUserDataInfo();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      if (!isLoading && continueLoading) {
        if (selectIndex == 0) {
          _loadData();
        } else {
          // _loadDataBySort();
        }
      }
    }
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      SearchResult data;
      if (bytag == true) {
        data = await ExploreService().fetchSearchByTag(sortType, tag, page);
      } else {
        data =
            await ExploreService().fetchSearchResult(keyword, sortType, page);
      }

      setState(() {
        if (data.tasks.isNotEmpty) {
          missionSearch.addAll(data.tasks);
          page++;
          totalResult = data.totalAmountOfData;
        } else {
          continueLoading = false;
        }
        if (data.totalAmountOfData == 0) {
          isEmpty = true;
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
    await Future.delayed(Duration(seconds: 1));
    if (!isLoading && mounted) {
      setState(() {
        page = 1;
        continueLoading = true;
      });

      if (selectIndex == 0) {
        missionSearch.clear();
        await _loadData();
      } else {
        // missionAvailableAsec.clear();
        // missionAvailableDesc.clear();
        // await _loadDataBySort();
      }
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
              color: kThirdGreyColor,
            ),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    scrolledUnderElevation: 0.0,
                    surfaceTintColor: Colors.transparent,
                    title: const Text(
                      "搜索结果",
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
                      padding: EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.byTag
                              ? Wrap(
                                  children: List.generate(
                                    (tagName as List<String>).length,
                                    (index) => RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '#',
                                            style: missionTagTextStyle,
                                          ),
                                          TextSpan(
                                            text: ' ${tagName[index]} ',
                                            style: dialogText1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Text(
                                  "“ ${widget.searchKeyword} ”",
                                  textAlign: TextAlign.end,
                                  style: dialogText1,
                                ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                flex: 11,
                                // padding: EdgeInsets.only(top: 20, right: 180),
                                child: PrimaryTagSelectionComponent(
                                  tagList: ["价格降序", "价格升序"],
                                  selectedIndex: selectIndex,
                                  onTap: (index) {
                                    setState(() {
                                      selectIndex = index;
                                      continueLoading = true;
                                      page = 1;
                                      isLoading = true;
                                      if (selectIndex == 0) {
                                        sortType = "asc";
                                        missionSearch.clear();
                                        _loadData();
                                      } else if (selectIndex == 1) {
                                        sortType = "desc";
                                        missionSearch.clear();
                                        _loadData();
                                      }
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                  flex: 2, child: Text("${totalResult}条相关"))
                            ],
                          ),
                          SizedBox(height: 10),
                          missionSearch.isNotEmpty
                              ? buildListView()
                              : isEmpty == false
                                  ? MissionCardLoadingComponent()
                                  : Container(
                                      height: 630,
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/common/searchEmpty.svg",
                                          width: 150,
                                          height: 150,
                                        ),
                                      ),
                                    ),
                        ],
                      )),
                ],
              ),
            )),
      ),
    );
  }

  Widget buildListView() {
    switch (selectIndex) {
      case 0:
        return _buildMissionListView(missionSearch);
      case 1:
        return _buildMissionListView(missionSearch);
      default:
        return SizedBox(); // return some default widget if selectIndex is not 0, 1, or 2
    }
  }

  Widget _buildMissionListView(List<TaskClass> missionList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: missionList.length + (continueLoading ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index == missionList.length) {
          return isLoading ? const MissionCardLoadingComponent() : Container();
        } else {
          return GestureDetector(
            onTap: () {
              if (userDetails!.customerId == missionList[index].customerId) {
                Get.to(
                    () => MissionDetailStatusIssuerPage(
                          taskId: missionList[index].taskId!,
                          isPreview: false,
                          isResubmit: false,
                        ),
                    transition: Transition.rightToLeft);
              } else {
                Get.to(
                    () => MissionDetailRecipientPage(
                          taskId: missionList[index].taskId!,
                        ),
                    transition: Transition.rightToLeft);
              }
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
