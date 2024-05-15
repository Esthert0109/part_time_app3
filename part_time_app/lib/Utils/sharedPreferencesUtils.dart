import 'dart:convert';

import 'package:part_time_app/Model/User/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static const String userKey = 'user';

  // save userModel information
  static Future<void> saveUserInfo(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonEncode(user.toJson());
    await prefs.setString(userKey, userData);
  }

  static Future<void> saveUserDataInfo(UserData user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(user.toJson());
    await prefs.setString('userModel', jsonString);
  }

  // save user information
  static Future<void> saveUserId(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  static Future<void> savePhoneNo(String phoneNo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNo', phoneNo);
  }

  static Future<void> savePassword(String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);
  }

  // get user information
  static Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  static Future<String?> getPhoneNo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phoneNo');
  }

  static Future<String?> getPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('password');
  }

  static Future<UserData?> getUserDataInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('userModel');
    if (jsonString != null) {
      Map<String, dynamic> json = jsonDecode(jsonString);
      return UserData.fromJson(json);
    }
    return null;
  }

  // remove user information
  static Future<void> clearSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
