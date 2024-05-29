import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:part_time_app/Components/Dialog/alertDialogComponent.dart';
import 'package:part_time_app/Components/Dialog/paymentUploadDialogComponent.dart';
import 'package:part_time_app/Components/TextField/primaryTextFieldComponent.dart';
import 'package:part_time_app/Pages/MissionIssuer/missionPublishMainPage.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:intl/intl.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/Ticketing/ticketingModel.dart';
import '../../Services/Upload/uploadServices.dart';
import '../../Services/ticketing/ticketingServices.dart';

late TextEditingController fieldControllerTicket;
late TextEditingController emailControllerTicket;
late TextEditingController nameControllerTicket;
late TextEditingController phoneNumControllerTicket;
late TextEditingController dateControllerTicket;
late TextEditingController tickerTypeControllerTicket;
late TextEditingController reportIDControllerTicket;
late TextEditingController reportUserIDControllerTicket;
String? dropdownValueForTicket;
int? dropdownIDForTicket;
List<String>? uploadedImagesListSS = [];
String ticketSubmssionDate = "";

class TicketSubmissionComponent extends StatefulWidget {
  List<String>? submissionPics;
  final bool isEdit;
  final Function(String)? detailsFieldChange;
  final Function(String)? onEmailChange;
  final Function(String)? onNameChange;
  final Function(String)? onPhoneNumChange;
  final Function(String)? onreportIDChange;
  final Function(String)? onreportUserIDChange;
  final String? fieldInitial;
  final String? emailInitial;
  final String? nameInitial;
  final String? phoneNumberInitial;
  final String? reportTaskIDInitial;
  final String? reportUserIDInitial;
  final int? ticketType;

  TicketSubmissionComponent({
    super.key,
    this.submissionPics,
    required this.isEdit,
    this.detailsFieldChange,
    this.onEmailChange,
    this.onNameChange,
    this.onreportIDChange,
    this.onreportUserIDChange,
    this.onPhoneNumChange,
    this.fieldInitial,
    this.emailInitial,
    this.nameInitial,
    this.phoneNumberInitial,
    this.reportTaskIDInitial,
    this.reportUserIDInitial,
    this.ticketType,
  });

  @override
  State<TicketSubmissionComponent> createState() =>
      _TicketSubmissionComponentState();
}

class _TicketSubmissionComponentState extends State<TicketSubmissionComponent> {
  List<XFile>? selectedImageList = [];
  List<String> selectedImageUrls = [];
  PageController pageController = PageController();
  List<ComplaintType> _complaintTypes = [];

  // upload picture service
  final ImagePicker imagePicker = ImagePicker();
  UploadServices uploadServices = UploadServices();
  List<String>? uploadedList = [];
  bool isUploadLoading = false;

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
                                    uploadedImagesListSS!.removeAt(index);

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

