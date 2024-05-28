import 'dart:io';

import 'package:part_time_app/Utils/apiUtils.dart';

import '../../Constants/apiConstant.dart';

class UploadServices {
  String url = "";

  Future<List<String>?> uploadTaskImages(List<File> imageList) async {
    url = port + uploadTaskImagesUrl;
    print(url);
    try {
      final response = await postFileRequest(imageList, url);
      int responseCode = response['code'];
      String responseMsg = response['msg'];
      List<dynamic> data = response['data'];
      List<String> responseData =
          data.map((dynamic i) => i.toString()).toList();

      if (responseCode == 0) {
        if (data != null && data != []) {
          return responseData;
        }
      } else {
        return [];
      }
    } catch (e) {
      print("Error in upload task images: $e");
    }
  }

  Future<String?> uploadDeposit(File screenShot) async {
    url = port + uploadDepositUrl;
    try {
      final response = await postSingleFileRequest(screenShot, url);

      int responseCode = response['code'];
      String responseMsg = response['msg'];
      if (responseCode == 0) {
        String responseData = response['data'];
        return responseData;
      }
    } catch (e) {
      print("Error in upload single deposit: $e");
    }
  }

  Future<List<String>?> uploadTicketImages(List<File> imageList) async {
    url = port + uploadTicketImagesUrl;
    print(url);
    try {
      final response = await postFileRequest(imageList, url);
      int responseCode = response['code'];
      String responseMsg = response['msg'];
      List<dynamic> data = response['data'];
      List<String> responseData =
          data.map((dynamic i) => i.toString()).toList();

      if (responseCode == 0) {
        if (data != null && data != []) {
          return responseData;
        }
      } else {
        return [];
      }
    } catch (e) {
      print("Error in upload task images: $e");
    }
  }
}
