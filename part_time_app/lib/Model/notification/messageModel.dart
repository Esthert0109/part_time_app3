import 'dart:convert';

class NotificationTipsModel {
  final int code;
  final String msg;
  final NotificationTipsData? data;

  NotificationTipsModel({required this.code, required this.msg, this.data});
}

class NotificationTipsData {
  final Map<String, TipsData> responseData;
  void updateNotification(String type, TipsData newData) {
    responseData[type] = newData;
  }

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
  int? notificationTotalUnread;

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
      notificationTotalUnread: json['notificationTotalUnread'] ?? 0,
    );
  }
}

class NotificationListModel {
  final int code;
  final String msg;
  final List<NotificationListDate>? data;

  NotificationListModel({required this.code, required this.msg, this.data});

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'msg': msg,
      'data': data?.map((json) => json.toJson()).toList()
    };
  }

  factory NotificationListModel.fromJson(Map<String, dynamic> json) {
    return NotificationListModel(
        code: json['code'],
        msg: json['msg'],
        data: json['data'] != null
            ? List<NotificationListDate>.from(
                json['data'].map((data) => NotificationListDate.fromJson(data)))
            : []);
  }
}

class NotificationListDate {
  final String date;
  final List<NotificationListData>? notifications;

  NotificationListDate({
    required this.date,
    required this.notifications,
  });

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "notifications": notifications?.map((e) => e.toJson()).toList(),
    };
  }

  factory NotificationListDate.fromJson(Map<String, dynamic> json) {
    return NotificationListDate(
        date: json['date'],
        notifications: json['notifications'] != null
            ? List<NotificationListData>.from(json['notifications']
                .map((data) => NotificationListData.fromJson(data)))
            : null);
  }
}

class NotificationListData {
  final String? notificationTitle;
  final String? notificationContent;
  final int? notificationFromCustomerId;
  final int? taskId;
  final int? orderId;
  final int? paymentId;
  final int? ticketId;
  final String? createdTime;
  final String? notificationTotalUnread;

  NotificationListData({
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

  Map<String, dynamic> toJson() {
    return {
      "notificationTitle": notificationTitle,
      "notificationContent": notificationContent,
      "notificationFromCustomerId": notificationFromCustomerId,
      "taskId": taskId,
      "orderId": orderId,
      "paymentId": paymentId,
      "ticketId": ticketId,
      "createdTime": createdTime,
      "notificationTotalUnread": notificationTotalUnread,
    };
  }

  factory NotificationListData.fromJson(Map<String, dynamic> json) {
    return NotificationListData(
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

class NotificationReadModel {
  final int code;
  final String msg;
  final bool? data;

  NotificationReadModel({
    required this.code,
    required this.msg,
    this.data,
  });

  factory NotificationReadModel.fromJson(Map<String, dynamic> json) {
    return NotificationReadModel(
      code: json['code'],
      msg: json['msg'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"code": code, "msg": msg, "data": data};
  }
}
