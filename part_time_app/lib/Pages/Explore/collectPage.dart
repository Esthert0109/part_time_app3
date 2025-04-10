import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Services/collection/collectionServices.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';
import '../../Components/Card/missionCardComponent.dart';
import '../../Components/Loading/missionCardLoading.dart';
import '../../Constants/colorConstant.dart';
import '../../Model/Task/missionClass.dart';
import '../../Model/User/userModel.dart';
import '../MissionIssuer/missionDetailStatusIssuerPage.dart';
import '../MissionRecipient/missionDetailRecipientPage.dart';

List<TaskClass> missionCollection = [];

class CollectPage extends StatefulWidget {
  const CollectPage({super.key});

  @override
  State<CollectPage> createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController = ScrollController();

  int page = 1;
  bool isLoading = false;
  bool continueLoading = true;
  bool isEmpty = false;
  @override
  bool get wantKeepAlive => true;

  String userId = "";

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    getUserDetails();
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    missionCollection.clear();
    super.dispose();
  }

  getUserDetails() async {
    UserData? userData = await SharedPreferencesUtils.getUserDataInfo();
    setState(() {
      userId = userData?.customerId ?? "";
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      if (!isLoading && continueLoading) {
        _loadData();
      }
    }
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final List<TaskClass> data =
          await CollectionService().fetchCollection(page);
      setState(() {
        if (data.isNotEmpty) {
          missionCollection.addAll(data);
          page++;
        } else {
          continueLoading = false;
        }
        if (missionCollection.isEmpty) {
          isEmpty = true;
        }
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
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
        missionCollection.clear();
        page = 1;
        continueLoading = true;
        _loadData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: _refresh,
        color: kMainYellowColor,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.only(bottom: 10),
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: missionCollection.isNotEmpty
                    ? buildListView()
                    : isEmpty == false
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              // Set the desired height for the loading component
                              child: MissionCardLoadingComponent(),
                            ),
                          )
                        : Container(
                            height: constraints.maxHeight,
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/common/searchEmpty.svg",
                                width: 150,
                                height: 150,
                              ),
                            ),
                          ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: missionCollection.length + (continueLoading ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index == missionCollection.length) {
          return isLoading ? const MissionCardLoadingComponent() : Container();
        } else {
          return GestureDetector(
            onTap: () {
              if (userId == missionCollection[index].customerId) {
                Get.to(
                    () => MissionDetailStatusIssuerPage(
                          taskId: missionCollection[index].taskId!,
                          isPreview: false,
                          isResubmit: false,
                        ),
                    transition: Transition.rightToLeft);
              } else {
                Get.to(
                    () => MissionDetailRecipientPage(
                          taskId: missionCollection[index].taskId,
                        ),
                    transition: Transition.rightToLeft);
              }
            },
            child: MissionCardComponent(
              taskId: missionCollection[index].taskId,
              missionTitle: missionCollection[index].taskTitle ?? "",
              missionDesc: missionCollection[index].taskContent ?? "",
              tagList: missionCollection[index]
                      .taskTagNames
                      ?.map((tag) => tag.tagName)
                      .toList() ??
                  [],
              missionPrice: missionCollection[index].taskSinglePrice ?? 0.0,
              userAvatar: missionCollection[index].avatar ?? "",
              username: missionCollection[index].nickname ?? "",
              missionDate: missionCollection[index].updatedTime,
              isFavorite: true,
              customerId: missionCollection[index].customerId!,
            ),
          );
        }
      },
    );
  }
}
