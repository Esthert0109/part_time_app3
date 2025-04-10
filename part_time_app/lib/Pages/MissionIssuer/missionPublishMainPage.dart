import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:part_time_app/Components/Card/missionPublishCheckoutCardComponent.dart';
import 'package:part_time_app/Components/Title/secondaryTitleComponent.dart';
import 'package:part_time_app/Model/Task/missionClass.dart';
import 'package:part_time_app/Model/User/userModel.dart';
import 'package:part_time_app/Services/order/tagServices.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pinput/pinput.dart';

import '../../Components/Dialog/alertDialogComponent.dart';
import '../../Components/Status/statusDialogComponent.dart';
import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/Task/tagModel.dart';
import '../../Services/Upload/uploadServices.dart';
import 'missionDetailStatusIssuerPage.dart';

class MissionPublishMainPage extends StatefulWidget {
  final bool isEdit;
  final OrderData? taskReedit;
  const MissionPublishMainPage(
      {super.key, required this.isEdit, this.taskReedit});

  @override
  State<MissionPublishMainPage> createState() => _MissionPublishMainPageState();
}

class _MissionPublishMainPageState extends State<MissionPublishMainPage> {
  FocusNode focusNode = FocusNode();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  TextEditingController stepdescriptionController = TextEditingController();

  List<TextEditingController> stepInstructionController = [];
  PageController pageController = PageController();
  ScrollController tagScrollController = ScrollController();

  List<File> imageUrls = [];
  String titleInput = "";
  String contentInput = "";
  bool isGetTag = false;
  bool picPreview = false;
  bool isTagLoadingMore = false;
  int tagsLength = 0;
  int tagPage = 1;

  List<String> selectedTag = [];
  String selectedTagIds = "";
  List<TagData> selectedTagList = [];

  // services
  TagServices services = TagServices();
  List<TagData> tagList = [];
  bool isTagLoading = false;
  OrderData orderData = OrderData();
  UserData? userData;

  // upload picture service
  final ImagePicker imagePicker = ImagePicker();
  UploadServices uploadServices = UploadServices();
  List<String>? uploadedList = [];
  bool isUploadLoading = false;

  // Steps
  TaskProcedureModel? taskSteps;
  List<TaskProcedureData> stepsList = [];

  void newStepController() {
    setState(() {
      stepInstructionController.add(TextEditingController());
    });
  }

  void removeStepController(int index) {
    setState(() {
      stepInstructionController[index].dispose();
      stepInstructionController.removeAt(index);
      stepsList.removeAt(index);
    });
  }

  void imageSelect(int index) async {
    List<XFile> uploadedImages = await imagePicker.pickMultiImage();
    List<File> imagePath = [];

    if (uploadedImages.isNotEmpty) {
      for (int i = 0; i < uploadedImages.length; i++) {
        imagePath.add(File(uploadedImages[i].path));
      }
      print("check image uploaded: $imagePath");

      try {
        setState(() {
          isUploadLoading = true;
        });

        List<String>? uploadedImagesList =
            await uploadServices.uploadTaskImages(imagePath);
        if (uploadedImagesList != []) {
          Fluttertoast.showToast(
              msg: "已上传",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: kMainGreyColor,
              textColor: kThirdGreyColor);

          setState(() {
            isUploadLoading = false;
            if (stepsList[index].image == null) {
              stepsList[index].image = [];
            }
            stepsList[index].image!.addAll(uploadedImagesList ?? []);

            print("check uploaded: ${stepsList[index].image}");
          });
        } else {
          Fluttertoast.showToast(
              msg: "上传失败",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: kMainGreyColor,
              textColor: kThirdGreyColor);
          setState(() {
            isUploadLoading = false;
          });
        }
      } catch (e) {
        Fluttertoast.showToast(
            msg: "$e",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: kMainGreyColor,
            textColor: kThirdGreyColor);
        setState(() {
          isUploadLoading = false;
        });
      }
    }
  }

