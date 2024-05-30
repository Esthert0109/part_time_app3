import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:part_time_app/Components/Card/missionSubmissionCardComponent.dart';
import 'package:part_time_app/Components/Card/userDetailCardComponent.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Model/Payment/paymentModel.dart';
import '../../Components/Button/primaryButtonComponent.dart';
import '../../Components/Dialog/paymentUploadDialogComponent.dart';
import '../../Components/Status/statusDialogComponent.dart';
import '../../Components/Title/thirdTitleComponent.dart';
import '../../Constants/globalConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Services/Upload/uploadServices.dart';
import '../../Services/payment/paymentServices.dart';

class DepositPaymentPage extends StatefulWidget {
  const DepositPaymentPage({super.key});

  @override
  State<DepositPaymentPage> createState() => _DepositPaymentPageState();
}

class _DepositPaymentPageState extends State<DepositPaymentPage> {
  XFile? selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;
  bool isUploadLoading = false;
  String? username;
  String? customerId;

  DepositDetail? depositList;
  void initState() {
    super.initState();
    _loadDataFromShared();
    _loadData();
  }

  Future<void> _loadDataFromShared() async {
    setState(() {
      username = userData?.username;
      customerId = userData?.customerId;
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
      payment = null;
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: depositList?.depositNetwork ?? ""));
    Fluttertoast.showToast(
        msg: "已复制",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: kMainGreyColor,
        textColor: kThirdGreyColor);
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
                uploadedPaymentSS = "";
                payment = null;
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
                  nameInitial: userData?.username,
                  countryInitial: userData?.country,
                  fieldInitial: userData?.businessScopeId,
                  sexInitial: userData?.gender,
                  walletNetworkInitial: userData?.billingNetwork,
                  walletAddressInitial: userData?.billingAddress,
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
                              onTap: () async {
                                uploadedPayment = await imagePicker.pickImage(
                                    source: ImageSource.gallery);
                                setState(() {
                                  payment = File(uploadedPayment!.path);
                                  isUploadLoading = true;
                                });
                                try {
                                  if (payment != null) {
                                    String? uploaded = await UploadServices()
                                        .uploadDeposit(payment!);

                                    if (uploaded != null) {
                                      Fluttertoast.showToast(
                                          msg: "已上传",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: kMainGreyColor,
                                          textColor: kThirdGreyColor);

                                      setState(() {
                                        isUploadLoading = false;
                                        uploadedPaymentSS = uploaded;
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
                              },
                              child: Container(
                                height: 300,
                                width: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.transparent,
                                  image: payment != null
                                      ? DecorationImage(
                                          image:
                                              NetworkImage(uploadedPaymentSS),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: payment == null
                                    ? Center(
                                        child: SvgPicture.asset(
                                          "assets/common/addDeposit.svg",
                                          height: 300,
                                          width: 300,
                                        ),
                                      )
                                    : isUploadLoading
                                        ? Center(
                                            child: LoadingAnimationWidget
                                                .stretchedDots(
                                              color: kMainYellowColor,
                                              size: 50,
                                            ),
                                          )
                                        : null,
                              )),
                          if (payment != null)
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
                          controller: usdtLinkControllerPayment,
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
              isLoading:
                  isLoading, // isLoading is a boolean variable indicating whether the request is in progress
              text: "确认提交",
              buttonColor: kMainYellowColor,
              textStyle: buttonTextStyle,
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                bool validatePaymentDetail(PaymentDetail paymentDetail) {
                  if (paymentDetail.paymentFromCustomerId == null ||
                      paymentDetail.paymentFromCustomerId!.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "用户ID不能为空",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: kMainRedColor,
                        textColor: kThirdGreyColor);
                    if (mounted) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                    return false;
                  }
                  if (paymentDetail.paymentUsername == null ||
                      paymentDetail.paymentUsername!.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "真实姓名不能为空",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: kMainRedColor,
                        textColor: kThirdGreyColor);
                    return false;
                  }
                  if (paymentDetail.paymentBillingAddress == null ||
                      paymentDetail.paymentBillingAddress!.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "收款地址不能为空",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: kMainRedColor,
                        textColor: kThirdGreyColor);
                    return false;
                  }
                  if (paymentDetail.paymentBillingNetwork == null ||
                      paymentDetail.paymentBillingNetwork!.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "收款网路不能为空",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: kMainRedColor,
                        textColor: kThirdGreyColor);
                    return false;
                  }
                  if (paymentDetail.paymentBillingUrl == null ||
                      paymentDetail.paymentBillingUrl!.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "收款链接不能为空",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: kMainRedColor,
                        textColor: kThirdGreyColor);
                    if (mounted) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                    return false;
                  }
                  return true;
                }

                try {
                  setState(() {
                    DateTime now = DateTime.now();
                    String submitDate = now.toIso8601String();
                    PaymentDetail? paymentDetailForPay = PaymentDetail(
                      paymentFromCustomerId: customerId,
                      paymentType: 0,
                      paymentStatus: 0,
                      paymentToCustomerId: "admin",
                      paymentToCustomerName: "admin",
                      paymentUsername: nameControllerPayment.text,
                      paymentBillingAddress:
                          walletAddressControllerPayment.text,
                      paymentBillingNetwork:
                          walletNetworkControllerPayment.text,
                      paymentBillingCurrency: "USDT",
                      paymentBillingImage: uploadedPaymentSS,
                      paymentBillingUrl: usdtLinkControllerPayment!.text,
                      paymentAmount: 20,
                      paymentFee: 0,
                      paymentTotalAmount: 20,
                      paymentCreatedTime: submitDate,
                    );

                    if (validatePaymentDetail(paymentDetailForPay)) {
                      PaymentServices paymentServices = PaymentServices();
                      paymentServices
                          .createDeposit(paymentDetailForPay)
                          .then((success) {
                        if (success != null && success) {
                          print("Submitted success");
                          setState(() {
                            uploadedPaymentSS = "";
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatusDialogComponent(
                                  complete: true,
                                  successText: "系统将审核你的支付押金，审核通过后将发布该悬赏。",
                                  onTap: () {
                                    Navigator.pop(context);
                                    Get.offAllNamed('/home');
                                  },
                                );
                              },
                            );
                          });
                        } else {
                          print("Submitted FAILED");
                          Fluttertoast.showToast(
                              msg: "提交失败，请稍后重试",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: kMainRedColor,
                              textColor: kThirdGreyColor);
                          if (mounted) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }

                        setState(() {
                          isLoading = false;
                        });
                      });
                    }
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
                if (mounted) {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
