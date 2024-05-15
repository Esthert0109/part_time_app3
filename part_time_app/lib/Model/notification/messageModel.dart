import 'dart:convert';

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
