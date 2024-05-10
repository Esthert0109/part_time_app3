import 'dart:convert';

import 'package:part_time_app/Utils/apiUtils.dart';

import '../../Constants/apiConstant.dart';
import '../../Model/User/userModel.dart';

class UserServices {
  String url = "";

  Future<UserModel?> login(UserData userData) async {
    url = loginUrl;

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };

    final Map<String, dynamic> body = {
      'phone_no': userData.firstPhoneNo,
      'password': userData.password
    };

    try {
      final response = await postRequest(url, headers, body);
      int statusCode = response.statusCode;

      Map<String, dynamic> jsonData = json.decode(response.responseBody);
      int responseCode = jsonData['code'];
      String responseMsg = jsonData['msg'];
      Map<String, dynamic> data = jsonData['data'];
      UserData responseData = UserData.fromJson(data);

      if (statusCode == 200) {
        if (responseCode == 0) {
          if (data!.isNotEmpty && data != null) {
            UserModel userModel = UserModel(
                code: responseCode, msg: responseMsg, data: responseData);

            return userModel;
          }
        } else {
          UserModel userModel = UserModel(
              code: responseCode, msg: responseMsg, data: responseData);

          return userModel;
        }
      }
    } catch (e) {
      print("Error in login: $e");
    }
    return null;
  }

  Future<UserModel?> registration(UserData userData) async {
    url = registrationUrl;

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };

    final Map<String, dynamic> body = {
      "username": userData.username,
      "password": userData.password,
      "firstPhoneNo": userData.firstPhoneNo
    };

    try {
      final response = await postRequest(url, headers, body);
      int statusCode = response.statusCode;

      Map<String, dynamic> jsonData = json.decode(response.responseBody);
      int responseCode = jsonData['code'];
      String responseMsg = jsonData['msg'];
      Map<String, dynamic> data = jsonData['data'];
      UserData responseData = UserData.fromJson(data);

      if (statusCode == 200) {
        if (responseCode == 0) {
          if (data!.isNotEmpty && data != null) {
            UserModel userModel = UserModel(
                code: responseCode, msg: responseMsg, data: responseData);

            return userModel;
          }
        } else {
          UserModel userModel = UserModel(
              code: responseCode, msg: responseMsg, data: responseData);

          return userModel;
        }
      }
    } catch (e) {
      print("Error in registration: $e");
    }
    return null;
  }
}
