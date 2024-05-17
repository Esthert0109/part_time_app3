// import 'dart:convert';
// import 'package:part_time_app/Utils/apiUtils.dart';
// import '../../Constants/apiConstant.dart';
// import '../../Model/notification/messageModel.dart';

import 'dart:convert';

import 'package:part_time_app/Utils/apiUtils.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';
import 'package:http/http.dart' as http;
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

  Future<NotificationListModel?> getNotificationList(int type, int page) async {
    url = port +
        getNotificationListByTypeUrl +
        "notificationType=${type.toString()}&page=" +
        page.toString();
    print(url);
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

  Future<NotificationReadModel?> patchUpdateRead(int type) async {
    url = port + patchNotificationReadStatusUrl + type.toString();
    String? _token = await SharedPreferencesUtils.getToken();
    print(url);
    final Map<String, String> headers = {
      'Token': '$_token',
      'Content-Type': 'application/json; charset=utf-8',
    };
    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return NotificationReadModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update collection');
      }
    } catch (e) {
      print('Error in updateCollection: $e');
      return null;
    }
  }

  Future<NotificationReadModel?> postUpdateRead() async {
    url = port + postSystemNotificationReadStatusUrl;
    String? _token = await SharedPreferencesUtils.getToken();
    print(url);
    final Map<String, String> headers = {
      'Token': '$_token',
      'Content-Type': 'application/json; charset=utf-8',
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return NotificationReadModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update collection');
      }
    } catch (e) {
      print('Error in updateCollection: $e');
      return null;
    }
  }
}
