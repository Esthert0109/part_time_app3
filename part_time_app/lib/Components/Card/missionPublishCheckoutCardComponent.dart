import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

late TextEditingController priceController;
late TextEditingController peopleController;
late TextEditingController dayController;
late TextEditingController durationController;

class MissionPublishCheckoutCardComponent extends StatefulWidget {
  final Function(String)? onPriceChange;
  final Function(String)? onPersonChange; // Add this line
  final Function(String)? onDayChange; // Add this line
  final Function(String)? onDurationChange; // Add this line
  final String? priceInitial;
  final String? peopleInitial;
  final String? dayInitial;
  final String? durationInitial;
  final bool isSubmit;

  const MissionPublishCheckoutCardComponent({
    super.key,
    required this.isSubmit,
    this.priceInitial,
    this.peopleInitial,
    this.dayInitial,
    this.durationInitial,
    this.onPriceChange,
    this.onPersonChange, // Add this line
    this.onDayChange, // Add this line
    this.onDurationChange,
  });

  @override
  State<MissionPublishCheckoutCardComponent> createState() =>
      _MissionPublishCheckoutCardComponentState();
}

class _MissionPublishCheckoutCardComponentState
    extends State<MissionPublishCheckoutCardComponent> {
  double totalPrepaidPrice = 0;
  double handingFee = 0;
  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
    priceController = TextEditingController(text: widget.priceInitial);
    peopleController = TextEditingController(text: widget.peopleInitial);
    dayController = TextEditingController(text: widget.dayInitial);
    durationController = TextEditingController(text: widget.durationInitial);
    calculateTotalPrice();
  }

  void calculateTotalPrice() {
    setState(() {
      double price = double.tryParse(priceController.text) ?? 0;
      double people = double.tryParse(peopleController.text) ?? 0;
      totalPrepaidPrice = price * people;
      handingFee = (totalPrepaidPrice * 0.01);
      totalPrice = totalPrepaidPrice + handingFee;
    });
  }

  String formatValue(double value) {
    return value.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 351,
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: kMainWhiteColor,
        ),
        child: Column(
          children: [
            SizedBox(height: 8),
            _buildTextFormField1(
              "悬赏单价",
              "USDT /人",
              widget.isSubmit,
              priceController,
              validator: null,
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (widget.onPersonChange != null) {
                  widget.onPersonChange!(value);
                }
                calculateTotalPrice(); // Add this line
              },
            ),
            SizedBox(height: 8),
            _buildTextFormField1(
              "总名额",
              " /人",
              widget.isSubmit,
              peopleController,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return '人数不能为空';
              //   } else if (value.startsWith(RegExp(r'\s'))) {
              //     return "人数不能以空格开头";
              //   } else if (value.contains(RegExp(r'\s\s'))) {
              //     return "人数不能包含连续的空格";
              //   }
              //   return null;
              // },
              inputFormatters: [
                LengthLimitingTextInputFormatter(4),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (widget.onPersonChange != null) {
                  widget.onPersonChange!(value);
                }
                calculateTotalPrice(); // Add this line
              },
            ),
            SizedBox(height: 8),
            _buildTextFormField2(
              "悬赏时限",
              "天",
              widget.isSubmit,
              dayController,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return '人数不能为空';
              //   } else if (value.startsWith(RegExp(r'\s'))) {
              //     return "人数不能以空格开头";
              //   } else if (value.contains(RegExp(r'\s\s'))) {
              //     return "人数不能包含连续的空格";
              //   }
              //   return null;
              // },
              inputFormatters: [
                LengthLimitingTextInputFormatter(3),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (widget.onDayChange != null) {
                  widget.onDayChange!(value);
                }
              },
            ),
            SizedBox(height: 8),
            _buildTextFormField2(
              "预计耗时",
              "小时",
              widget.isSubmit,
              durationController,
              validator: null,
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (widget.onDayChange != null) {
                  widget.onDayChange!(value);
                }
              },
            ),
            SizedBox(height: 20),
            Container(
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Expanded(
                      flex: 3,
                      child: Text(
                        "赏金预付",
                        style: missionCheckoutTextStyle,
                      )),
                  Expanded(
                      flex: 6,
                      child: Text(
                        "${formatValue(totalPrepaidPrice)} USDT",
                        textAlign: TextAlign.right,
                        style: missionCheckoutInputTextStyle,
                      ))
                ],
              ),
            ),
            SizedBox(height: 12),
            Container(
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Expanded(
                      flex: 3,
                      child: Text(
                        "手续费 1%",
                        style: missionCheckoutTextStyle,
                      )),
                  Expanded(
                      flex: 6,
                      child: Text(
                        "${formatValue(handingFee)} USDT",
                        textAlign: TextAlign.right,
                        style: missionCheckoutInputTextStyle,
                      ))
                ],
              ),
            ),
            SizedBox(height: 12),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 20),
                  Expanded(
                      flex: 3,
                      child: Text(
                        "预付共计",
                        style: missionCheckoutTotalPriceTextStyle,
                      )),
                  Expanded(
                      flex: 6,
                      child: Text(
                        "${formatValue(totalPrice)} USDT",
                        textAlign: TextAlign.right,
                        style: missionCheckoutInputTextStyle,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTextFormField1(
  String text,
  String text2,
  bool readOnly,
  TextEditingController? controller, {
  String? Function(String?)? validator,
  List<TextInputFormatter>? inputFormatters,
  TextInputType? keyboardType,
  Function(String)? onChanged,
}) {
  return Container(
    height: 47,
    child: Row(
      children: [
        SizedBox(width: 20),
        Expanded(
            flex: 3,
            child: Text(
              text,
              style: missionCheckoutTextStyle,
            )),
        Container(
            width: text2.length > 4 ? 146 : 186,
            child: TextFormField(
              readOnly: readOnly,
              keyboardType: keyboardType,
              controller: controller,
              onChanged: onChanged,
              validator: validator,
              inputFormatters: inputFormatters,
              maxLines: 1,
              textAlign: TextAlign.right,
              style: missionCheckoutInputTextStyle,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 15),
                filled: true,
                fillColor: kInputBackGreyColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4)),
                  borderSide: BorderSide.none,
                ),
              ),
            )),
        Container(
          width: text2.length > 4 ? 80 : 40,
          child: Container(
              padding: EdgeInsets.only(top: 11, right: 10),
              height: 47,
              decoration: BoxDecoration(color: kInputBackGreyColor),
              child: Text(
                text2,
                style: missionCheckoutHintTextStyle,
                textAlign: TextAlign.center,
              )),
        ),
      ],
    ),
  );
}

Widget _buildTextFormField2(
  String text,
  String text2,
  bool readOnly,
  TextEditingController? controller, {
  String? Function(String?)? validator,
  List<TextInputFormatter>? inputFormatters,
  TextInputType? keyboardType,
  Function(String)? onChanged,
}) {
  return Container(
    height: 47,
    child: Row(
      children: [
        Container(
            width: 107,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: missionCheckoutTextStyle,
            )),
        SizedBox(width: 20),
        Expanded(
            flex: 4,
            child: TextFormField(
              readOnly: readOnly,
              keyboardType: keyboardType,
              controller: controller,
              onChanged: onChanged,
              validator: validator,
              inputFormatters: inputFormatters,
              maxLines: 1,
              textAlign: TextAlign.right,
              style: missionCheckoutInputTextStyle,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                filled: true,
                fillColor: kInputBackGreyColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
              ),
            )),
        SizedBox(width: 10),
        Container(
          width: 56,
          child: Container(
              padding: EdgeInsets.all(10),
              height: 47,
              decoration: BoxDecoration(color: kInputBackGreyColor),
              child: Text(
                text2,
                style: missionCheckoutInputTextStyle,
                textAlign: TextAlign.center,
              )),
        ),
      ],
    ),
  );
}
