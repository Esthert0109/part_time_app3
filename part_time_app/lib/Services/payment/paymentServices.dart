import 'dart:convert';

import 'package:part_time_app/Constants/apiConstant.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';

import '../../Model/Payment/paymentModel.dart';
import '../../Model/Task/missionClass.dart';
import '../../Model/User/userModel.dart';
import '../../Utils/apiUtils.dart';

class PaymentServices {
  String url = "";

  Future<List<Payment>?> getPaymentHistory(int page) async {
    String url = port + getPaymentHistoryUrl + page.toString();
    // print(url);

    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!,
    };

    try {
      final response = await getRequest(url, headers);
      int statusCode = response.statusCode;
      // print(response.responseBody);
      if (response.statusCode == 200) {
        final responseBody = response.responseBody;
        final parsedData = json.decode(responseBody);

        List<Payment> paymentHistory = [];
        parsedData['data'].forEach((date, payments) {
          List<PaymentData> paymentList = List<PaymentData>.from(
              payments.map((payment) => PaymentData.fromJson(payment)));
          Payment paymentData = Payment(date: date, payments: paymentList);
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

  Future<PaymentDetail?> getPaymentDetail(int paymentId) async {
    String url = port + getPaymentDetailUrl + paymentId.toString();
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
        final jsonResponse = jsonDecode(response.responseBody);
        return PaymentDetail.fromJson(jsonResponse['data']);
      } else {
        throw Exception('Failed to load payment detail');
      }
    } catch (e) {
      // Handle exceptions if needed
      print('Exception: $e');
    }

    // Return null if there's an erro
  }

  Future<DepositDetail?> getDepositDetail() async {
    String url = port + getDepositUrl;
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
        final jsonResponse = jsonDecode(response.responseBody);
        return DepositDetail.fromJson(jsonResponse['data']);
      } else {
        throw Exception('Failed to load payment detail');
      }
    } catch (e) {
      // Handle exceptions if needed
      print('Exception: $e');
    }

    // Return null if there's an erro
  }

  Future<bool?> createPayment(
      OrderData paymentData, String billingImage, String? billingUrl) async {
    String url = port + createPaymentUrl;

    String? token = await SharedPreferencesUtils.getToken();
    UserData? userDetails = await SharedPreferencesUtils.getUserDataInfo();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!
    };

    final Map<String, dynamic> body = {
      "taskId": paymentData.taskId,
      "paymentFromCustomerId": userDetails!.customerId,
      "paymentToCustomerId": "9c7be416-8a95-425f-ab1c-47f7552945ea",
      "paymentType": 0,
      "paymentUsername": userDetails.username,
      "paymentBillingAddress": userDetails.billingAddress,
      "paymentBillingNetwork": userDetails.billingNetwork,
      "paymentBillingCurrency": userDetails.billingCurrency,
      "paymentBillingImage": billingImage,
      "paymentBillingUrl": billingUrl,
      "paymentAmount": paymentData.taskPrepay,
      "paymentFee": paymentData.taskFee,
      "paymentTotalAmount": paymentData.taskAmount,
      "paymentStatus": 1
    };
  }

  Future<bool?> createDeposit(PaymentDetail paymentDetail) async {
    String url = port + createPaymentUrl;

    String? token = await SharedPreferencesUtils.getToken();
    UserData? userDetails = await SharedPreferencesUtils.getUserDataInfo();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!
    };

    final Map<String, dynamic> body = paymentDetail.toJson();
    try {
      final response = await postRequest(url, headers, body);
      if (response.statusCode == 200) {
        // Check the response status code or any other condition based on your API
        return true;
      } else {
        // Handle other status codes if needed
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
