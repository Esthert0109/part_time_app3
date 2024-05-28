import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:part_time_app/Components/Button/primaryButtonComponent.dart';
import 'package:part_time_app/Components/Card/ticketSubmissionComponent.dart';
import 'package:part_time_app/Components/Card/userDetailCardComponent.dart';
import 'package:part_time_app/Components/Loading/editProfilePageLoading.dart';
import 'package:part_time_app/Components/Title/secondaryTitleComponent.dart';
import 'package:part_time_app/Components/Title/thirdTitleComponent.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/globalConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';
import 'package:part_time_app/Model/Ticketing/ticketingModel.dart';
import '../../Components/Status/statusDialogComponent.dart';
import '../../Services/ticketing/ticketingServices.dart';

class TicketSubmissionPage extends StatefulWidget {
  final int? reportTaskIDInitial;
  final String? reportUserIDInitial;
  final int? complainType;

  const TicketSubmissionPage(
      {super.key,
      this.reportTaskIDInitial,
      this.reportUserIDInitial,
      this.complainType});

  @override
  State<TicketSubmissionPage> createState() => _TicketSubmissionPageState();
}

final ImagePicker _picker = ImagePicker();

class _TicketSubmissionPageState extends State<TicketSubmissionPage> {
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool isUploadLoading = false;
  String? username;
  String? customerId;
  String? phoneNumber;
  String? email;
  String iso8601Date = "";

  @override
  void initState() {
    super.initState();
    _loadDataFromShared();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadDataFromShared() async {
    setState(() {
      username = userData.username;
      customerId = userData.customerId;
      phoneNumber = userData.firstPhoneNo;
      email = userData.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kTextTabBarHeight),
          child: AppBar(
            leading: IconButton(
              icon: SvgPicture.asset(
                "assets/common/arrow_back.svg",
                // height: 58,
                // width: 58,
              ),
              onPressed: () {
                uploadedImagesListSS!.clear();
                Navigator.pop(context);
              },
            ),
            flexibleSpace: Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    kBackgroundFirstGradientColor,
                    kBackgroundSecondGradientColor
                  ],
                  stops: [0.5, 1.0],
                ),
              ),
            ),
            backgroundColor: const Color(0xFFF9F9F9),
            title: const thirdTitleComponent(
              text: '工单',
            ),
            centerTitle: true,
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TicketSubmissionComponent(
                    isEdit: true,
                    nameInitial: username,
                    phoneNumberInitial: phoneNumber,
                    emailInitial: email,
                    reportUserIDInitial: widget.reportUserIDInitial,
                    reportTaskIDInitial: widget.reportTaskIDInitial.toString(),
                    ticketType: widget.complainType,
                  ),
                ),
              ],
            ))),
            Material(
              elevation: 20,
              child: Container(
                  padding: const EdgeInsets.only(
                      bottom: 50, left: 10, right: 10, top: 5),
                  decoration: const BoxDecoration(color: kMainWhiteColor),
                  width: double.infinity,
                  child: primaryButtonComponent(
                    text: "提交",
                    onPressed: () async {
                      setState(() {
                        print(ticketSubmssionDate);
                        DateTime now = DateTime.now();
                        iso8601Date = now.toIso8601String();
                        isLoading = true;
                      });
                      try {
                        TicketingData? ticketToSubmit = TicketingData(
                            customerId: customerId,
                            ticketCustomerUsername: username,
                            ticketCustomerPhoneNum: phoneNumber,
                            ticketCustomerEmail: email,
                            ticketDate: iso8601Date,
                            taskId: widget.reportTaskIDInitial,
                            complaintTypeId: widget.complainType! + 1,
                            complaintUserId: widget.reportUserIDInitial,
                            ticketComplaintDescription:
                                fieldControllerTicket.text,
                            ticketComplaintAttachment: uploadedImagesListSS);

                        TicketingService ticketingService = TicketingService();
                        ticketingService
                            .createTicket(ticketToSubmit)
                            .then((success) {
                          // Handle success or failure accordingly
                          if (success != null && success) {
                            print("Submitted success");
                            setState(() {
                              uploadedImagesListSS = [];
                              ticketToSubmit = null;
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatusDialogComponent(
                                    complete: true,
                                    successText: "系统将审核你的工单，审核通过后将通知你。",
                                    onTap: () {
                                      Navigator.pop(context);
                                      Get.offAllNamed('/home');
                                    },
                                  );
                                },
                              );
                            });
                          } else {
                            print(success);
                            print("Submitted FAILED");
                          }

                          setState(() {
                            isLoading =
                                false; // Set loading state back to false after request is completed
                          });
                        });
                      } catch (e) {
                        print("Error: $e");
                        // Handle error
                        if (mounted) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                    buttonColor: kMainYellowColor,
                    textStyle: missionCheckoutTotalPriceTextStyle,
                    isLoading: false,
                  )),
            )
          ],
        ));
  }
}
