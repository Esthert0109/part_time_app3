// import 'dart:convert';
// import 'package:part_time_app/Utils/apiUtils.dart';
// import '../../Constants/apiConstant.dart';
// import '../../Model/notification/messageModel.dart';

import 'dart:convert';

import 'package:part_time_app/Utils/apiUtils.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';

import '../../Constants/apiConstant.dart';
import '../../Model/notification/messageModel.dart';

class SystemMessageServices {
  String url = "";

  Future<NotificationTipsModel?> getNotificationTips() async {
    url = port + getNotificationTipsUrl;
    NotificationTipsModel? tipsModel;

    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!
    };

    try {
      final response = await getRequest(url, headers);
      int statusCode = response.statusCode;

      Map<String, dynamic> jsonData = json.decode(response.responseBody);
      int responseCode = jsonData['code'];
      String responseMsg = jsonData['msg'];

      if (responseCode == 0) {
        Map<String, dynamic> data = jsonData['data'];
        NotificationTipsData responseData = NotificationTipsData.fromJson(data);
        tipsModel = NotificationTipsModel(
            code: responseCode, msg: responseMsg, data: responseData);
        return tipsModel;
      } else {
        tipsModel = NotificationTipsModel(
            code: responseCode, msg: responseMsg, data: null);
        return tipsModel;
      }
    } catch (e) {
      print("Error in Notification tips:$e");
    }
  }

  Future<NotificationListModel?> getNotificationList(int type) async {
    url = port +
        getNotificationListByTypeUrl +
        "notificationType=${type.toString()}";

    NotificationListModel? notiModel;

    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!
    };

    try {
      final response = await getRequest(url, headers);

      int statusCode = response.statusCode;

      Map<String, dynamic> jsonData = json.decode(response.responseBody);
      int responseCode = jsonData['code'];
      String responseMsg = jsonData['msg'];

      if (responseCode == 0) {
        List<dynamic>? data = jsonData['data'];
        List<NotificationListDate>? responseData =
            data?.map((item) => NotificationListDate.fromJson(item)).toList();

        notiModel = NotificationListModel(
            code: responseCode, msg: responseMsg, data: responseData);
        return notiModel;
      } else {
        notiModel = NotificationListModel(
            code: responseCode, msg: responseMsg, data: []);
        return notiModel;
      }
    } catch (e) {
      print("Error in noti list: $e");
    }
  }
//   Future<MessageModel?> fetchSystemMessage() async {
//     String url = port + systemMessage;
//     final Map<String, String> headers = {
//       'Content-Type': 'application/json; charset=utf-8',
//     };
//     try {
//       final response = await getRequest(url, headers);
//       print(response.responseBody); // Add this line to print the response data
//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.responseBody);
//         if (jsonData['data'] != null &&
//             jsonData['data'] is List<dynamic> &&
//             jsonData['data'].isNotEmpty) {
//           // List of messages format
//           print("300");
//           final messages = (jsonData['data'])
//               .map<MessageModel>(
//                   (messageData) => MessageModel.fromJson(messageData))
//               .toList();
//           print("400");
//           return messages;
//         } else {
//           // Handle unexpected data format (print response body for debugging)
//           print("Response Body: ${response.responseBody}");
//           throw Exception('No system message data found');
//         }
//       } else {
//         // Handle other status codes (throw exception)
//         throw Exception(
//             'Failed to fetch system messages. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Catch any errors during the HTTP request
//       throw Exception('Failed to fetch system messages: $e');
//     }
//   }
}
