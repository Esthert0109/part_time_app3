import 'package:flutter/material.dart';
import 'package:part_time_app/Services/collection/collectionServices.dart';
import '../../Components/Card/missionCardComponent.dart';
import '../../Components/Loading/missionCardLoading.dart';
import '../../Constants/colorConstant.dart';
import '../../Model/Task/missionMockClass.dart';

bool dataFetchedCollect = false;
bool dataEndCollect = false;
bool noInitialRefresh = true;

class CollectPage extends StatefulWidget {
  const CollectPage({super.key});

  @override
  State<CollectPage> createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController = ScrollController();
  List<TaskClass> missionCollection = [];
  int page = 1;
  bool isLoading = false;
  bool continueLoading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
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
    return Container(
        child: RefreshIndicator(
      onRefresh: _refresh,
      color: kMainYellowColor,
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.only(
          bottom: 10,
        ),
        child: buildListView(),
      ),
    ));
  }

  Widget buildListView() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: missionCollection.length + (continueLoading ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index == missionCollection.length) {
          return MissionCardLoadingComponent();
        } else {
          return MissionCardComponent(
            missionTitle: missionCollection[index].taskTitle ?? "",
            missionDesc: missionCollection[index].taskContent ?? "",
            tagList: missionCollection[index]
                    .taskTagNames
                    ?.map((tag) => tag.tagName)
                    .toList() ??
                [],
            missionPrice: missionCollection[index].taskSinglePrice ?? 0.0,
            userAvatar: missionCollection[index].avatar ?? "",
            username: missionCollection[index].username ?? "",
            missionDate: missionCollection[index].taskUpdatedTime,
            isFavorite: true,
          );
        }
      },
    );
  }
}
