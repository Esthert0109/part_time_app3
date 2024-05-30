import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:part_time_app/Pages/Explore/RecommendationPage.dart';
import 'package:part_time_app/Services/notification/notifacationServices.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../Constants/globalConstant.dart';
import '../../Model/User/userModel.dart';
import '../../Model/notification/messageModel.dart';
import '../../Utils/sharedPreferencesUtils.dart';

late int total;
WebSocketService webSocketService = WebSocketService("${userData.customerId}");

class WebSocketService with ChangeNotifier {
  String? _url;
  WebSocketChannel? _channel;
  bool _isConnected = false;

  WebSocketService(String customerId) {
    _initializeWebSocket(customerId);
  }

  void _initializeWebSocket(String customerId) {
    _url = 'ws://103.159.133.27:8085/webSocket/$customerId';
    _channel = WebSocketChannel.connect(Uri.parse(_url!));
    _isConnected = true;

    _channel!.stream.listen(
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
      if (_channel!.closeCode != null) {
        print('Failed to connect to WebSocket: ${_channel!.closeReason}');
      } else {
        print('WebSocket connection successful.');
        print(_url);
      }
    });
  }

  void reconnect(String customerId) {
    disconnect();
    _initializeWebSocket(customerId);
  }

  void disconnect() {
    if (_channel != null) {
      _channel!.sink.close();
      _isConnected = false;
      print('WebSocket disconnected');
    }
  }

  void _handleWebSocketMessage(dynamic message) {
    if (!_isConnected) return;

    print('Received message: $message');
    try {
      final parsedMessage = _parseWebSocketMessage(message);
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

  Map<String, String>? _parseWebSocketMessage(String message) {
    final regex =
        RegExp(r'Type:(.*?),Message Title:(.*?),Message Content:(.*?)$');
    final match = regex.firstMatch(message);

    if (match != null) {
      final type = match.group(1)?.trim();
      final content = match.group(3)?.trim();
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
      final String createdTime = formatter.format(now);

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
    disconnect();
    super.dispose();
  }

  bool get isConnected => _isConnected;
}
