import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../Button/secondaryButtonComponent.dart';
import '../Status/statusDialogComponent.dart';

XFile? uploadedPayment;
String payment = "";
final ImagePicker imagePicker = ImagePicker();

class PaymentUploadDialogComponent extends StatefulWidget {
  const PaymentUploadDialogComponent({super.key});

  @override
  State<PaymentUploadDialogComponent> createState() =>
      _PaymentUploadDialogComponentState();
}

class _PaymentUploadDialogComponentState
    extends State<PaymentUploadDialogComponent> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(6),
        width: 351,
        height: 467,
        decoration: BoxDecoration(
          color: kMainWhiteColor,
          borderRadius: BorderRadius.circular(4),
        ),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
              child: GestureDetector(
                onTap: () async {
                  uploadedPayment =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    payment = uploadedPayment!.path;
                    print("check:$payment");
                    print("check:${payment.isEmpty}");
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return PaymentUploadDialogComponent();
                        });
                  });
                },
                child: payment == ""
                    ? SvgPicture.asset(
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            payment!,
                            width: 291,
                            height: 300,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                  child: LoadingAnimationWidget.stretchedDots(
                                      color: kMainYellowColor, size: 50));
                            },
                            errorBuilder: (context, error, stackTrace) {
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
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: secondaryButtonComponent(
                text: '提交',
                buttonColor: kMainYellowColor,
                textStyle: dialogText2,
                onPressed: payment.isEmpty
                    ? null
                    : () {
                        setState(() {
                          Navigator.pop(context);
                          payment = "";
                          uploadedPayment = XFile("");
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
                      },
              ),
            )
          ],
        ),
      ),
    );
  }
}
