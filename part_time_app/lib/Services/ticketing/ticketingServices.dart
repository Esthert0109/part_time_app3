import 'dart:convert';

import 'package:part_time_app/Model/Ticketing/ticketingModel.dart';

import '../../Constants/apiConstant.dart';
import '../../Utils/apiUtils.dart';
import '../../Utils/sharedPreferencesUtils.dart';
import 'package:http/http.dart' as http;

class TicketingService {
  Future<TicketingModel?> getTicketingHistory(int page) async {
    String url = port + getTicketingHistoryUrl + page.toString();
    String? token = await SharedPreferencesUtils.getToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!,
    };

    try {
      final response = await getRequest(url, headers);
      if (response.statusCode == 200) {
        Map<String, dynamic>? jsonData = json.decode(response.responseBody);
        if (jsonData != null) {
          int responseCode = jsonData['code'];
          print(responseCode);
          String responseMsg = jsonData['msg'];
          print(responseMsg);
          List<dynamic> data = jsonData['data'] ?? [];

          if (responseCode == 0) {
            List<TicketingData> responseData = data
                .map<TicketingData>((e) => TicketingData.fromJson(e))
                .toList();
            TicketingModel model = TicketingModel(
                code: responseCode, msg: responseMsg, data: responseData);
            return model;
          } else {
            TicketingModel model =
                TicketingModel(code: responseCode, msg: responseMsg, data: []);
            return model;
          }
        } else {
          throw Exception("Failed to decode JSON response");
        }
      } else {
        throw Exception("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error in Ticketing: $e");
    }
    return null;
  }

  Future<TicketingData?> getTicketDetail(int ticketId) async {
    String url = port + getTicketingDetailUrl + ticketId.toString();
    print(url);
    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!,
    };

    try {
      final response = await getRequest(url, headers);
      int statusCode = response.statusCode;
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.responseBody);
        return TicketingData.fromJson(jsonResponse['data']);
      } else {
        throw Exception('Failed to load payment detail');
      }
    } catch (e) {
      // Handle exceptions if needed
      print('Exception: $e');
    }
  }

  static Future<void> fetchComplaintTypes() async {
    String url = port + getTicketComplainTypeUrl;
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    final response = await getRequest(url, headers);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.responseBody)['data'];
      for (var item in data) {
        var complaintType = ComplaintType.fromJson(item);
        TicketingData.complaintTypeMap[complaintType.complaintTypeId] =
            complaintType.complaintName;
      }
    } else {
      throw Exception('Failed to load complaint types');
    }
  }

  String get complaintTypeName {
    return TicketingData.complaintTypeMap[TicketingData.complaintTypeMap] ??
        '未知';
  }

  Future<List<ComplaintType>> fetchComplaintTypesForDropdown() async {
    String url = port + getTicketComplainTypeUrl;
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    final response = await getRequest(url, headers);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.responseBody)['data'];
      return data.map((item) => ComplaintType.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load complaint types');
    }
  }

  Future<bool?> createTicket(TicketingData ticketDetail) async {
    String url = port + createTicketUrl;
    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!
    };

    final Map<String, dynamic> body = ticketDetail.toJson();
    try {
      final response = await postRequest(url, headers, body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.responseBody);
        int responseCode = jsonData['code'];

        if (responseCode == 0) {
          return true;
        } else {
          // Handle other status codes if needed
          return false;
        }
        // Check the response status code or any other condition based on your API
      }
    } catch (e) {
      return false;
    }
  }
}
