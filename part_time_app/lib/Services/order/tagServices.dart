import 'dart:convert';

import 'package:part_time_app/Model/Tag/tagModelForSearch.dart';
import 'package:part_time_app/Model/Task/tagModel.dart';

import '../../Constants/apiConstant.dart';
import '../../Utils/apiUtils.dart';
import '../../Utils/sharedPreferencesUtils.dart';

class TagServices {
  String url = "";

  Future<TagModel?> getTagList(int page) async {
    url = port + getTagListUrl + "page=${page.toString()}";

    TagModel? tagModel;
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

          if (data!.isNotEmpty && data != null) {
            List<TagData>? responseData =
                data?.map((e) => TagData.fromJson(e)).toList();

            tagModel = TagModel(
                code: responseCode, msg: responseMsg, data: responseData);
            return tagModel;
          }
        }
        tagModel = TagModel(code: responseCode, msg: responseMsg, data: []);
        return tagModel;
      }
    } catch (e) {
      print("Error in task lists: $e");
    }
  }

  Future<TagModelForSearch?> getTagForSearch() async {
    String url = port + getFilterTagListUrl;
    String? token = await SharedPreferencesUtils.getToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!,
    };

    try {
      final response = await getRequest(url, headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.responseBody);
        int responseCode = jsonData['code'];
        String responseMsg = jsonData['msg'];

        if (responseCode == 0) {
          TagModelForSearch model = TagModelForSearch.fromJson(jsonData);
          return model;
        } else {
          TagModelForSearch model =
              TagModelForSearch(code: responseCode, msg: responseMsg, data: []);
          return model;
        }
      }
    } catch (e) {
      print("Error in Ticketing: $e");
    }
    return null;
  }
}
