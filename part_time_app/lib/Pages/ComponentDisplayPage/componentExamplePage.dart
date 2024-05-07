import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:part_time_app/Components/Loading/missionCardLoading.dart';
import 'package:part_time_app/Components/Button/primaryButtonComponent.dart';
import 'package:part_time_app/Pages/MissionIssuer/missionPublishMainPage.dart';

import '../../Components/Card/missionCardComponent.dart';
import '../../Components/Card/missionMessageCardComponent.dart';
import '../../Components/Card/missionReviewRecipientCardComponent.dart';
import '../../Components/Card/missionSubmissionCardComponent.dart';
import '../../Components/Card/ticketingCardComponent.dart';
import '../../Components/Dialog/alertDialogComponent.dart';
import '../../Components/SearchBar/searchBarComponent.dart';
import '../../Components/Selection/primaryTagSelectionComponent.dart';
import '../../Components/Selection/secondaryCategorySelectionComponent.dart';
import '../../Components/Selection/thirdStatusSelectionComponent.dart';
import '../../Components/Title/secondaryTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import 'package:part_time_app/Components/Card/missionDetailDescriptionCardComponent.dart';
import 'package:part_time_app/Components/Card/missionDetailIssuerCardComponent.dart';
import 'package:part_time_app/Components/Card/missionPublishCheckoutCardComponent.dart';
import 'package:part_time_app/Components/Card/paymentMessageCardComponent.dart';
import 'package:part_time_app/Components/Dialog/rejectReasonDialogComponent.dart';
import 'package:part_time_app/Components/Message/messageCardComponent.dart';
import 'package:part_time_app/Components/Status/primaryStatusResponseComponent.dart';
import 'package:part_time_app/Components/Status/statusDialogComponent.dart';

class ComponentExample extends StatefulWidget {
  const ComponentExample({super.key});

  @override
  State<ComponentExample> createState() => _ComponentExampleState();
}

Map<String, dynamic> sorts = {
  "工作期限": [
    {1, '短期'},
    {2, '长期'}
  ],
  "工作内容": [
    {3, '写作'},
    {4, '录入'},
    {5, '游戏'},
    {6, '发帖'},
    {7, '网页设计'},
    {8, '平面设计'}
  ],
  "工作性质": [
    {9, '新任务'},
    {10, '易审核'},
    {11, '高悬赏'}
  ],
};

