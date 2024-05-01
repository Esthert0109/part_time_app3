import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class missionDetailStepsCardComponent extends StatefulWidget {
  final String stepTitle;
  final List<String> stepDesc;
  List<String>? stepPic;
  // final String stepPicAmount;
  final bool isConfidential;
  missionDetailStepsCardComponent({
    Key? key,
    required this.stepTitle,
    required this.stepDesc,
    this.stepPic,
    // required this.stepPicAmount,
    required this.isConfidential,
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
                                itemCount: widget.stepPic?.length ?? 0,
                                loadingBuilder: (context, event) {
                                  if (event == null) {}
                                  return Center(
                                      child:
                                          LoadingAnimationWidget.stretchedDots(
                                              color: kMainYellowColor,
                                              size: 50));
                                },
                                builder: (context, index) {
                                  return PhotoViewGalleryPageOptions(
                                      imageProvider: NetworkImage(
                                          widget.stepPic?[index] ?? ""),
                                      initialScale:
                                          PhotoViewComputedScale.contained *
                                              0.85,
                                      heroAttributes: PhotoViewHeroAttributes(
                                          tag: widget.stepPic?[index] ?? ""));
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
      margin: const EdgeInsets.only(left: 12, right: 12),
      color: kMainWhiteColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            widget.stepTitle,
            style: const TextStyle(
                color: kMainBlackColor,
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < widget.stepDesc.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: kMainYellowColor,
                                borderRadius: BorderRadius.circular(100)),
                            child: Text(
                              '${i + 1}',
                              style: missionDetailStepsNumTextStyle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              widget.stepDesc[i],
                              style: missionDetailStepsDescTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: widget.isConfidential
                        ? Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  widget.stepPic?.length ?? 0,
                                  (index) => Stack(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 157,
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 6, 6, 0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: kThirdGreyColor,
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: Image.network(
                                            widget.stepPic?[index] ?? "",
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Center(
                                                child: LoadingAnimationWidget
                                                    .stretchedDots(
                                                  color: kMainYellowColor,
                                                  size: 50,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            color: kMainBlackColor
                                                .withOpacity(0.5),
                                            height: 28,
                                            child: const Center(
                                              child: Text(
                                                '无法预览图片',
                                                style: TextStyle(
                                                  color: kMainWhiteColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  widget.stepPic?.length ?? 0,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      showZoomImage(context, index);
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 157,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 6, 6, 0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: kThirdGreyColor,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            child: Image.network(
                                              widget.stepPic?[index] ?? "",
                                              fit: BoxFit.cover,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child: LoadingAnimationWidget
                                                      .stretchedDots(
                                                    color: kMainYellowColor,
                                                    size: 50,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: IconButton(
                                            icon: SvgPicture.asset(
                                              'assets/mission/enlarge_icon.svg',
                                            ),
                                            onPressed: () {
                                              showZoomImage(context, index);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Text(
                        "图片数量 ",
                        style: missionDetailImgNumTextStyle,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text('(${widget.stepPic?.length ?? 0})',
                          style: missionDetailImgNumTextStyle),
                    ],
                  ),
                  // const SizedBox(height: 6),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 6),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //         width: 24,
                  //         height: 24,
                  //         alignment: Alignment.center,
                  //         decoration: BoxDecoration(
                  //             color: kMainYellowColor,
                  //             borderRadius: BorderRadius.circular(100)),
                  //         child: Text(
                  //           '${widget.stepDesc.length}',
                  //           style: missionDetailStepsNumTextStyle,
                  //         ),
                  //       ),
                  //       const SizedBox(width: 6),
                  //       Expanded(
                  //         child: Text(
                  //           widget.stepDesc.length > 0
                  //               ? widget.stepDesc[widget.stepDesc.length + 1]
                  //               : '',
                  //           style: missionDetailStepsDescTextStyle,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
