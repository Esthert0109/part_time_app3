import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Pages/Message/messageMainPage.dart';
import 'package:part_time_app/Pages/Message/missionMessagePage.dart';
import 'package:part_time_app/Pages/Message/publishMessagePage.dart';
import 'package:part_time_app/Pages/Message/systemMessagePage.dart';
import 'package:part_time_app/Pages/Message/ticketingMessagePage.dart';
import 'package:tencent_cloud_chat_uikit/tencent_cloud_chat_uikit.dart';

import '../../Constants/globalConstant.dart';
import '../../Pages/Message/paymentMessagePage.dart';
import '../../main.dart'; // Import necessary packages

class NotificationController {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: "basic_channel",
          channelName: "Basic notifications",
          channelDescription: "Notification channel for basic tests",
          importance: NotificationImportance.Max,
        ),
      ],
      debug: true,
    );
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
  }

  static Future<void> showNotification({
    required final String title,
    required final String body,
    final Map<String, String>? payload,
  }) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
          channelKey: 'basic_channel',
          title: title,
          body: body,
          notificationLayout: NotificationLayout.Default,
          payload: payload),
    );
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    final payload = receivedAction.payload ?? {};

    if (payload["navigate"] == "true") {
      // Check the page type and navigate accordingly
      switch (payload['page']) {
        case 'system_page':
          Get.to(() => const SystemMessagePage(),
              transition: Transition.rightToLeft);
          break;
        case 'mission_page':
          Get.to(() => const MissionMessagePage(),
              transition: Transition.rightToLeft);
        case 'payment_page':
          Get.to(() => const PaymentMessagePage(),
              transition: Transition.rightToLeft);
          break;
        case 'publish_page':
          Get.to(() => const PublishMessagePage(),
              transition: Transition.rightToLeft);
          break;
        case 'ticketing_page':
          Get.to(() => const TicketingMessagePage(),
              transition: Transition.rightToLeft);
          break;
        default:
          // Handle other cases or leave empty if no default action needed
          break;
      }
    }
  }
}
