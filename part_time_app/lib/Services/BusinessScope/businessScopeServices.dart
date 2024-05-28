import 'dart:convert';

import 'package:part_time_app/Model/AboutUs/aboutUsModel.dart';
import 'package:part_time_app/Model/BusinessScope/businessScopeModel.dart';
import 'package:part_time_app/Utils/apiUtils.dart';

import '../../Constants/apiConstant.dart';

class BusinessScopeServices {
  String url = "";

  Future<List<BusinessScopeData>?> getBusinessScopeList() async {
    url = port + getBusinessScopeListUrl;

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };

    try {
      final response = await getRequest(url, headers);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.responseBody);
        int responseCode = jsonData['code'];
        String responseMsg = jsonData['msg'];

        if (responseCode == 0) {
          List<dynamic> data = jsonData['data'];
          List<BusinessScopeData> businessScopeList = data.map((item) => BusinessScopeData.fromJson(item)).toList();
          return businessScopeList;
        } else {
          print("Error: $responseMsg");
        }
      }
    } catch (e) {
      print("Error in BusinessScope: $e");
    }
    return null;
  }
}

