import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:part_time_app/Components/Card/missionDetailDescriptionCardComponent.dart';
import 'package:part_time_app/Components/Card/missionDetailIssuerCardComponent.dart';
import 'package:part_time_app/Components/Card/missionPublishCheckoutCardComponent.dart';
import 'package:part_time_app/Components/Card/paymentMessageCardComponent.dart';
import 'package:part_time_app/Components/Card/testCardComponent.dart';
import 'package:part_time_app/Components/Dialog/rejectReasonDialogComponent.dart';
import 'package:part_time_app/Components/Message/messageCardComponent.dart';
import 'package:part_time_app/Components/Status/primaryStatusResponseComponent.dart';
import 'package:part_time_app/Components/Status/statusDialogComponent.dart';

class ExploreMainPage extends StatefulWidget {
  const ExploreMainPage({super.key});

  @override
  State<ExploreMainPage> createState() => _ExploreMainPageState();
}

class _ExploreMainPageState extends State<ExploreMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Divider(),
              Text("Mission Publish Checkout Component:"),
              SizedBox(height: 20),
              MissionPublishCheckoutCardComponent(isSubmit: false),
              SizedBox(height: 10),
              Divider(),
              Text("Mission Detail Description Component:"),
              SizedBox(height: 20),
              MissionDetailDescriptionCardComponent(
                  title: "文案写作文案写作文",
                  detail:
                      "负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公",
                  tag: "#写作 #长期 #写作 #长期#写作 #长期 #写作 #长期 #写作 #写作 #长期 #写作 ",
                  totalSlot: "50",
                  leaveSlot: "49",
                  day: "10",
                  duration: "24",
                  date: "2023.12.01",
                  price: "500000"),
              SizedBox(height: 10),
              Divider(),
              Text("Mission Detail Description Component:"),
              SizedBox(height: 20),
              MissionDetailIssuerCardComponent(
                image:
                    "https://t4.ftcdn.net/jpg/02/66/72/41/360_F_266724172_Iy8gdKgMa7XmrhYYxLCxyhx6J7070Pr8.jpg",
                title: "约稿投稿平台",
                action: "留言质询>",
                onTap: () {
                  print("touch the Talala");
                },
              ),
              SizedBox(height: 10),
              Divider(),
              Text("Primary Status Response Component:"),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    PrimaryStatusBottomSheetComponent.show(
                      context,
                      //true for need button, false for no need.
                      false,
                    );
                  },
                  child: Text("验证码")),
              SizedBox(height: 10),
              Divider(),
              Text("Primary Status Response Component:"),
              SizedBox(height: 20),
              MessageCardComponent(
                systemDetail: "2.0版本已更新2.0版本已更新2.0版本已更新2.0版本已更新2.0版本已更新",
                systemDate: "08.06",
                systemTotalMessage: 300,
                missionDetail: "您向用户“约稿投稿”提交的任务正在审核中..核核核.",
                missionDate: "08.09",
              ),
              SizedBox(height: 10),
              Divider(),
              Text("Payment Message Card Componentt:"),
              SizedBox(height: 20),
              PaymentMessageCardComponent(
                  title: "标题标题标题标题标题", price: "0.05", bUser: "B用户"),
              SizedBox(height: 10),
              Divider(),
              Text("Reject Reason Dialog Component:"),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return RejectReasonDialogComponent();
                      },
                    );
                  },
                  child: Text("验证码")),
              SizedBox(height: 10),
              Divider(),
              Text("Status Dialog Component:"),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatusDialogComponent(complete: true);
                      },
                    );
                  },
                  child: Text("验证码")),
              SizedBox(height: 10),
              Divider(),
            ],
          ),
        ));
  }
}
