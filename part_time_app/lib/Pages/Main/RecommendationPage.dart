import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:part_time_app/Components/Loading/missionCardLoading.dart';
import '../../Components/Card/missionCardComponent.dart';
import '../../Components/SearchBar/searchBarComponent.dart';
import '../../Components/Selection/primaryTagSelectionComponent.dart';
import '../../Constants/textStyleConstant.dart';
import '../MockData/missionMockClass.dart';
import '../MockData/missionMockData.dart';

bool dataFetchedExplore = false;
bool dataEndExplore = false;
List<MissionMockClass>? missionAvailable = [];

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  int selectIndex = 0;
  List<MissionMockClass>? missionAvailableAsec = [];
  List<MissionMockClass>? missionAvailableDesc = [];
  int currentPage = 1;
  int itemsPerPage = 10;
  bool isLoading = false;
  bool isFirstLaunch = true;
  bool reachEndOfList = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (!dataFetchedExplore && !dataEndExplore) {
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
    if (!isLoading && !reachEndOfList && !dataEndExplore) {
      setState(() {
        isLoading = true;
      });
      // Simulate fetching data
      await Future.delayed(Duration(seconds: 2));
      int start = (currentPage - 1) * itemsPerPage;
      int end = start + itemsPerPage;
      if (MissionAvailableList.length > start) {
        if (isFirstLaunch) {
          missionAvailable = MissionAvailableList.sublist(
              start,
              end > MissionAvailableList.length
                  ? MissionAvailableList.length
                  : end);
          isFirstLaunch = false;
        } else {
          missionAvailable!.addAll(MissionAvailableList.sublist(
              start,
              end > MissionAvailableList.length
                  ? MissionAvailableList.length
                  : end));
        }

        // Sort the missionAvailable list
        _sortMissionAvailable();
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
          dataEndExplore = true;
          isLoading = false;
        });
      }
      dataFetchedExplore = true;
    }
  }

  void _sortMissionAvailable() {
    //control time
    missionAvailable!.sort((a, b) => b.missionDate!.compareTo(a.missionDate!));
    missionAvailableAsec = List.from(missionAvailable!)
      ..sort((a, b) => a.missionPrice.compareTo(b.missionPrice));
    missionAvailableDesc = List.from(missionAvailable!)
      ..sort((a, b) => b.missionPrice.compareTo(a.missionPrice));
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
        missionAvailable = [];
        missionAvailableAsec = [];
        missionAvailableDesc = [];
        reachEndOfList = false;
        dataEndExplore = true;
      });
      await _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _loadData();
          }
          return true;
        },
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SearchBarComponent(),
                Image.asset("assets/main/banner.png"),
                _buildCategoryComponent(),
                Padding(
                  padding: EdgeInsets.only(top: 20, right: 120),
                  child: PrimaryTagSelectionComponent(
                    tagList: ["全部", "价格降序", "价格升序"],
                    selectedIndex: selectIndex,
                    onTap: (index) {
                      setState(() {
                        selectIndex = index;
                        _loadData();
                      });
                    },
                  ),
                ),
                buildListView()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildListView() {
    switch (selectIndex) {
      case 0:
        return _buildMissionListView(missionAvailable!);
      case 1:
        return _buildMissionListView(missionAvailableAsec!);
      case 2:
        return _buildMissionListView(missionAvailableDesc!);
      default:
        return SizedBox(); // return some default widget if selectIndex is not 0
    }
  }

  Widget _buildMissionListView(List<MissionMockClass> missionList) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: missionList.length + (isLoading ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index < missionList.length) {
          return MissionCardComponent(
            missionTitle: missionList[index].missionTitle,
            missionDesc: missionList[index].missionDesc,
            tagList: missionList[index].tagList ?? [],
            missionPrice: missionList[index].missionPrice,
            userAvatar: missionList[index].userAvatar,
            username: missionList[index].username,
            missionDate: missionList[index].missionDate,
            isStatus: missionList[index].isStatus,
            isFavorite: missionList[index].isFavorite,
            missionStatus: missionList[index].missionStatus,
          );
        } else {
          return MissionCardLoadingComponent();
        }
      },
    );
  }
}

Widget _buildCategoryComponent() {
  return Container(
    padding: EdgeInsets.only(top: 25),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: GestureDetector(
            child: Column(
              children: [
                SvgPicture.asset("assets/main/hightCom.svg"),
                SizedBox(height: 10),
                Text("高赏金", style: messageText1),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: GestureDetector(
            child: Column(
              children: [
                SvgPicture.asset("assets/main/shortTime.svg"),
                SizedBox(height: 10),
                Text("用时短", style: messageText1),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: GestureDetector(
            child: Column(
              children: [
                SvgPicture.asset("assets/main/easyGo.svg"),
                SizedBox(height: 10),
                Text("易审核", style: messageText1),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: GestureDetector(
            child: Column(
              children: [
                SvgPicture.asset("assets/main/newMission.svg"),
                SizedBox(height: 10),
                Text("新悬赏", style: messageText1),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
