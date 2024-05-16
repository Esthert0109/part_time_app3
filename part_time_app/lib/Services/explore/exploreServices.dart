import 'dart:convert';
import 'package:part_time_app/Utils/apiUtils.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';
import '../../Constants/apiConstant.dart';
import '../../Model/Task/missionMockClass.dart';

class ExploreService {
  Future<List<TaskClass>> fetchExplore(int page) async {
    String? _token = await SharedPreferencesUtils.getToken();
    final String url = port + exploreURL + 'page=$page';
    final Map<String, String> headers = {
      'token': '$_token',
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

  Future<List<TaskClass>> fetchExploreByPrice(String sortType, int page) async {
    final String url = port + explorePriceURL + "?" + sortType + '&page=$page';
    String? _token = await SharedPreferencesUtils.getToken();
    final Map<String, String> headers = {
      'token': '$_token',
      'Content-Type': 'application/json; charset=utf-8',
    };

    try {
      final response = await getRequest(url, headers);

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

  Future<SearchResult> fetchSearchResult(
      String keyword, String sort, int page) async {
    String? _token = await SharedPreferencesUtils.getToken();
    final String url = port +
        searchResultPage +
        "keyword=" +
        keyword +
        "&sortOrder=" +
        sort +
        '&page=$page';
    print(url);
    final Map<String, String> headers = {
      'token': '$_token',
      'Content-Type': 'application/json; charset=utf-8',
    };

    try {
      final response = await getRequest(url, headers);
      print(response.responseBody);
      if (response.statusCode == 200) {
        final jsonResponse =
            json.decode(utf8.decode(response.responseBody.runes.toList()));
        final data = jsonResponse['data'];
        final totalAmountOfData = data['totalAmountOfData'] ?? 0;
        final List<dynamic> tasksData = data['tasks'];
        final List<TaskClass> tasks =
            tasksData.map((item) => TaskClass.fromJson(item)).toList();
        return SearchResult(
          totalAmountOfData: totalAmountOfData,
          tasks: tasks,
        );
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<SearchResult> fetchSearchByTag(
      String sort, String tagId, int page) async {
    String? _token = await SharedPreferencesUtils.getToken();
    final String url = port +
        searchbyTag +
        "sortOrder=" +
        sort +
        '&tagIds=$tagId' +
        '&page=$page';
    print(url);
    final Map<String, String> headers = {
      'token': '$_token',
      'Content-Type': 'application/json; charset=utf-8',
    };

    try {
      final response = await getRequest(url, headers);
      print(response.responseBody);
      if (response.statusCode == 200) {
        final jsonResponse =
            json.decode(utf8.decode(response.responseBody.runes.toList()));
        final data = jsonResponse['data'];
        final totalAmountOfData = data['totalAmountOfData'] ?? 0;
        final List<dynamic> tasksData = data['tasks'];
        final List<TaskClass> tasks =
            tasksData.map((item) => TaskClass.fromJson(item)).toList();
        return SearchResult(
          totalAmountOfData: totalAmountOfData,
          tasks: tasks,
        );
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