  fetchTagList() async {
    setState(() {
      isTagLoading = true;
    });
    TagModel? model = await services.getTagList(1);
    if (model!.data != [] || model.data != null) {
      setState(() {
        tagList = model.data!;
        isTagLoading = false;
        tagPage++;
      });
    }
  }

  fetchTagPagination() async {
    setState(() {
      isTagLoadingMore = true;
    });
    TagModel? model = await services.getTagList(tagPage);
    if (model!.data != [] || model.data != null) {
      setState(() {
        tagList.addAll(model.data!);
        tagPage++;
      });
    }

    setState(() {
      isTagLoadingMore = false;
    });
  }

  showZoomImage(BuildContext context, int index, List<String> imageUrlList,
      int listIndex) {
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
                                itemCount: imageUrlList.length,
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
                                          imageUrlList?[index] ?? ""),
                                      initialScale:
                                          PhotoViewComputedScale.contained *
                                              0.85,
                                      heroAttributes: PhotoViewHeroAttributes(
                                          tag: imageUrlList?[index] ?? ""));
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
                  Positioned(
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
                                descTextStyle: alertDialogContentTextStyle,
                                firstButtonText: '返回',
                                firstButtonTextStyle:
                                    alertDialogFirstButtonTextStyle,
                                firstButtonColor: kThirdGreyColor,
                                secondButtonText: '删除',
                                secondButtonTextStyle:
                                    alertDialogRejectButtonTextStyle,
                                secondButtonColor: kRejectMissionButtonColor,
                                isButtonExpanded: true,
                                firstButtonOnTap: () {
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                },
                                secondButtonOnTap: () {
                                  setState(() {
                                    Navigator.pop(context);
                                    stepsList[listIndex].image!.removeAt(index);

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
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    tagScrollController.addListener(_tagScrollListener);
    focusNode.addListener(() {
      setState(() {});
    });
    // newStepController();

    fetchTagList();
    fetchUserData();

    if (widget.isEdit) {
      fetchReedit();
    }
  }

  fetchReedit() {
    setState(() {
      titleController.setText(widget.taskReedit?.taskTitle ?? "");
      titleInput = widget.taskReedit?.taskTitle ?? "";
      descController.setText(widget.taskReedit?.taskContent ?? "");
      contentInput = widget.taskReedit?.taskContent ?? "";
      selectedTagList.addAll(widget.taskReedit?.taskTagNames ?? []);
      for (int i = 0; i < selectedTagList.length; i++) {
        selectedTag.add(widget.taskReedit!.taskTagNames![i].tagName);
        selectedTagIds =
            "$selectedTagIds${widget.taskReedit!.taskTagNames![i].tagId.toString()},";
      }
      stepsList = widget.taskReedit?.taskProcedures?.step ?? [];
      picPreview = widget.taskReedit?.taskImagesPreview == 1 ? true : false;
      for (int i = 0; i < widget.taskReedit!.taskProcedures!.step.length; i++) {
        newStepController();
        stepInstructionController[i]
            .setText(widget.taskReedit!.taskProcedures!.step[i].instruction);
      }
    });
  }

  @override
  void dispose() {
    tagScrollController.dispose();

    for (var controller in stepInstructionController) {
      controller.dispose();
    }
    super.dispose();
  }

  _tagScrollListener() {
    if (tagScrollController.position.pixels >=
            tagScrollController.position.maxScrollExtent - 20 &&
        !isTagLoadingMore) {
      fetchTagPagination();
    }
  }

  fetchUserData() async {
    userData = await SharedPreferencesUtils.getUserDataInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0.0,
        leading: widget.isEdit
            ? IconButton(
                iconSize: 15,
                icon: Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Get.back();
                },
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SecondaryTitleComponent(
                  titleList: ["发布悬赏"],
                  selectedIndex: 0,
                  onTap: (int) {},
                ),
              ),
        leadingWidth: widget.isEdit ? 55 : double.infinity,
        centerTitle: widget.isEdit ? true : false,
        title: widget.isEdit
            ? Container(
                color: kTransparent,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: thirdTitleComponent(
                  text: "编辑悬赏",
                ))
            : null,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: kThirdGreyColor,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kBackgroundFirstGradientColor,
              kBackgroundSecondGradientColor
            ],
            stops: [0.0, 0.15],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: kMainWhiteColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 85,
                      child: TextFormField(
                        maxLength: 16,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        controller: titleController,
                        focusNode: focusNode,
                        onChanged: (input) {
                          setState(() {
                            titleInput = input;
                            print("check input: ${titleInput}");
                          });
                        },
                        cursorColor: kMainYellowColor,
                        decoration: InputDecoration(
                            counterText: "",
                            hintText: "标题",
                            hintStyle: messageDescTextStyle2,
                            border: InputBorder.none),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '请输入标题';
                          }
                          return null;
                        },
                      ),
                    ),
                    Flexible(
                        flex: 15,
                        child: Text(
                          "(${titleInput.length}/16)",
                          maxLines: 1,
                          style: inputCounterTextStyle,
                        ))
                  ],
                ),
              ),
              Container(
                height: isGetTag ? 330 : 206,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                    color: kMainWhiteColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: isGetTag ? 3 : 8,
                      child: Container(
                        child: TextFormField(
                          maxLength: 120,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          controller: descController,
                          onChanged: (input) {
                            setState(() {
                              contentInput = input;
                              print("check content:${contentInput}");
                            });
                          },
                          cursorColor: kMainYellowColor,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                              counterText: "",
                              hintText: "正文",
                              hintStyle: messageDescTextStyle2,
                              border: InputBorder.none),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '请输入标题';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "(${contentInput.length}/120)",
                            maxLines: 1,
                            style: inputCounterTextStyle,
                          )
                        ],
                      ),
                    ),
                    isGetTag
                        ? Expanded(
                            flex: 6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 3),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: '#',
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: InkWell(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                            setState(() {
                                              isGetTag = false;
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                15, 15, 5, 5),
                                            child: Text(
                                              '取消',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 15,
                                                  color:
                                                      kRejectMissionButtonTextColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                                Container(
                                    height: 130,
                                    padding: EdgeInsets.symmetric(vertical: 2),
                                    child: isTagLoading
                                        ? Center(
                                            child: LoadingAnimationWidget
                                                .stretchedDots(
                                                    color: kMainYellowColor,
                                                    size: 30))
                                        : ListView.builder(
                                            itemCount: tagList.length,
                                            controller: tagScrollController,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    isGetTag = false;
                                                    selectedTag.add(
                                                        tagList[index].tagName);
                                                    selectedTagList
                                                        .add(tagList[index]);
                                                    selectedTagIds =
                                                        "$selectedTagIds${tagList[index].tagId.toString()},";
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 8,
                                                      child: Container(
                                                          height: 30,
                                                          child: RichText(
                                                            text: TextSpan(
                                                                style:
                                                                    missionDetailText3,
                                                                children: [
                                                                  TextSpan(
                                                                      text:
                                                                          "# "),
                                                                  TextSpan(
                                                                      text: tagList[
                                                                              index]
                                                                          .tagName)
                                                                ]),
                                                          )),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        height: 30,
                                                        child: Text(
                                                          "${tagList[index].totalOccurrence.toString()} 篇" ??
                                                              '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style:
                                                              inputCounterTextStyle,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }))
                              ],
                            ),
                          )
                        : Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: GestureDetector(
                                    onTap: () {
                                      print("get tag");
                                      FocusScope.of(context).unfocus();
                                      setState(() {
                                        isGetTag = true;
                                      });
                                    },
                                    child: Container(
                                      height: 24,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 6),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: kThirdGreyColor,
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      child: Text(
                                        "选择标签",
                                        textAlign: TextAlign.center,
                                        style: unselectedThirdStatusTextStyle,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 7,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                            selectedTag.length,
                                            (index) => GestureDetector(
                                                  onTap: () {
                                                    print("delete tag");
                                                    setState(() {
                                                      selectedTag.removeWhere(
                                                          (element) =>
                                                              element ==
                                                              selectedTag[
                                                                  index]);
                                                      Fluttertoast.showToast(
                                                          msg: "已删除",
                                                          toastLength:
                                                              Toast.LENGTH_LONG,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          backgroundColor:
                                                              kMainGreyColor,
                                                          textColor:
                                                              kThirdGreyColor);
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 24,
                                                    margin: EdgeInsets.only(
                                                        right: 6),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4,
                                                            horizontal: 10),
                                                    decoration: BoxDecoration(
                                                        color: kThirdGreyColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13)),
                                                    child: IntrinsicWidth(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            selectedTag[index],
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                unselectedThirdStatusTextStyle,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(10, 4,
                                                                    0, 0),
                                                            child: SvgPicture
                                                                .asset(
                                                              "assets/common/close2.svg",
                                                              width: 8,
                                                              height: 8,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                      ),
                                    ))
                              ],
                            ),
                          )
                  ],
                ),
              ),
              ListView.builder(
                itemCount: stepsList!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    height: 250,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    margin: EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kMainWhiteColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: SvgPicture.asset(
                                            'assets/mission/steps.svg',
                                            width: 24,
                                            height: 24,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "第${index + 1}步",
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                missionCheckoutInputTextStyle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 2),
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        iconSize: 24,
                                        alignment: Alignment.topRight,
                                        padding: EdgeInsets.only(bottom: 2),
                                        icon: Icon(
                                          Icons.delete,
                                          color: kMainRedColor,
                                        ),
                                        onPressed: () {
                                          print(
                                              "delete this steps: ${index + 1}");
                                          setState(() {
                                            removeStepController(index);
                                          });
                                          Fluttertoast.showToast(
                                              msg: "已删除",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: kMainGreyColor,
                                              textColor: kThirdGreyColor);
                                        },
                                      )),
                                ],
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              padding: EdgeInsets.all(0),
                              child: TextFormField(
                                maxLength: 150,
                                controller: stepInstructionController[index],
                                maxLines: null,
                                cursorColor: kMainYellowColor,
                                onChanged: (value) {
                                  print("value:$value");
                                  setState(() {
                                    stepsList?[index].instruction = value;
                                  });
                                },
                                decoration: InputDecoration(
                                    hintText: '请输入文案......',
                                    counterText: "",
                                    hintStyle: messageDescTextStyle2,
                                    border: InputBorder.none),
                              ),
                            )),
                        Expanded(
                            flex: 4,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: isUploadLoading
                                        ? null
                                        : () {
                                            imageSelect(index);
                                          },
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                        color: Color(0XFFF9F9F9),
                                      ),
                                      child: isUploadLoading
                                          ? Center(
                                              child: LoadingAnimationWidget
                                                  .stretchedDots(
                                                      color: kMainYellowColor,
                                                      size: 50))
                                          : Center(
                                              child: Icon(
                                                Icons.add,
                                                size: 24,
                                                color: Color.fromRGBO(
                                                    153, 153, 153, 1),
                                              ),
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          10), // Add some spacing between the add button and selected images
                                  Expanded(
                                    child: Container(
                                      height: 100,
                                      child: ListView.builder(
                                        itemCount:
                                            stepsList![index].image?.length ??
                                                0,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, imageIndex) {
                                          return GestureDetector(
                                            onTap: () {
                                              showZoomImage(
                                                  context,
                                                  imageIndex,
                                                  stepsList![index].image!,
                                                  index);
                                            },
                                            child: Container(
                                              height: 100,
                                              width: 157,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 6, 0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: kThirdGreyColor),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: Image.network(
                                                  stepsList![index]
                                                          .image?[imageIndex] ??
                                                      "",
                                                  fit: BoxFit.cover,
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    }
                                                    return Center(
                                                        child: LoadingAnimationWidget
                                                            .stretchedDots(
                                                                color:
                                                                    kMainYellowColor,
                                                                size: 50));
                                                  },
                                                  errorBuilder: (context, error,
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
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  );
                },
              ),
              GestureDetector(
                onTap: () {
                  print("add steps");
                  setState(() {
                    newStepController();
                    stepsList!.add(TaskProcedureData(
                      instruction: stepInstructionController.last.text,
                    ));
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/mission/add.svg",
                      width: 24,
                      height: 24,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "添加图文步骤",
                        style: missionCheckoutTextStyle,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: widget.isEdit
                    ? MissionPublishCheckoutCardComponent(
                        isSubmit: false,
                        priceInitial:
                            widget.taskReedit!.taskSinglePrice.toString(),
                        peopleInitial: widget.taskReedit!.taskQuota.toString(),
                        dayInitial: widget.taskReedit!.taskTimeLimit.toString(),
                        durationInitial:
                            widget.taskReedit!.taskEstimateTime.toString(),
                      )
                    : MissionPublishCheckoutCardComponent(
                        isSubmit: false,
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      "图片预览",
                      style: missionDetailText6,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            picPreview ? "开始悬赏可见" : "公开",
                            style: tStatusFieldText1,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          height: 40,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Switch(
                                value: picPreview,
                                activeColor: kMainBlackColor,
                                activeTrackColor: kMainYellowColor,
                                inactiveTrackColor: kTransparent,
                                inactiveThumbColor: kMainBlackColor,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.padded,
                                trackOutlineColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                    if (picPreview) {
                                      return kMainBlackColor;
                                    }
                                    return kMainBlackColor; // Use the default color.
                                  },
                                ),
                                trackOutlineWidth: MaterialStateProperty.all(1),
                                onChanged: (preview) {
                                  setState(() {
                                    picPreview = preview;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 51, bottom: 64),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kMainYellowColor,
                          elevation: 0.0,
                          shadowColor: Colors.transparent,
                          alignment: Alignment.center,
                          fixedSize: const Size.fromHeight(40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26))),
                      onPressed: () {
                        if (titleController.text == "" ||
                            descController.text == "" ||
                            selectedTagIds == "" ||
                            stepsList == [] ||
                            stepsList!.isEmpty ||
                            priceController.text == "" ||
                            peopleController.text == "" ||
                            dayController.text == "" ||
                            durationController.text == "" ||
                            totalPrice == 0) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return StatusDialogComponent(
                                complete: false,
                                unsuccessText: "请完整悬赏详情",
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              );
                            },
                          );
                        } else {
                          taskSteps = TaskProcedureModel(step: stepsList ?? []);

                          orderData = OrderData(
                              taskTitle: titleController.text,
                              taskContent: descController.text,
                              taskSinglePrice:
                                  double.tryParse(priceController.text),
                              taskAmount: totalPrice,
                              taskFee: handingFee,
                              taskPrepay: totalPrepaidPrice,
                              taskTimeLimitUnit: selectedDuration,
                              taskEstimateTimeUnit: selectedEndTime,
                              taskTagIds: selectedTagIds,
                              taskTagNames: selectedTagList,
                              taskQuota: int.tryParse(peopleController.text),
                              taskTimeLimit: int.tryParse(dayController.text),
                              taskImagesPreview: picPreview ? 1 : 0,
                              taskEstimateTime:
                                  int.tryParse(durationController.text),
                              taskUpdatedTime: DateFormat('yyyy-MM-dd HH:mm:ss')
                                  .format(DateTime.now()),
                              taskProcedures: taskSteps);
                          Get.to(
                              () => widget.isEdit
                                  ? MissionDetailStatusIssuerPage(
                                      taskId: widget.taskReedit?.taskId ?? 0,
                                      isPreview: true,
                                      orderData: orderData,
                                      isResubmit: true,
                                    )
                                  : MissionDetailStatusIssuerPage(
                                      taskId: 0,
                                      isPreview: true,
                                      orderData: orderData,
                                      isResubmit: false,
                                    ),
                              transition: Transition.rightToLeft);
                        }
                      },
                      child: Text(
                        "预览发布",
                        style: missionCheckoutTotalPriceTextStyle,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
