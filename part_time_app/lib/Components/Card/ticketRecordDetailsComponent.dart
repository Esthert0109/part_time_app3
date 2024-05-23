import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:part_time_app/Components/Dialog/alertDialogComponent.dart';
import 'package:part_time_app/Components/Dialog/paymentUploadDialogComponent.dart';
import 'package:part_time_app/Components/TextField/primaryTextFieldComponent.dart';
import 'package:part_time_app/Model/Task/missionClass.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:intl/intl.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class TicketRecordDetailsComponent extends StatefulWidget {
  final List<TicketRecordDetailsMockClass>? steps;
  final String? ticketCustomerUsername;
  final String? ticketCustomerPhoneNum;
  final String? ticketCustomerEmail;
  final String? ticketDate;
  final int? taskId;
  final String? complaintType;
  final int? complaintUserId;
  final String? ticketComplaintDescription;
  final List<String>? ticketComplaintAttachment;
  final int? ticketStatus;

  TicketRecordDetailsComponent({
    super.key,
    this.steps,
    this.ticketCustomerUsername,
    this.ticketCustomerPhoneNum,
    this.ticketCustomerEmail,
    this.ticketDate,
    this.taskId,
    this.complaintType,
    this.complaintUserId,
    this.ticketComplaintDescription,
    this.ticketComplaintAttachment,
    this.ticketStatus,
  });

  @override
  State<TicketRecordDetailsComponent> createState() =>
      _TicketRecordDetailsComponentState();
}

class _TicketRecordDetailsComponentState
    extends State<TicketRecordDetailsComponent> {
  List<XFile>? selectedImageList;
  int imageSelected = 0;
  PageController pageController = PageController();

  showZoomImage(BuildContext context, int index, int i) {
    pageController = PageController(initialPage: i);
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
                                    widget.ticketComplaintAttachment?.length ??
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
                                      imageProvider: NetworkImage(widget
                                              .ticketComplaintAttachment?[i] ??
                                          ""),
                                      initialScale:
                                          PhotoViewComputedScale.contained *
                                              0.85,
                                      heroAttributes: PhotoViewHeroAttributes(
                                          tag: widget.steps?[index]
                                                  .submittedPic?[i] ??
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
  void initState() {
    super.initState();
  }

  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: kMainWhiteColor, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              widget.ticketStatus == 1 ? "已审核" : "待审核",
              style: ticketRecordTextStyle,
            ),
          ),
          const SizedBox(height: 10),
          const Text("姓名", style: depositTextStyle2),
          _buildText(text: widget.ticketCustomerUsername ?? ""),
          const SizedBox(height: 15),
          const Text("电话号码", style: depositTextStyle2),
          _buildText(text: widget.ticketCustomerPhoneNum ?? ""),
          const SizedBox(height: 15),
          const Text("电子邮件", style: depositTextStyle2),
          _buildText(text: widget.ticketCustomerEmail ?? ""),
          const SizedBox(height: 15),
          const Text("日期", style: depositTextStyle2),
          _buildText(text: widget.ticketDate ?? ""),
          const SizedBox(height: 15),
          const Text("悬赏ID", style: depositTextStyle2),
          _buildText(text: (widget.taskId ?? "").toString()),
          const SizedBox(height: 15),
          const Text("被举报用户ID", style: depositTextStyle2),
          _buildText(text: (widget.complaintUserId ?? "").toString()),
          const SizedBox(height: 15),
          const Text("申述种类", style: depositTextStyle2),
          _buildText(text: widget.complaintType ?? ""),
          const SizedBox(height: 15),
          const Text("申述详情", style: depositTextStyle2),
          _buildTextFieldInput(text: widget.ticketComplaintDescription ?? ""),
        ],
      ),
    );
  }

  Widget _buildText({
    required String text,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.only(left: 12),
      height: 31,
      child: Text(
        text,
        style: ticketRecordTextStyle1,
      ),
    );
  }

  Widget _buildTextFieldInput({
    required String text,
  }) {
    final attachmentLength = widget.ticketComplaintAttachment?.length ?? 0;
    return Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.only(left: 12, bottom: 10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: ticketRecordTextStyle1,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 0, 6),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          attachmentLength,
                          (i) => GestureDetector(
                            onTap: () {
                              showZoomImage(context, 0, i);
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: 100,
                                  width: 157,
                                  margin: const EdgeInsets.fromLTRB(0, 6, 6, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color:
                                        Colors.grey, // Use your preferred color
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(
                                      widget.ticketComplaintAttachment?[i] ??
                                          "",
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: LoadingAnimationWidget
                                              .stretchedDots(
                                            color: Colors
                                                .yellow, // Use your preferred color
                                            size: 50,
                                          ),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Center(
                                          child: Text(
                                            "无法显示图片",
                                            style: TextStyle(
                                                color: Colors
                                                    .red), // Use your preferred style
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
