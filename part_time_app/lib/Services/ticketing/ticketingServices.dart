import 'dart:convert';

import 'package:part_time_app/Model/Ticketing/ticketingModel.dart';

import '../../Constants/apiConstant.dart';
import '../../Utils/apiUtils.dart';
import '../../Utils/sharedPreferencesUtils.dart';

class TicketingService {
  Future<TicketingModel?> getTicketingHistory(int page) async {
    String url = port + getTicketingHistoryUrl + page.toString();
    print(url);
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
        List<dynamic> data = jsonData['data'];

        if (responseCode == 0) {
          List<TicketingData>? responseData =
              data.map((e) => TicketingData.fromJson(e)).toList();
          TicketingModel model = TicketingModel(
              code: responseCode, msg: responseMsg, data: responseData);
          print(responseData);
          return model;
        } else {
          TicketingModel model =
              TicketingModel(code: responseCode, msg: responseMsg, data: []);

          return model;
        }
      }
    } catch (e) {
      print("Error in Ticketing: $e");
    }
    return null;
  }
}
