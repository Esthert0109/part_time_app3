import 'dart:convert';

import 'package:part_time_app/Constants/globalConstant.dart';
import 'package:part_time_app/Utils/apiUtils.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';

import '../../Constants/apiConstant.dart';
import '../../Model/Task/missionClass.dart';

class OrderServices {
  String url = "";

  Future<OrderModel?> getOrderByStatus(int status) async {
    url = port + getOrderByStatusUrl + status.toString() + '?page=$orderPage';
    OrderModel? orderModel;
    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!
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
            List<OrderData>? responseData =
                data?.map((e) => OrderData.fromJson(e)).toList();
            orderModel = OrderModel(
                code: responseCode, msg: responseMsg, data: responseData);
            return orderModel;
          }
        }
        orderModel = OrderModel(code: responseCode, msg: responseMsg, data: []);
        return orderModel;
      }
    } catch (e) {
      print("Error in order by status: $e");
    }
  }

  Future<OrderModel?> getTaskByStatus(int status) async {
    url = port + getTaskByStatusUrl + status.toString() + "?page=$taskPage";

    OrderModel? orderModel;
    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!
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
            List<OrderData>? responseData =
                data?.map((e) => OrderData.fromJson(e)).toList();
            orderModel = OrderModel(
                code: responseCode, msg: responseMsg, data: responseData);
            return orderModel;
          }
        }
        orderModel = OrderModel(code: responseCode, msg: responseMsg, data: []);
        return orderModel;
      }
    } catch (e) {
      print("Error in task by status: $e");
    }
  }

  Future<OrderDetailModel?> getOrderDetailsByOrderId(int orderId) async {
    url = port + getOrderDetailByOrderIdUrl + orderId.toString();

    OrderDetailModel? orderModel;
    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!
    };

    try {
      final response = await getRequest(url, headers);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.responseBody);
        int responseCode = jsonData['code'];
        String responseMsg = jsonData['msg'];

        if (responseCode == 0) {
          Map<String, dynamic> data = jsonData['data'];
          if (data!.isNotEmpty && data != null) {
            OrderData? responseData = OrderData.fromJson(data);
            orderModel = OrderDetailModel(
                code: responseCode, msg: responseMsg, data: responseData);
            return orderModel;
          }
        }
        orderModel =
            OrderDetailModel(code: responseCode, msg: responseMsg, data: null);
        return orderModel;
      }
    } catch (e) {
      print("Error in order detail by order id: $e");
    }
  }

  Future<OrderDetailModel?> getTaskDetailsByOrderId(int taskId) async {
    url = port + getTaskDetailByTaskIdUrl + taskId.toString();

    OrderDetailModel? orderModel;
    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!
    };

    try {
      final response = await getRequest(url, headers);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.responseBody);
        int responseCode = jsonData['code'];
        String responseMsg = jsonData['msg'];

        if (responseCode == 0) {
          Map<String, dynamic> data = jsonData['data'];
          if (data!.isNotEmpty && data != null) {
            OrderData? responseData = OrderData.fromJson(data);
            orderModel = OrderDetailModel(
                code: responseCode, msg: responseMsg, data: responseData);
            return orderModel;
          }
        }
        orderModel =
            OrderDetailModel(code: responseCode, msg: responseMsg, data: null);
        return orderModel;
      }
    } catch (e) {
      print("Error in task detail by order id: $e");
    }
  }
}