  void imageSelect() async {
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
            await uploadServices.uploadTicketImages(imagePath);
        if (uploadedImagesList != []) {
          Fluttertoast.showToast(
              msg: "已上传",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: kMainGreyColor,
              textColor: kThirdGreyColor);

          setState(() {
            isUploadLoading = false;

            uploadedImagesListSS = uploadedImagesList;
            print("check uploaded: ${uploadedImagesListSS}");
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
            msg: "error:$e",
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

  @override
  void initState() {
    super.initState();
    _fetchComplaintTypes();
    fieldControllerTicket = TextEditingController(text: widget.fieldInitial);
    emailControllerTicket = TextEditingController(text: widget.emailInitial);
    nameControllerTicket = TextEditingController(text: widget.nameInitial);
    phoneNumControllerTicket =
        TextEditingController(text: widget.phoneNumberInitial);
    reportIDControllerTicket =
        TextEditingController(text: widget.reportTaskIDInitial);
    reportUserIDControllerTicket =
        TextEditingController(text: widget.reportUserIDInitial);
    setState(() {
      ticketSubmssionDate = _getCurrentDateAndTime();
    });
    dateControllerTicket = TextEditingController(text: ticketSubmssionDate);
  }

  String _getCurrentDateAndTime() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy hh:mm:ss a').format(now);
    return formattedDate;
  }

  Future<void> _fetchComplaintTypes() async {
    try {
      List<ComplaintType> complaintTypes =
          await TicketingService().fetchComplaintTypesForDropdown();
      setState(() {
        _complaintTypes = complaintTypes;
        dropdownValueForTicket = complaintTypes.isNotEmpty
            ? complaintTypes[widget.ticketType ?? 0].complaintName
            : null;
        dropdownIDForTicket = widget.ticketType;
      });
    } catch (e) {
      // Handle error
      print('Error fetching complaint types: $e');
    }
  }

  int? _getComplaintIdByName(String name) {
    for (var type in _complaintTypes) {
      if (type.complaintName == name) {
        return type.complaintTypeId;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: kMainWhiteColor, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("姓名", style: depositTextStyle2),
          _buildTextInput(
              hintText: "请输入姓名",
              controller: nameControllerTicket,
              onChanged: (value) {
                if (widget.onNameChange != null) {
                  widget.onNameChange!(value);
                }
              },
              readOnly: false),
          const SizedBox(height: 15),
          const Text("电话号码", style: depositTextStyle2),
          _buildTextInput(
              hintText: "电话号码",
              controller: phoneNumControllerTicket,
              onChanged: (value) {
                if (widget.onPhoneNumChange != null) {
                  widget.onPhoneNumChange!(value);
                }
              },
              readOnly: false),
          const SizedBox(height: 15),
          const Text("电子邮件", style: depositTextStyle2),
          _buildTextInput(
              hintText: "电子邮件",
              controller: emailControllerTicket,
              onChanged: (value) {
                if (widget.onEmailChange != null) {
                  widget.onEmailChange!(value);
                }
              },
              readOnly: false),
          const SizedBox(height: 15),
          const Text("日期", style: depositTextStyle2),
          _buildTextInput(
              hintText: "",
              controller: dateControllerTicket,
              onChanged: (value) {},
              readOnly: true),
          const SizedBox(height: 15),
          const Text("悬赏ID", style: depositTextStyle2),
          _buildTextInput(
              hintText: "悬赏ID",
              controller: reportIDControllerTicket,
              onChanged: (value) {
                if (widget.onreportIDChange != null) {
                  widget.onreportIDChange!(value);
                }
              },
              readOnly: false),
          const SizedBox(height: 15),
          const Text("被举报用户ID", style: depositTextStyle2),
          _buildTextInput(
              hintText: "举报用户ID",
              controller: reportUserIDControllerTicket,
              onChanged: (value) {
                if (widget.onreportUserIDChange != null) {
                  widget.onreportUserIDChange!(value);
                }
              },
              readOnly: false),
          const SizedBox(height: 15),
          const Text("申述种类", style: depositTextStyle2),
          Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.only(left: 10),
            height: 31,
            decoration: BoxDecoration(
                color: kInputBackGreyColor,
                borderRadius: BorderRadius.circular(8)),
            child: DropdownButton<String>(
              underline: Container(),
              value: dropdownValueForTicket,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: missionUsernameTextStyle,
              onChanged: (newValue) {
                setState(() {
                  dropdownValueForTicket = newValue!;
                  dropdownIDForTicket = _getComplaintIdByName(newValue);
                });
              },
              items: _complaintTypes
                  .map<DropdownMenuItem<String>>((ComplaintType type) {
                return DropdownMenuItem<String>(
                  value: type.complaintName,
                  child: Text(type.complaintName),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 15),
          const Text("申述详情", style: depositTextStyle2),
          _buildTextFieldInput(
              hintText: "申述详情",
              controller: fieldControllerTicket,
              onChanged: (value) {
                if (widget.detailsFieldChange != null) {
                  widget.detailsFieldChange!(value);
                }
              },
              readOnly: false),
        ],
      ),
    );
  }

  Widget _buildTextInput({
    required String hintText,
    required TextEditingController controller,
    required Function(String) onChanged,
    required bool readOnly,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      height: 31,
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: kInputBackGreyColor,
          hintText: hintText,
          hintStyle: missionDetailText2,
          contentPadding: const EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          labelStyle: depositTextStyle2,
        ),
      ),
    );
  }

  Widget _buildTextFieldInput({
    required String hintText,
    required TextEditingController controller,
    required Function(String) onChanged,
    required bool readOnly,
  }) {
    return Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.only(left: 10, bottom: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: kInputBackGreyColor, borderRadius: BorderRadius.circular(4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              maxLines: null,
              readOnly: readOnly,
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: missionDetailText2,
                contentPadding: const EdgeInsets.all(0),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                labelStyle: depositTextStyle2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: isUploadLoading
                          ? null
                          : () {
                              imageSelect();
                            },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          color: Color(0XFFEEEEEE),
                        ),
                        child: isUploadLoading
                            ? Center(
                                child: LoadingAnimationWidget.stretchedDots(
                                    color: kMainYellowColor, size: 50))
                            : Center(
                                child: Icon(
                                  Icons.add,
                                  size: 40,
                                  color: Color.fromRGBO(153, 153, 153, 1),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                        width:
                            10), // Add some spacing between the add button and the selected image
                    if (uploadedImagesListSS!.isNotEmpty)
                      ...uploadedImagesListSS!
                          .map((url) => GestureDetector(
                                onTap: () {
                                  showZoomImage(
                                      context,
                                      uploadedImagesListSS!.indexOf(url),
                                      uploadedImagesListSS!,
                                      uploadedImagesListSS!.indexOf(url));
                                },
                                child: Container(
                                  height: 100,
                                  width: 157,
                                  margin: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.grey,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(
                                      url,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                            child: LoadingAnimationWidget
                                                .stretchedDots(
                                                    color: Colors.yellow,
                                                    size: 50));
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
                                          child: Text(
                                            "无法显示图片",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
