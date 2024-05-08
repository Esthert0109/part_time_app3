import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/textStyleConstant.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime expiredDate;
  final bool isReview;
  const CountdownTimer(
      {super.key, required this.expiredDate, required this.isReview});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Duration? remainingTime;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    calculateRemainingTime();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        calculateRemainingTime();
      });
    });
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  void calculateRemainingTime() {
    setState(() {
      remainingTime = widget.expiredDate.difference(DateTime.now());
      print("check remaining time: $remainingTime");

      if (remainingTime!.isNegative) {
        remainingTime = Duration.zero;
        timer!.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int hours = remainingTime!.inHours;
    int minutes = remainingTime!.inMinutes.remainder(60);
    int seconds = remainingTime!.inSeconds.remainder(60);

    return RichText(
        text: TextSpan(
            style: widget.isReview ? durationTextStyle : messageDescTextStyle2,
            children: [
          TextSpan(text: '剩余时间 '),
          TextSpan(
              text:
                  "$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}")
        ]));

    // Text(
    //   "$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}",
    //   style: messageDescTextStyle2,
    // );
  }
}
