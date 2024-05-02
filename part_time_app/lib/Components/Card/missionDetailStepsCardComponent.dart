import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../Model/MockModel/missionStepMockModel.dart';

class missionDetailStepsCardComponent extends StatefulWidget {
  final bool isConfidential;
  final bool isCollapsed;
  final bool isCollapseAble;
  final List<MissionStepMockModel> steps;

  missionDetailStepsCardComponent({
    Key? key,
    required this.steps,
    required this.isConfidential,
    required this.isCollapsed,
    required this.isCollapseAble,
  }) : super(key: key);

  @override
  State<missionDetailStepsCardComponent> createState() =>
      _missionDetailStepsCardComponentState();
}

class _missionDetailStepsCardComponentState
    extends State<missionDetailStepsCardComponent> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? selectedImageList = [];
  int imageSelected = 0;
  PageController pageController = PageController();

  showZoomImage(BuildContext context, int index) {
    pageController = PageController(initialPage: index);
    showDialog(
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Material(
              type: MaterialType.transparency,
              child: Stack(
                children: [
                  Container(
                    constraints: const BoxConstraints.expand(),
                    child: Column(
                      children: [
                        Expanded(
                            child: PhotoViewGallery.builder(
                                enableRotation: true,
                                pageController: pageController,
                                backgroundDecoration:
                                    const BoxDecoration(color: kTransparent),
                                itemCount:
                                    widget.steps[index].stepPicList?.length ??
                                        0,
                                loadingBuilder: (context, event) {
                                  if (event == null) {}
                                  return Center(
                                      child:
                                          LoadingAnimationWidget.stretchedDots(
                                              color: kMainYellowColor,
                                              size: 50));
                                },
                                builder: (context, i) {
                                  return PhotoViewGalleryPageOptions(
                                      imageProvider: NetworkImage(
                                          widget.steps[index].stepPicList?[i] ??
                                              ""),
                                      initialScale:
                                          PhotoViewComputedScale.contained *
                                              0.85,
                                      heroAttributes: PhotoViewHeroAttributes(
                                          tag: widget.steps[index]
                                                  .stepPicList?[i] ??
                                              ""));
                                }))
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: kMainWhiteColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      color: kMainWhiteColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          enabled: widget.isCollapseAble,
          initiallyExpanded: widget.isCollapsed,
          title: Text(
            "操作步骤预览",
            style: const TextStyle(
                color: kMainBlackColor,
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                      widget.steps.length,
                      (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: kMainYellowColor,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Text(
                                        '${index + 1}',
                                        style: missionDetailStepsNumTextStyle,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        widget.steps[index].stepDesc,
                                        style: missionDetailStepsDescTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 12, 0, 6),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(
                                          widget.steps[index].stepPicList
                                                  ?.length ??
                                              0,
                                          (i) => GestureDetector(
                                                onTap: () {
                                                  widget.isConfidential
                                                      ? null
                                                      : showZoomImage(
                                                          context, i);
                                                },
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      width: 157,
                                                      margin: const EdgeInsets
                                                          .fromLTRB(0, 6, 6, 0),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          color:
                                                              kThirdGreyColor),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        child: Image.network(
                                                          widget.steps[index]
                                                                      .stepPicList?[
                                                                  i] ??
                                                              "",
                                                          fit: BoxFit.cover,
                                                          loadingBuilder: (context,
                                                              child,
                                                              loadingProgress) {
                                                            if (loadingProgress ==
                                                                null) {
                                                              return child;
                                                            }
                                                            return Center(
                                                                child: LoadingAnimationWidget
                                                                    .stretchedDots(
                                                                        color:
                                                                            kMainYellowColor,
                                                                        size:
                                                                            50));
                                                          },
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return Center(
                                                              child: Text(
                                                                "无法显示图片",
                                                                style:
                                                                    submissionPicErrorTextStyle,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    widget.isConfidential
                                                        ? Positioned(
                                                            bottom: 0,
                                                            child: Container(
                                                                height: 100,
                                                                width: 157,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration: BoxDecoration(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            51,
                                                                            51,
                                                                            51,
                                                                            0.8),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4)),
                                                                child: SvgPicture
                                                                    .asset(
                                                                        "assets/mission/noPreview.svg")))
                                                        : Container()
                                                  ],
                                                ),
                                              )),
                                    ),
                                  ),
                                ),
                                Text(
                                  "图片数量 (${widget.steps[index].stepPicList?.length ?? 0})",
                                  style: missionNoticeGreyTextStyle,
                                )
                              ],
                            ),
                          ))),
            ),
          ],
        ),
      ),
    );
  }
}
