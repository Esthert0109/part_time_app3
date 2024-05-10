import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../Constants/colorConstant.dart';

class CustomRefreshComponent extends StatefulWidget {
  final Function()? onRefresh;
  final Function()? onLoading;
  final RefreshController controller;
  final Widget child;

  const CustomRefreshComponent({
    super.key,
    this.onRefresh,
    this.onLoading,
    required this.controller,
    required this.child,
  });

  @override
  _CustomRefreshComponentState createState() => _CustomRefreshComponentState();
}

class _CustomRefreshComponentState extends State<CustomRefreshComponent> {
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      header: WaterDropHeader(
        refresh: _buildLoadingIndicator(),
        waterDropColor: Colors.transparent,
        complete: Container(),
        completeDuration: Duration(milliseconds: 100),
        idleIcon: Icon(Icons.attach_money, color: Colors.transparent),
      ),
      onRefresh: widget.onRefresh,
      onLoading: widget.onLoading,
      controller: widget.controller,
      child: widget.child,
    );
  }

  Widget _buildLoadingIndicator() {
    return LoadingAnimationWidget.stretchedDots(
        color: kMainYellowColor, size: 50);
  }
}
