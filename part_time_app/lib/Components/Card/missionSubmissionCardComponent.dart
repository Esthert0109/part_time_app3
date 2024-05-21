import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Services/Upload/uploadServices.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../Constants/textStyleConstant.dart';
import '../Dialog/alertDialogComponent.dart';

List<String> updateUploadList = [];

class MissionSubmissionCardComponent extends StatefulWidget {
  List<String>? submissionPics;
  final bool isEdit;
  final bool isCollapsed;
  final bool isCollapseAble;

  MissionSubmissionCardComponent(
      {super.key,
      this.submissionPics,
      required this.isEdit,
      required this.isCollapsed,
      required this.isCollapseAble});

  @override
  State<MissionSubmissionCardComponent> createState() =>
      _MissionSubmissionCardComponentState();
}

class _MissionSubmissionCardComponentState
    extends State<MissionSubmissionCardComponent> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? selectedImageList;
  int imageSelected = 0;
  PageController pageController = PageController();

  // services
  UploadServices uploadServices = UploadServices();
  List<String>? uploadedList = [];
  bool isUploadLoading = false;

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
                    constraints: BoxConstraints.expand(),
                    child: Column(
                      children: [
                        Expanded(
                            child: PhotoViewGallery.builder(
                                enableRotation: true,
                                pageController: pageController,
                                backgroundDecoration:
                                    const BoxDecoration(color: kTransparent),
                                itemCount: uploadedList?.length ?? 0,
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
                                          uploadedList?[index] ?? ""),
                                      initialScale:
                                          PhotoViewComputedScale.contained *
                                              0.85,
                                      heroAttributes: PhotoViewHeroAttributes(
                                          tag: uploadedList?[index] ?? ""));
                                }))
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: kMainWhiteColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  widget.isEdit
                      ? Positioned(
                          top: 0,
                          left: 0,
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: kMainWhiteColor,
                            ),
                            onPressed: () {
                              print("delete object");
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialogComponent(
                                      alertTitle: '删除图片',
                                      alertDesc: RichText(
                                        text: TextSpan(
                                          style: alertDialogContentTextStyle,
                                          children: [
                                            TextSpan(text: '此步骤将取消删除图片。\n'),
                                            TextSpan(
                                              text: '是否继续？\n',
                                            ),
                                          ],
                                        ),
                                      ),
                                      descTextStyle:
                                          alertDialogContentTextStyle,
                                      firstButtonText: '返回',
                                      firstButtonTextStyle:
                                          alertDialogFirstButtonTextStyle,
                                      firstButtonColor: kThirdGreyColor,
                                      secondButtonText: '删除',
                                      secondButtonTextStyle:
                                          alertDialogRejectButtonTextStyle,
                                      secondButtonColor:
                                          kRejectMissionButtonColor,
                                      isButtonExpanded: true,
                                      firstButtonOnTap: () {
                                        setState(() {
                                          Navigator.pop(context);
                                        });
                                      },
                                      secondButtonOnTap: () {
                                        setState(() {
                                          Navigator.pop(context);
                                          uploadedList!.removeAt(index);
                                          imageSelected = uploadedList!.length;
                                          updateUploadList = uploadedList!;
                                          Navigator.pop(context);

                                          Fluttertoast.showToast(
                                              msg: "已删除",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: kMainGreyColor,
                                              textColor: kThirdGreyColor);
                                        });
                                      },
                                    );
                                  });
                            },
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    void imageSelect() async {
      selectedImageList = await imagePicker.pickMultiImage();

      List<File> imagePath = [];

      if (selectedImageList!.isNotEmpty) {
        for (int i = 0; i < selectedImageList!.length; i++) {
          imagePath.add(File(selectedImageList![i].path));
        }

        try {
          setState(() {
            isUploadLoading = true;
          });
          List<String>? uploadList =
              await uploadServices.uploadTaskImages(imagePath);
          if (uploadList != []) {
            Fluttertoast.showToast(
                msg: "已上传",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: kMainGreyColor,
                textColor: kThirdGreyColor);
            setState(() {
              isUploadLoading = false;
              uploadedList?.addAll(uploadList!);
              imageSelected = uploadedList!.length;
              updateUploadList = uploadedList!;
            });
          } else {
            Fluttertoast.showToast(
                msg: "上传失败",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: kMainGreyColor,
                textColor: kThirdGreyColor);
            setState(() {
              imageSelected += 0;
              isUploadLoading = false;
            });
          }
        } catch (e) {
          print("Error in upload: $e");
        }
      }
    }

    return Card(
        margin: const EdgeInsets.symmetric(vertical: 6),
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
            expandedAlignment: Alignment.centerLeft,
            trailing: widget.isCollapseAble ? null : SizedBox.shrink(),
            tilePadding: EdgeInsets.symmetric(horizontal: 12),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "成果截图提交",
                    style: missionSubmissionTitleTextStyle,
                  ),
                  Text(
                    "已上传（${widget.isEdit ? imageSelected.toString() : widget.submissionPics?.length}）",
                    style: missionSubmissionNoPicsTextStyle,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 12),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.isEdit
                          ? GestureDetector(
                              onTap: isUploadLoading
                                  ? null
                                  : () {
                                      imageSelect();
                                    },
                              child: Container(
                                  height: 100,
                                  width: 100,
                                  margin: const EdgeInsets.fromLTRB(0, 6, 6, 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: kThirdGreyColor),
                                  child: isUploadLoading
                                      ? Center(
                                          child: LoadingAnimationWidget
                                              .stretchedDots(
                                                  color: kMainYellowColor,
                                                  size: 50))
                                      : Center(
                                          child: SvgPicture.asset(
                                            "assets/common/add.svg",
                                            height: 40,
                                            width: 40,
                                          ),
                                        )),
                            )
                          : Container(),
                      Row(
                        children: List.generate(
                            uploadedList?.length ?? 0,
                            (index) => GestureDetector(
                                  onTap: () {
                                    showZoomImage(context, index);
                                  },
                                  child: Container(
                                    height: 100,
                                    width: 157,
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 6, 6, 0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: kThirdGreyColor),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.network(
                                        uploadedList?[index] ?? "",
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                              child: LoadingAnimationWidget
                                                  .stretchedDots(
                                                      color: kMainYellowColor,
                                                      size: 50));
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
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
                                )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
