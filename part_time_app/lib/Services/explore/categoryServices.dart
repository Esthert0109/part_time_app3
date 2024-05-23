import 'dart:convert';

import 'package:part_time_app/Utils/apiUtils.dart';

import '../../Constants/apiConstant.dart';
import '../../Model/Category/categoryModel.dart';

class CategoryServices {
  String url = "";

  Future<CategoryModel?> getCategoryList() async {
    url = port + getCategoryListUrl;
    CategoryModel? categoryModel;

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };

    try {
      final response = await getRequest(url, headers);
      int statusCode = response.statusCode;

      Map<String, dynamic> jsonData = json.decode(response.responseBody);
      int responseCode = jsonData['code'];
      String responseMsg = jsonData['msg'];

      if (statusCode == 200) {
        if (responseCode == 0) {
          List<dynamic>? data = jsonData['data'];

          List<CategoryListData>? responseData =
              data?.map((item) => CategoryListData.fromJson(item)).toList();

          categoryModel = CategoryModel(
              code: responseCode, msg: responseMsg, data: responseData);

          return categoryModel;
        } else {
          categoryModel =
              CategoryModel(code: responseCode, msg: responseMsg, data: null);

          return categoryModel;
        }
      }
    } catch (e) {
      print("Error in category list: $e");
    }
  }
}
