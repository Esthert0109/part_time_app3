import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:part_time_app/Services/notification/notifacationServices.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../Constants/globalConstant.dart';
import '../../Model/notification/messageModel.dart';

late int total;
final WebSocketService webSocketService = WebSocketService();

class WebSocketService with ChangeNotifier {
  final WebSocketChannel _channel = WebSocketChannel.connect(
    Uri.parse(
        'ws://103.159.133.27:8085/webSocket/9c7be416-8a95-425f-ab1c-47f7552945ea'), // Replace with your WebSocket URL
  );

  WebSocketService() {
    _channel.stream.listen(
      _handleWebSocketMessage,
      onDone: () {
        print('WebSocket connection closed.');
      },
      onError: (error) {
        print('WebSocket connection error: $error');
      },
    );

    // Checking the connection status after a delay to ensure the connection is attempted
    Future.delayed(Duration(seconds: 1), () {
      if (_channel.closeCode != null) {
        print('Failed to connect to WebSocket: ${_channel.closeReason}');
      } else {
        print('WebSocket connection successful.');
      }
    });
  }
  Map<String, String>? _parseWebSocketMessage(String message) {
    // Example message format: Type:款项通知,Message Title:悬赏预付赏金成功支付！,Message Content:您已预付105.00USDT 的赏金至悬赏[1]。
    final regex =
        RegExp(r'Type:(.*?),Message Title:(.*?),Message Content:(.*?)$');
    final match = regex.firstMatch(message);

    if (match != null) {
      final type = match.group(1)?.trim();
      final content = match.group(3)?.trim();
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
      final String createdTime =
          formatter.format(now); // Assuming you want to use the current time

      if (type != null && content != null) {
        return {
          'type': type,
          'content': content,
          'createdTime': createdTime,
        };
      }
    }
    return null;
  }

  void _handleWebSocketMessage(dynamic message) {
    print('Received message: $message');

    try {
      final parsedMessage = _parseWebSocketMessage(message);
      print("done parsed");
      if (parsedMessage != null) {
        final type = parsedMessage['type'];
        final content = parsedMessage['content'];
        final createdTime = parsedMessage['createdTime'];
        final item =
            notificationTips?.responseData[type]?.notificationTotalUnread;
        total = item! + 1;

        if (type != null && content != null && createdTime != null) {
          TipsData newData = TipsData(
            notificationContent: content,
            createdTime: createdTime,
            notificationTotalUnread: total,
          );
          _triggerNotification(type, content);
          notificationTips?.updateNotification(type, newData);
          notifyListeners();
        }
      }
    } catch (e) {
      print('Error parsing message: $e');
    }
  }

  void _triggerNotification(String title, String content) {
    late String page;
    switch (title) {
      case '系统通知':
        page = 'system_page';
        break;
      case '款项通知':
        page = 'payment_page';
        break;
      case '悬赏通知':
        page = 'mission_page';
        break;
      case '发布通知':
        page = 'publish_page';
        break;
      case '工单通知':
        page = 'ticketing_page';
        break;
      default:
        // leave empty if no default action needed
        break;
    }
    NotificationController.showNotification(
        title: title,
        body: content,
        payload: {
          'navigate': 'true',
          'page': page,
        });
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
