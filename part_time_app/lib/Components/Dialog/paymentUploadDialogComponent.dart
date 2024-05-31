import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:part_time_app/Components/TextField/secondaryTextFieldComponent.dart';
import 'package:part_time_app/Model/Task/missionClass.dart';
import 'package:part_time_app/Services/Payment/paymentServices.dart';
import 'package:part_time_app/Services/Upload/uploadServices.dart';
import 'package:part_time_app/Services/order/orderServices.dart';

import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../Button/secondaryButtonComponent.dart';
import '../Status/statusDialogComponent.dart';

XFile? uploadedPayment;
File? payment;
String uploadedPaymentSS = "";
final ImagePicker imagePicker = ImagePicker();

class PaymentUploadDialogComponent extends StatefulWidget {
  final OrderData orderDetails;
  const PaymentUploadDialogComponent({super.key, required this.orderDetails});

  @override
  State<PaymentUploadDialogComponent> createState() =>
      _PaymentUploadDialogComponentState();
}

class _PaymentUploadDialogComponentState
    extends State<PaymentUploadDialogComponent> {
  final TextEditingController urlController = TextEditingController();

  bool isUploadLoading = false;
  UploadServices uploadServices = UploadServices();
  PaymentServices paymentServices = PaymentServices();
  OrderServices orderServices = OrderServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: LayoutBuilder(builder: ((context, constraints) {
        return Container(
          padding: const EdgeInsets.all(6),
          width: 351,
          height: 528,
          decoration: BoxDecoration(
            color: kMainWhiteColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      "assets/common/close3.svg",
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
                Text(
                  "请上传赏金预付截图",
                  style: dialogText2,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
                  child: GestureDetector(
                    onTap: () async {
                      uploadedPayment = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      setState(() {
                        payment = File(uploadedPayment?.path ?? "");
                        isUploadLoading = true;
                      });

                      try {
                        if (payment != null) {
                          String? uploaded =
                              await uploadServices.uploadDeposit(payment!);

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

                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return PaymentUploadDialogComponent(
                              orderDetails: widget.orderDetails,
                            );
                          });
                    },
                    child: uploadedPaymentSS == ""
                        ? isUploadLoading
                            ? Container(
                                height: 300,
                                width: 291,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: kThirdGreyColor),
                                child: Center(
                                  child: LoadingAnimationWidget.stretchedDots(
                                      color: kMainYellowColor, size: 50),
                                ),
                              )
                            : SvgPicture.asset(
                                "assets/mission/upload.svg",
                                width: 291,
                                height: 300,
                              )
                        : Container(
                            height: 300,
                            width: 291,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: kThirdGreyColor),
                            child: isUploadLoading
                                ? Center(
                                    child: LoadingAnimationWidget.stretchedDots(
                                        color: kMainYellowColor, size: 50),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(
                                      fit: BoxFit.cover,
                                      uploadedPaymentSS!,
                                      width: 291,
                                      height: 300,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                            child: LoadingAnimationWidget
                                                .stretchedDots(
                                                    color: kMainYellowColor,
                                                    size: 50));
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
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
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  child: secondaryTextFieldComponent(
                      hintText: "请输入URL",
                      inputController: urlController,
                      validator: (value) {}),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: secondaryButtonComponent(
                    text: '提交',
                    buttonColor: kMainYellowColor,
                    textStyle: dialogText2,
                    onPressed: uploadedPaymentSS.isEmpty
                        ? null
                        : () async {
                            try {
                              bool? create =
                                  await paymentServices.createPayment(
                                      widget.orderDetails,
                                      uploadedPaymentSS,
                                      urlController.text);

                              if (create!) {
                                bool? task = await orderServices
                                    .submitTask(widget.orderDetails.taskId!);

                                if (task!) {
                                  setState(() {
                                    uploadedPaymentSS = "";
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatusDialogComponent(
                                          complete: true,
                                          successText: "系统将审核你的内容，审核通过后将发布该悬赏。",
                                          onTap: () {
                                            Navigator.pop(context);
                                            Get.offAllNamed('/home');
                                          },
                                        );
                                      },
                                    );
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "发布失败，请询问客服",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: kMainGreyColor,
                                      textColor: kThirdGreyColor);
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "提交失败，请重试",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: kMainGreyColor,
                                    textColor: kThirdGreyColor);
                              }
                            } catch (e) {
                              Fluttertoast.showToast(
                                  msg: "$e",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: kMainGreyColor,
                                  textColor: kThirdGreyColor);
                            }
                          },
                  ),
                )
              ],
            ),
          ),
        );
      })),
    );
  }
}
