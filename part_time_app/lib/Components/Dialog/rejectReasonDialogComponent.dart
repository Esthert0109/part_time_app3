import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Components/Button/primaryButtonComponent.dart';
import 'package:part_time_app/Services/order/orderServices.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../Button/secondaryButtonComponent.dart';

class RejectReasonDialogComponent extends StatefulWidget {
  final int orderId;
  const RejectReasonDialogComponent({super.key, required this.orderId});

  @override
  State<RejectReasonDialogComponent> createState() =>
      _RejectReasonDialogComponentState();
}

class _RejectReasonDialogComponentState
    extends State<RejectReasonDialogComponent> {
  int _selectedIndex = 0;
  bool _showTextField = false;
  List<String> buttonLabels = ['未根据指示完成任务', '恶意提交', '内容不完整', '其他'];
  String rejectReason = "";
  TextEditingController reasonController = TextEditingController();

  // Services
  OrderServices services = OrderServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          width: 351,
          height: _showTextField ? 500 : 400,
          decoration: BoxDecoration(
            color: kMainWhiteColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 15, top: 15),
                child: Text(
                  "拒绝任务理由",
                  style: dialogText1,
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                height: 220, // Adjust the height as per your requirement
                child: ListView.builder(
                  itemCount: buttonLabels.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        buttonLabels[index],
                        style: missionDetailText6,
                      ),
                      trailing: _selectedIndex == index
                          ? SvgPicture.asset("assets/button/selectedButton.svg")
                          : SvgPicture.asset(
                              "assets/button/unselectedButton.svg"),
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                          _showTextField = index == buttonLabels.length - 1;
                          if (!_showTextField) {
                            rejectReason = buttonLabels[_selectedIndex];
                          }
                        });
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 8),
              _showTextField
                  ? Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      width: 291,
                      height: 100,
                      decoration: BoxDecoration(
                        color: kDialogInputColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: TextField(
                        controller: reasonController,
                        style: missionCheckoutHintTextStyle,
                        maxLines: null,
                        maxLength: 200,
                        onChanged: (value) {
                          setState(() {
                            rejectReason = value;
                          });
                        },
                        decoration: InputDecoration(
                          counterText: "",
                          hintText: "请输入拒绝理由",
                          hintStyle: missionDetailText2,
                          filled: true,
                          fillColor: kDialogInputColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: secondaryButtonComponent(
                  text: "提交",
                  onPressed: () async {
                    try {
                      bool? reject = await services.acceptRejectOrder(
                          false, widget.orderId, rejectReason);
                      if (reject!) {
                        setState(() {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Get.back();
                          Fluttertoast.showToast(
                              msg: "已提交",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: kMainGreyColor,
                              textColor: kThirdGreyColor);
                        });
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
                  buttonColor: kMainYellowColor,
                  textStyle: buttonTextStyle2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
