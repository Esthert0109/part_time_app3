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

late TextEditingController fieldControllerTicket;
late TextEditingController emailControllerTicket;
late TextEditingController nameControllerTicket;
late TextEditingController phoneNumControllerTicket;
late TextEditingController dateControllerTicket;
late TextEditingController detailsFieldControllerTicket;
late TextEditingController reportIDControllerTicket;
late TextEditingController reportUserIDControllerTicket;

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
  final String? reportIDInitial;
  final String? reportUserIDInitial;

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
    this.reportIDInitial,
    this.reportUserIDInitial,
  });

  @override
  State<TicketSubmissionComponent> createState() =>
      _TicketSubmissionComponentState();
}

class _TicketSubmissionComponentState extends State<TicketSubmissionComponent> {
  List<XFile>? selectedImageList = [];
  List<String> selectedImageUrls = [];
  PageController pageController = PageController();
  TextEditingController stepdescriptionController = TextEditingController();
  List<SstepModel> steps = [];
  List<String> imageUrls = [];
  final ImagePicker picker = ImagePicker();
  int imageSelected = 0;

  void showZoomImage(BuildContext context, int index) {
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
                          backgroundDecoration: const BoxDecoration(color: kTransparent),
                          itemCount: widget.submissionPics?.length ?? 0,
                          loadingBuilder: (context, event) {
                            if (event == null) {}
                            return Center(
                              child: LoadingAnimationWidget.stretchedDots(
                                color: kMainYellowColor,
                                size: 50,
                              ),
                            );
                          },
                          builder: (context, index) {
                            return PhotoViewGalleryPageOptions(
                              imageProvider: NetworkImage(widget.submissionPics?[index] ?? ""),
                              initialScale: PhotoViewComputedScale.contained * 0.85,
                              heroAttributes: PhotoViewHeroAttributes(tag: widget.submissionPics?[index] ?? ""),
                            );
                          },
                        ),
                      ),
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
                widget.isEdit
                    ? Positioned(
                        top: 0,
                        left: 0,
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: kMainWhiteColor,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialogComponent(
                                  alertTitle: '删除图片',
                                  alertDesc: RichText(
                                    text: const TextSpan(
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
                                  firstButtonTextStyle: alertDialogFirstButtonTextStyle,
                                  firstButtonColor: kThirdGreyColor,
                                  secondButtonText: '删除',
                                  secondButtonTextStyle: alertDialogRejectButtonTextStyle,
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
                                      Navigator.pop(context);

                                      Fluttertoast.showToast(
                                        msg: "已删除",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: kMainGreyColor,
                                        textColor: kThirdGreyColor,
                                      );
                                    });
                                  },
                                );
                              },
                            );
                          },
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fieldControllerTicket = TextEditingController(text: widget.fieldInitial);
    emailControllerTicket = TextEditingController(text: widget.emailInitial);
    nameControllerTicket = TextEditingController(text: widget.nameInitial);
    phoneNumControllerTicket =
        TextEditingController(text: widget.phoneNumberInitial);
    reportIDControllerTicket =
        TextEditingController(text: widget.reportIDInitial);
    reportUserIDControllerTicket =
        TextEditingController(text: widget.reportUserIDInitial);
    dateControllerTicket =
        TextEditingController(text: _getCurrentDateAndTime());
  }

  String _getCurrentDateAndTime() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy hh:mm:ss a').format(now);
    return formattedDate;
  }

  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: kMainWhiteColor, borderRadius: BorderRadius.circular(8)),
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
              readOnly: true),
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
              readOnly: true),
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
              readOnly: true),
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
              readOnly: true),
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
              readOnly: true),
          const SizedBox(height: 15),
          const Text("申述种类", style: depositTextStyle2),
          Container(
            padding: const EdgeInsets.only(left: 10),
            height: 31,
            decoration: BoxDecoration(color: kInputBackGreyColor, borderRadius: BorderRadius.circular(8)),
            child: DropdownButton<String>(
              underline: Container(),
              value: dropdownValue,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: missionUsernameTextStyle,
              onChanged: (newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['举报', '建议', '审核不通过', '信誉分', '其他'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
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
    void imageSelect() async {
      final List<XFile>? images = await picker.pickMultiImage();
      if (images != null) {
        setState(() {
          selectedImageList = selectedImageList! + images;
          selectedImageUrls = selectedImageList!.map((e) => e.path).toList();
          imageSelected += images.length;
        });
      }
    }

    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: kInputBackGreyColor,
        borderRadius: BorderRadius.circular(4),
      ),
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
                  widget.isEdit
                      ? GestureDetector(
                          onTap: () {
                            imageSelect();
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            margin: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0XFFEEEEEE),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                size: 50,
                                color: Color(0XFF999999),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  Row(
                    children: List.generate(
                      widget.submissionPics?.length ?? 0,
                      (index) => GestureDetector(
                        onTap: () {
                          showZoomImage(context, index);
                        },
                        child: Container(
                          height: 100,
                          width: 157,
                          margin: const EdgeInsets.fromLTRB(0, 6, 6, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: kThirdGreyColor,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              widget.submissionPics?[index] ?? "",
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: LoadingAnimationWidget.stretchedDots(
                                    color: kMainYellowColor,
                                    size: 50,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Text(
                                    "无法显示图片",
                                    style: submissionPicErrorTextStyle,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(
                      selectedImageUrls.length,
                      (index) => GestureDetector(
                        onTap: () {
                          showZoomImage(context, index);
                        },
                        child: Container(
                          height: 100,
                          width: 157,
                          margin: const EdgeInsets.fromLTRB(0, 6, 6, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: kThirdGreyColor,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.file(
                              File(selectedImageUrls[index]),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Text(
                                    "无法显示图片",
                                    style: submissionPicErrorTextStyle,
                                  ),
                                );
                              },
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
      ),
    );
  }
}
