import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService with ChangeNotifier {
  final WebSocketChannel _channel = WebSocketChannel.connect(
    Uri.parse(
        'ws://103.159.133.27:8085/webSocket/9c7be416-8a95-425f-ab1c-47f7552945ea'), // Replace with your WebSocket URL
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
      final createdTime = DateTime.now()
          .toString(); // Assuming you want to use the current time

      if (type != null && content != null && createdTime != null) {
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

        if (notificationTips.containsKey(type)) {
          notificationTips[type]!['notificationTotalUnread'] += 1;
          notificationTips[type]!['notificationContent'] = content;
          notificationTips[type]!['createdTime'] = createdTime;
          notifyListeners(); // Notify listeners about the update
        }
      }
    } catch (e) {
      print('Error parsing message: $e');
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
