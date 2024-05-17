import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService with ChangeNotifier {
  final WebSocketChannel _channel = WebSocketChannel.connect(
    Uri.parse('wss://your-websocket-url'), // Replace with your WebSocket URL
  );

  Map<String, dynamic> notificationTips = {
    '系统通知': {
      'notificationTotalUnread': 0,
      'notificationContent': '',
      'createdTime': ''
    },
    '悬赏通知': {
      'notificationTotalUnread': 0,
      'notificationContent': '',
      'createdTime': ''
    },
    '款项通知': {
      'notificationTotalUnread': 0,
      'notificationContent': '',
      'createdTime': ''
    },
    '发布通知': {
      'notificationTotalUnread': 0,
      'notificationContent': '',
      'createdTime': ''
    },
    '工单通知': {
      'notificationTotalUnread': 0,
      'notificationContent': '',
      'createdTime': ''
    },
  };

  WebSocketService() {
    _channel.stream.listen((message) {
      _handleWebSocketMessage(message);
    });
  }

  void _handleWebSocketMessage(dynamic message) {
    var data = json.decode(message);

    if (data.containsKey('type')) {
      var type = data['type'];
      notificationTips[type]['notificationTotalUnread'] += 1;
      notificationTips[type]['notificationContent'] =
          data['notificationContent'];
      notificationTips[type]['createdTime'] = data['createdTime'];

      notifyListeners();
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
