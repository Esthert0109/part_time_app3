import 'dart:convert';
import 'package:part_time_app/Utils/apiUtils.dart';
import '../../Constants/apiConstant.dart';
import '../../Model/Collection/collectionModel.dart';
import '../../Model/Task/missionMockClass.dart';

import 'package:http/http.dart' as http;

import '../../Utils/sharedPreferencesUtils.dart';

class CollectionService {
  String url = "";
  Future<List<TaskClass>> fetchCollection(int page) async {
    String? _token = await SharedPreferencesUtils.getToken();
    url = port + collectionURL + '?page=$page';
    final Map<String, String> headers = {
      'Token': '$_token',
      'Content-Type': 'application/json; charset=utf-8',
    };
    try {
      final response = await getRequest(url, headers);
      print(response.responseBody);
      if (response.statusCode == 200) {
        final jsonResponse =
            json.decode(utf8.decode(response.responseBody.runes.toList()));
        final List<dynamic> data = jsonResponse['data'];
        return data.map((item) => TaskClass.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<Collection?> updateCollection(int taskID, bool isFavorite) async {
    url = port + createCollectionURL + taskID.toString();
    String? _token = await SharedPreferencesUtils.getToken();

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
        return Collection.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update collection');
      }
    } catch (e) {
      print('Error in updateCollection: $e');
      return null;
    }
  }
}
