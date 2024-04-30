import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class PaymentMessageCardComponent extends StatefulWidget {
  String title;
  String price;
  String bUser;
  PaymentMessageCardComponent({
    super.key,
    required this.title,
    required this.price,
    required this.bUser,
  });

  @override
  State<PaymentMessageCardComponent> createState() =>
      _PaymentMessageCardComponentState();
}

class _PaymentMessageCardComponentState
    extends State<PaymentMessageCardComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: kMainWhiteColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "悬赏赏金已发放！",
            style: missionCheckoutInputTextStyle,
          ),
          Text(
            "您的悬赏\"${widget.title}\"已发放${widget.price}USDT至${widget.bUser}。",
            style: missionDetailText2,
          ),
        ],
      ),
    );
  }
}
