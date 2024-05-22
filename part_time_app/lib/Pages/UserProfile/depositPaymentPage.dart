import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:part_time_app/Components/Card/missionSubmissionCardComponent.dart';
import 'package:part_time_app/Components/Card/userDetailCardComponent.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Model/Payment/paymentModel.dart';
import '../../Components/Button/primaryButtonComponent.dart';
import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/globalConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/User/userModel.dart';
import '../../Services/payment/paymentServices.dart';
import '../../Utils/sharedPreferencesUtils.dart';

class DepositPaymentPage extends StatefulWidget {
  const DepositPaymentPage({super.key});

  @override
  State<DepositPaymentPage> createState() => _DepositPaymentPageState();
}

class _DepositPaymentPageState extends State<DepositPaymentPage> {
  final String textToCopy = "THE USDT TALALA";
  XFile? selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;
  String? username;
  DepositDetail? depositList;
  void initState() {
    super.initState();
    _loadDataFromShared();
    _loadData();
  }

  Future<void> _loadDataFromShared() async {
    setState(() {
      username = userData.username;
      print("username:${username}");
    });
  }

  Future<void> imageSelect() async {
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = pickedImage;
    });
  }

  void deleteImage() {
    setState(() {
      selectedImage = null;
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: depositList?.depositNetwork ?? ""));
  }

  Future<void> _loadData() async {
    // setState(() {
    //   isLoading = true;
    // });
    try {
      DepositDetail? data = await PaymentServices().getDepositDetail();
      // print("call the API");
      // print(data);
      setState(() {
        if (data != null && data != null) {
          print(data);
          depositList = data;
        } else {
          // Handle the case when data is null or data.data is null
        }
        isLoading = false;
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
  }

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
                  text: "发布权限",
                ))),
        body: Container(
          constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "信息填写",
                    style: depositTextStyle3,
                  ),
                ),
                UserDetailCardComponent(
                  isEditProfile: false,
                  nameInitial: userData.username,
                  countryInitial: userData.country,
                  fieldInitial: userData.businessScopeName,
                  sexInitial: userData.gender,
                  walletNetworkInitial: userData.billingNetwork,
                  walletAddressInitial: userData.billingAddress,
                ),
                Container(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "押金提交",
                    style: depositTextStyle3,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: kMainWhiteColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "支付信息 (平台)",
                        style: depositTextStyle2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "USDT 链名称：",
                              style: inputCounterTextStyle,
                            ),
                            SizedBox(height: 5),
                            Text(depositList?.depositNetwork ?? ""),
                            SizedBox(height: 5),
                            Text(
                              "USDT 链地址：",
                              style: inputCounterTextStyle,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Expanded(
                                    child:
                                        Text(depositList?.depositNetwork ?? ""),
                                  ),
                                ),
                                SizedBox(width: 50),
                                GestureDetector(
                                    onTap: _copyToClipboard,
                                    child: SvgPicture.asset(
                                        "assets/common/copy.svg",
                                        width: 15))
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: kMainWhiteColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Container(
                        child: Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "押金预付",
                                style: messageTitleTextStyle,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8, bottom: 8),
                                child: Text(
                                  "手续费 0%",
                                  style: messageTitleTextStyle,
                                ),
                              ),
                              Text(
                                "预付共计",
                                style: forgotPassSubmitTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "共记 20 USDT",
                                style: depositTextStyle3,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  child: Text(
                                    "0 USDT",
                                    style: messageTitleTextStyle,
                                  )),
                              Text(
                                "20 USDT",
                                style: forgotPassSubmitTextStyle,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: kMainWhiteColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    "请支付押金至以上支付地址并截图上传已获得发布权限。(7天审核时间，7天后将自动审核成功)",
                    style: searchBarTextStyle,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: kMainWhiteColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          "请上传支付押金截图",
                          style: onboradingPageTextStyle,
                        ),
                      ),
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              imageSelect();
                            },
                            child: Container(
                                height: 300,
                                width: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: selectedImage != null
                                      ? null
                                      : Colors.transparent,
                                  image: selectedImage != null
                                      ? DecorationImage(
                                          image: FileImage(
                                              File(selectedImage!.path)),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: selectedImage == null
                                    ? Center(
                                        child: SvgPicture.asset(
                                          "assets/common/addDeposit.svg",
                                          height: 300,
                                          width: 300,
                                        ),
                                      )
                                    : null),
                          ),
                          if (selectedImage != null)
                            Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: deleteImage,
                                color: Colors.red,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        height: 47,
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: kInputBackGreyColor,
                            hintText: "请输入URL",
                            hintStyle: paymentHistoryTextStyle3,
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            labelStyle: depositTextStyle2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
              isLoading: isLoading,
              text: "确认提交",
              buttonColor: kMainYellowColor,
              textStyle: buttonTextStyle,
              onPressed: () {
                setState(() {
                  print("here:" + nameController.text);
                  print("here:" + sexController.text);
                  isLoading =
                      true; // Set isLoading to true when the button is pressed
                });

                // Simulate some asynchronous task
                Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    isLoading =
                        false; // Set isLoading to false after the task is complete
                    Get.back();
                    Fluttertoast.showToast(
                      msg: "已提交",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: kMainGreyColor,
                      textColor: kThirdGreyColor,
                    );
                  });
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
