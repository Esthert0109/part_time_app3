import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../Components/Card/missionCardComponent.dart';
import '../../Components/Loading/missionCardLoading.dart';
import '../../Model/Task/missionClass.dart';
import '../MockData/missionMockData.dart';

bool dataFetchedCollectTest = false;
List<MissionMockClass>? missionAvailableForCollectTest = [];

class CollectPageTest extends StatefulWidget {
  const CollectPageTest({super.key});

  @override
  State<CollectPageTest> createState() => _CollectPageTestState();
}

class _CollectPageTestState extends State<CollectPageTest> {
  final PagingController<int, MissionMockClass> _pagingController =
      PagingController(firstPageKey: 1);
  int itemsPerPage = 10;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      if (isLoading) return;
      isLoading = true;
      // Simulate fetching data
      await Future.delayed(Duration(seconds: 2));
      missionAvailableForCollectTest = MissionAvailableList.toList();
      final isLastPage =
          missionAvailableForCollectTest!.length < (pageKey * itemsPerPage);
      if (isLastPage) {
        _pagingController.appendLastPage(missionAvailableForCollectTest!);
      } else {
        final nextPageKey = pageKey + 1;
        final nextPage = missionAvailableForCollectTest!.sublist(
            (pageKey - 1) * itemsPerPage,
            (pageKey * itemsPerPage) > missionAvailableForCollectTest!.length
                ? missionAvailableForCollectTest!.length
                : (pageKey * itemsPerPage));
        _pagingController.appendPage(nextPage, nextPageKey);
      }
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<void> _refresh() async {
    _pagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: _refresh,
        child: PagedListView<int, MissionMockClass>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<MissionMockClass>(
            itemBuilder: (context, item, index) => MissionCardComponent(
              missionTitle: item.missionTitle,
              missionDesc: item.missionDesc,
              tagList: item.tagList ?? [],
              missionPrice: item.missionPrice,
              userAvatar: item.userAvatar,
              username: item.username,
              missionDate: item.missionDate,
              isStatus: item.isStatus,
              isFavorite: item.isFavorite,
              missionStatus: item.missionStatus, customerId: "",
            ),
            firstPageProgressIndicatorBuilder: (_) =>
                MissionCardLoadingComponent(),
            newPageProgressIndicatorBuilder: (_) =>
                MissionCardLoadingComponent(),
          ),
        ),
      ),
    );
  }
}
