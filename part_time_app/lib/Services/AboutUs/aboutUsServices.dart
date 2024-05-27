import 'dart:convert';

import 'package:part_time_app/Model/AboutUs/aboutUsModel.dart';
import 'package:part_time_app/Utils/apiUtils.dart';

import '../../Constants/apiConstant.dart';

class AboutUsServices {
  String url = "";

  Future<AboutUsModel?> aboutUsDetails() async {
    url = port + aboutUsUrl;

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };

    try {
      final response = await getRequest(url, headers);
      int statusCode = response.statusCode;

      Map<String, dynamic> jsonData = json.decode(response.responseBody);
      int responseCode = jsonData['code'];
      String responseMsg = jsonData['msg'];
      Map<String, dynamic> data = jsonData['data'];
      AboutUsData responseData = AboutUsData.fromJson(data);

      if (statusCode == 200) {
        if (responseCode == 0) {
          if (data.isNotEmpty) {
            AboutUsModel aboutUsModel = AboutUsModel(
                code: responseCode, msg: responseMsg, data: responseData);
            return aboutUsModel;
          }
        } else {
          AboutUsModel aboutUsModel = AboutUsModel(
              code: responseCode, msg: responseMsg, data: responseData);
          return aboutUsModel;
        }
      }
    } catch (e) {
      print("Error in aboutUs: $e");
    }
    return null;
  }
}