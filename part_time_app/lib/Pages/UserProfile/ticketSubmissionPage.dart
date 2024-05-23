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

class TicketSubmissionPage extends StatefulWidget {
  const TicketSubmissionPage({super.key});

  @override
  State<TicketSubmissionPage> createState() => _TicketSubmissionPageState();
}

final ImagePicker _picker = ImagePicker();

class _TicketSubmissionPageState extends State<TicketSubmissionPage> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
                    nameInitial: userData.username,
                    phoneNumberInitial: userData.firstPhoneNo,
                    emailInitial: userData.email,
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
                    onPressed: () {
                      setState(() {
                        print("here:" + nameControllerTicket.text);
                        print("here:" + phoneNumControllerTicket.text);
                      });
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