class _ComponentExampleState extends State<ComponentExample> {
  int selectIndex = 0;
  List<String> selectedCategory = [];
  bool isSelected = false;
  final _formKey = GlobalKey<FormState>();
  String price = "";
  String selectedDurationUnit = "";
  String selectedEndUnit = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SecondaryTitleComponent(
                titleList: ["推荐", "收藏", "我接收的", "我发布的", "发布悬赏"],
                selectedIndex: selectIndex,
                onTap: (index) {
                  setState(() {
                    selectIndex = index;
                  });
                },
              ),
              ThirdStatusSelectionComponent(
                statusList: ["待完成", "待审核", "未通过", "待到账", "已到账", "已退款"],
                selectedIndex: selectIndex,
                onTap: (index) {
                  setState(() {
                    selectIndex = index;
                  });
                },
              ),
              Row(
                children: [
                  Expanded(
                      flex: 8,
                      child: PrimaryTagSelectionComponent(
                        tagList: ["全部", "价格降序", "价格升序", "价格升序", "价格升序"],
                        selectedIndex: selectIndex,
                        onTap: (index) {
                          setState(() {
                            selectIndex = index;
                          });
                        },
                      )),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "64条相关",
                      style: unselectedTagTextStyle,
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
              const SearchBarComponent(),
              MissionReviewRecipientCardComponent(
                isReviewing: false,
                isCompleted: false,
                duration: "48:00:00",
                userAvatar:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkGXX7KS0tl9-flc6R2PR8D_2qHR-baQXsmeAGWix4pg&s',
                username: '新鲜哥',
              ),
              MissionReviewRecipientCardComponent(
                isReviewing: true,
                isCompleted: false,
                duration: "48:00:00",
                userAvatar:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNaT5SvBkYftSASmuj1yAmOFONXoWFqRlJ0mO7ZI_njw&s',
                username: '微笑姐',
              ),
              MissionReviewRecipientCardComponent(
                isReviewing: false,
                isCompleted: true,
                duration: "48:00:00",
                userAvatar:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkGXX7KS0tl9-flc6R2PR8D_2qHR-baQXsmeAGWix4pg&s',
                username: '新鲜哥',
              ),
              MissionCardComponent(
                missionTitle: '文案写作文案写作文文案写作文案写作文文案写作文案写作文',
                missionDesc:
                    '负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写，负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写，负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写，负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写，负责公司各类宣传方案的策划，宣传文案，新闻稿件活动方案等文案的撰写',
                tagList: ["写作", "写作", "写作", "写作", "写作", "写作", "写作", "写作"],
                missionPrice: 886222.51,
                userAvatar:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNaT5SvBkYftSASmuj1yAmOFONXoWFqRlJ0mO7ZI_njw&s",
                username: "微笑姐微笑姐",
                missionDate: "2024-04-29",
                isStatus: true,
                isFavorite: false,
                missionStatus: 0,
              ),
              MissionSubmissionCardComponent(
                submissionPics: [
                  "https://qph.cf2.quoracdn.net/main-qimg-606d28746f1e0115cb4e043e321b9501-lq",
                  "https://www.digitaltrends.com/wp-content/uploads/2018/08/screenshot_20200507-124725_settings.jpg?fit=1080%2C2400&p=1",
                  "https://qna.smzdm.com/202302/08/63e37a1b58c238447.jpg_e1080.jpg",
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGutWfApTFtuVCIENR5EUgr4QtkrrEYeeVqrAA7qrhKg&s",
                  "https://p9-pc-sign.douyinpic.com/image-cut-tos-priv/6a709835de6890caa16f8b48a26c1f94~tplv-dy-resize-origshort-autoq-75:330.jpeg?x-expires=2029204800&x-signature=E4qvBWyLDjKqKyApep51PJidq8Q%3D&from=3213915784&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=20240423121342A2500492FD1762012DBB",
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRySQFxddtDb33k6xrkiIeVe6j3Hko6WLhEIurtPKjCVQ&s"
                ],
                isEdit: true,
                isCollapsed: true,
                isCollapseAble: true,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialogComponent(
                          alertTitle: '提交前请检查',
                          alertDesc: RichText(
                            text: TextSpan(
                              style: alertDialogContentTextStyle,
                              children: [
                                TextSpan(text: '是否从相册选择了正确的截图\n'),
                                TextSpan(
                                  text: '截图是否符合悬赏要求\n\n',
                                ),
                                TextSpan(text: '提交后将无法修改\n'),
                                TextSpan(
                                  text: '恶意提交将受到禁止报名/永久封号等惩罚。',
                                )
                              ],
                            ),
                          ),
                          descTextStyle: alertDialogContentTextStyle,
                          firstButtonText: '檢查一下',
                          firstButtonTextStyle: alertDialogFirstButtonTextStyle,
                          firstButtonColor: kThirdGreyColor,
                          secondButtonText: '確認無誤馬上提交',
                          secondButtonTextStyle:
                              alertDialogSecondButtonTextStyle,
                          secondButtonColor: kMainYellowColor,
                          isButtonExpanded: false,
                          firstButtonOnTap: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          secondButtonOnTap: () {},
                        );
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "打开我",
                    style: missionPriceTextStyle,
                  ),
                ),
              ),
              MissionMessageCardComponent(
                messageTitle: '悬赏预付赏金成功支付!',
                messageDesc: '您已预付200USDT的赏金至悬赏 [标题] 。',
                onTap: () {
                  setState(() {
                    Get.to(() => MissionPublishMainPage());
                    print("click");
                  });
                },
              ),
              // SecondaryCategorySelectionComponent(
              //   sorts: sorts,
              // ),
              TicketingCardComponent(
                ticketTitle: '举报 -- 工单 举报 -- 工单 举报 -- 工单 举报 -- 工单',
                ticketDesc: '举报类型工单已成功提交举报类型工单已成功提交举报类型工单已成功提交',
                ticketStatus: 0,
              ),
              Divider(),
              Text("Mission Publish Checkout Component:"),
              SizedBox(height: 20),
              MissionPublishCheckoutCardComponent(
                isSubmit: true,
                priceInitial: "1000",
              ),
              SizedBox(height: 10),
              Divider(),
              Text("Mission Detail Description Component:"),
              SizedBox(height: 20),
              MissionDetailDescriptionCardComponent(
                title: "文案写作文案写作文",
                detail:
                    "负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公负责公",
                tag: ["写作", "写作", "写作", "写作"],
                totalSlot: "50",
                leaveSlot: "49",
                day: "10",
                duration: "24",
                date: "2023.12.01",
                price: "500000",
              ),
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
              primaryButtonComponent(
                text: "验证码",
                onPressed: () {
                  PrimaryStatusBottomSheetComponent.show(
                    context,
                    //true for need button, false for no need.
                    false,
                  );
                },
                buttonColor: kMainYellowColor,
                textStyle: buttonTextStyle,
              ),
              SizedBox(height: 10),
              primaryButtonComponent(
                text: "密码修改成功",
                onPressed: () {
                  PrimaryStatusBottomSheetComponent.show(
                    context,
                    //true for need button, false for no need.
                    true,
                  );
                },
                buttonColor: kMainYellowColor,
                textStyle: buttonTextStyle,
              ),
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
              primaryButtonComponent(
                text: "拒绝理由",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return RejectReasonDialogComponent();
                    },
                  );
                },
                buttonColor: kMainYellowColor,
                textStyle: buttonTextStyle,
              ),
              SizedBox(height: 10),
              Divider(),
              Text("Status Dialog Component:"),
              SizedBox(height: 20),
              primaryButtonComponent(
                text: "提交成功",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatusDialogComponent(
                        complete: true,
                        onTap: () {},
                      );
                    },
                  );
                },
                buttonColor: kMainYellowColor,
                textStyle: buttonTextStyle,
              ),
              SizedBox(height: 10),
              primaryButtonComponent(
                text: "继续编辑",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatusDialogComponent(
                        complete: false,
                        onTap: () {},
                      );
                    },
                  );
                },
                buttonColor: kMainYellowColor,
                textStyle: alertDialogSecondButtonTextStyle,
              ),
              SizedBox(height: 10),
              Divider(),
              Text("Status Dialog Component:"),
              SizedBox(height: 20),
              MissionCardLoadingComponent(),
              SizedBox(height: 10),
              Divider(),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      MissionPublishCheckoutCardComponent(
                        isSubmit: false,
                      ),
                      primaryButtonComponent(
                          text: "提交",
                          onPressed: () {
                            setState(() {
                              selectedDurationUnit = selectedDuration;
                              selectedEndUnit = selectedEndTime;
                              print(selectedDurationUnit);
                              print(selectedEndUnit);
                            });
                          },
                          textStyle: missionDetailText1)
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
