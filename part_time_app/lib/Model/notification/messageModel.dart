import 'dart:convert';

class NotificationTipsModel {
  final int code;
  final String msg;
  final NotificationTipsData? data;

  NotificationTipsModel({required this.code, required this.msg, this.data});
}

class NotificationTipsData {
  final Map<String, TipsData> responseData;

  NotificationTipsData({required this.responseData});

  factory NotificationTipsData.fromJson(Map<dynamic, dynamic> json) {
    print("check data come in:${json}");

    if (json == null) {
      return NotificationTipsData(responseData: {});
    }

    Map<String, TipsData> tipsData = {};
    json.forEach((key, value) {
      tipsData[key] = TipsData.fromJson(value);
    });
    return NotificationTipsData(responseData: tipsData);
  }
}

class TipsData {
  final String? notificationTitle;
  final String? notificationContent;
  final String? notificationFromCustomerId;
  final int? taskId;
  final int? orderId;
  final int? paymentId;
  final int? ticketId;
  final String? createdTime;
  final int? notificationTotalUnread;

  TipsData({
    this.notificationTitle,
    this.notificationContent,
    this.notificationFromCustomerId,
    this.taskId,
    this.orderId,
    this.paymentId,
    this.ticketId,
    this.createdTime,
    this.notificationTotalUnread,
  });

  factory TipsData.fromJson(Map<String, dynamic> json) {
    return TipsData(
      notificationTitle: json['notificationTitle'],
      notificationContent: json['notificationContent'],
      notificationFromCustomerId: json['notificationFromCustomerId'],
      taskId: json['taskId'],
      orderId: json['orderId'],
      paymentId: json['paymentId'],
      ticketId: json['ticketId'],
      createdTime: json['createdTime'],
      notificationTotalUnread: json['notificationTotalUnread'],
    );
  }
}

class NotificationData {
  final String notificationTitle;
  final String notificationContent;
  final String createdTime;
  final int notificationIsRead;

  NotificationData({
    required this.notificationTitle,
    required this.notificationContent,
    required this.createdTime,
    required this.notificationIsRead,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      notificationTitle: json['notificationTitle'],
      notificationContent: json['notificationContent'],
      createdTime: json['createdTime'],
      notificationIsRead: json['notificationIsRead'],
    );
  }
}
