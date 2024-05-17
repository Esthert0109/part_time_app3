import 'dart:convert';

import 'package:part_time_app/Constants/apiConstant.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';

import '../../Model/Payment/paymentModel.dart';
import '../../Utils/apiUtils.dart';

class PaymentServices {
  String url = "";

  Future<List<PaymentData>?> getPaymentHistory(int page) async {
    String url = port + getPaymentHistoryUrl + page.toString();
    print(url);

    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!,
    };

    try {
      final response = await getRequest(url, headers);
      int statusCode = response.statusCode;
      print(response.responseBody);
      if (response.statusCode == 200) {
        final responseBody = response.responseBody;
        final parsedData = json.decode(responseBody);

        List<PaymentData> paymentHistory = [];
        parsedData['data'].forEach((date, payments) {
          List<Payment> paymentList = List<Payment>.from(
              payments.map((payment) => Payment.fromJson(payment)));
          PaymentData paymentData =
              PaymentData(date: date, payments: paymentList);
          paymentHistory.add(paymentData);
        });
        return paymentHistory;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle exceptions if needed
      print('Exception: $e');
    }

    // Return null if there's an erro
  }
}
