import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Button/primaryButtonComponent.dart';
import 'package:part_time_app/Components/TextField/secondaryTextFieldComponent.dart';
import 'package:part_time_app/Pages/MissionStatus/missionReviewDetailPage.dart';
import 'package:part_time_app/Services/User/userServices.dart';

import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/User/userModel.dart';
import '../../Services/order/orderServices.dart';

class RecipientInfoPage extends StatefulWidget {
  final int taskId;
  const RecipientInfoPage({super.key, required this.taskId});

  @override
  State<RecipientInfoPage> createState() => _RecipientInfoPageState();
}

class _RecipientInfoPageState extends State<RecipientInfoPage> {
  TextEditingController addressController = TextEditingController();
  TextEditingController networkController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // service
  UserServices services = UserServices();
  OrderServices orderServices = OrderServices();
  UserData? userInfo;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0.0,
            leading: IconButton(
              iconSize: 15,
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Get.back();
              },
            ),
            centerTitle: true,
            title: Container(
                color: kTransparent,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: thirdTitleComponent(
                  text: "信息填写",
                ))),
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
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: kMainWhiteColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        "钱包地址",
                        style: messageText1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: secondaryTextFieldComponent(
                        hintText: "USDT地址",
                        inputController: addressController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '请输入地址';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        "NETWORK名称",
                        style: messageText1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: secondaryTextFieldComponent(
                        hintText: "Network地址",
                        inputController: networkController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '请输入地址';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        "货币",
                        style: messageText1,
                      ),
                    ),
                    Text(
                      "USDT",
                      style: splashScreenTextStyle,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 84,
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(color: kMainWhiteColor, boxShadow: [
            BoxShadow(
              color: Color(0x1A000000),
              offset: Offset(1, 0),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ]),
          child: SizedBox(
            width: double.infinity,
            child: primaryButtonComponent(
              isLoading: false,
              text: "提交",
              buttonColor: kMainYellowColor,
              textStyle: buttonTextStyle,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    userInfo = UserData(
                        billingAddress: addressController.text,
                        billingNetwork: networkController.text);
                  });
                  try {
                    CheckOTPModel? model = await services.updateUSDT(userInfo!);
                    if (model!.data!) {
                      int? create =
                          await orderServices.createOrder(widget.taskId!);
                      Get.off(() => MissionReviewDetailPage(isCompleted: false),
                          transition: Transition.rightToLeft);

                      Fluttertoast.showToast(
                          msg: "已提交",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: kMainGreyColor,
                          textColor: kThirdGreyColor);
                    } else {
                      Fluttertoast.showToast(
                          msg: "提交失败",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: kErrorRedColor,
                          textColor: kMainWhiteColor);
                    }
                  } on Exception catch (e) {
                    // TODO
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
