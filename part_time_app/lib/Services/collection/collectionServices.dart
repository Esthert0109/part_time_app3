import 'dart:convert';
import 'package:part_time_app/Utils/apiUtils.dart';
import '../../Constants/apiConstant.dart';
import '../../Model/Task/missionMockClass.dart';

class CollectionService {
  String _token = "2caf3d88-18d8-4a8b-b855-8568ceb3ca98";
  Future<List<TaskClass>> fetchCollection(int page) async {
    final String url = port + collectionURL + '?page=$page';
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
}
