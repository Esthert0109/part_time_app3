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

  Future<bool?> acceptRejectOrder(
      bool isAccept, int orderId, String? rejectReason) async {
    url = port + acceptRejectOrderUrl;

    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!
    };

    Map<String, dynamic> body = {};

    if (isAccept) {
      body = {
        "orderId": orderId,
      };
    } else {
      body = {"orderId": orderId, "orderRejectReason": rejectReason};
    }

    try {
      final response = await patchRequest(url, headers, body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.responseBody);
        int responseCode = jsonData['code'];
        if (responseCode == 0) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print("Error in update: $e");
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

  Future<OrderDetailModel?> getTaskDetailsByTaskId(int taskId) async {
    String urls = port + getTaskDetailByTaskIdUrl + taskId.toString();

    OrderDetailModel? orderModel;

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };

    try {
      final response = await getRequest(urls, headers);
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

  Future<bool?> unshelfTaskByTaskId(int taskId) async {
    url = port + unshelveTaskUrl + "taskId=${taskId.toString()}";

    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!
    };

    final Map<String, dynamic> body = {};

    try {
      final response = await postRequest(url, headers, body);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.responseBody);
        int responseCode = jsonData['code'];

        if (responseCode == 0) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print("Error in unshelf: $e");
    }
  }

  Future<int?> createOrder(int taskId) async {
    url = port + createOrderUrl + taskId.toString();
    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!
    };
    final Map<String, dynamic> body = {};

    try {
      final response = await postRequest(url, headers, body);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.responseBody);
        int responseCode = jsonData['code'];

        if (responseCode == 0) {
          int responseData = jsonData['data'];
          return responseData;
        }
      }
    } catch (e) {
      print("Error in create order: $e");
    }
  }

  Future<OrderData?> createTask(OrderData taskDetails) async {
    url = port + createTaskUrl;

    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!
    };

    final Map<String, dynamic> body = {
      "taskTitle": taskDetails.taskTitle,
      "taskContent": taskDetails.taskContent,
      "taskSinglePrice": taskDetails.taskSinglePrice,
      "taskQuota": taskDetails.taskQuota,
      "taskAmount": taskDetails.taskAmount,
      "taskFee": taskDetails.taskFee,
      "taskPrepay": taskDetails.taskPrepay,
      "taskTimeLimit": taskDetails.taskTimeLimit,
      "taskTimeLimitUnit": taskDetails.taskTimeLimitUnit,
      "taskEstimateTime": taskDetails.taskEstimateTime,
      "taskEstimateTimeUnit": taskDetails.taskEstimateTimeUnit,
      "taskTagIds": taskDetails.taskTagIds,
      "taskProcedures": taskDetails.taskProcedures,
      "taskImagesPreview": taskDetails.taskImagesPreview
    };

    try {
      final response = await postRequest(url, headers, body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.responseBody);
        int responseCode = jsonData['code'];
        String responseMsg = jsonData['msg'];
        if (responseCode == 0) {
          Map<String, dynamic> data = jsonData['data'];
          OrderData responseData = OrderData.fromJson(data);
          return responseData;
        }
      }
    } catch (e) {
      print("Error in create task: $e");
      return null;
    }
  }

  Future<bool?> submitOrder(int orderId, List<String> image) async {
    url = port + submitOrderUrl;

    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!
    };

    final Map<String, dynamic> body = {
      "orderId": orderId,
      "orderScreenshots": {"image": image}
    };

    try {
      final response = await patchRequest(url, headers, body);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.responseBody);
        int responseCode = jsonData['code'];

        if (responseCode == 0) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print("Error in submit order: $e");
    }
  }

  Future<bool?> submitTask(int taskId) async {
    url = port + submitTaskUrl + taskId.toString();
    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!
    };

    final Map<String, dynamic> body = {};

    try {
      final response = await patchRequest(url, headers, body);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.responseBody);
        int responseCode = jsonData['code'];
        if (responseCode == 0) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print("Error in submit task:$e");
    }
  }

  Future<bool?> resubmitTask(OrderData taskDetails, int taskId) async {
    url = port + updateTaskUrl;

    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!
    };

    final Map<String, dynamic> body = {
      "taskId": taskId,
      "taskTitle": taskDetails.taskTitle,
      "taskContent": taskDetails.taskContent,
      "taskSinglePrice": taskDetails.taskSinglePrice,
      "taskQuota": taskDetails.taskQuota,
      "taskAmount": taskDetails.taskAmount,
      "taskFee": taskDetails.taskFee,
      "taskPrepay": taskDetails.taskPrepay,
      "taskTimeLimit": taskDetails.taskTimeLimit,
      "taskTimeLimitUnit": taskDetails.taskTimeLimitUnit,
      "taskEstimateTime": taskDetails.taskEstimateTime,
      "taskEstimateTimeUnit": taskDetails.taskEstimateTimeUnit,
      "taskTagIds": taskDetails.taskTagIds,
      "taskProcedures": taskDetails.taskProcedures,
      "taskImagesPreview": taskDetails.taskImagesPreview
    };

    try {
      final response = await patchRequest(url, headers, body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.responseBody);
        int responseCode = jsonData['code'];
        String responseMsg = jsonData['msg'];
        if (responseCode == 0) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print("Error in update task: $e");
    }
  }

  Future<CustomerListModel?> getCustomerListByOrderStatusId(
      int status, int taskId, int page) async {
    String urlss = port +
        getCustomerListByOrderStatusIdUrl +
        status.toString() +
        "?taskId=${taskId.toString()}&page=${page.toString()}";

    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!
    };

    try {
      final response = await getRequest(urlss, headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.responseBody);
        int responseCode = jsonData['code'];
        String responseMsg = jsonData['msg'];

        if (responseCode == 0) {
          Map<String, dynamic> data = jsonData['data'];
          CustomerListData? responseData = CustomerListData.fromJson(data);
          if (responseData != null) {
            CustomerListModel? customerModel = CustomerListModel(
                code: responseCode, msg: responseMsg, data: responseData);
            return customerModel;
          } else {
            CustomerListModel? customerModel =
                CustomerListModel(code: responseCode, msg: responseMsg);
            return customerModel;
          }
        }
      }
    } catch (e) {
      print("Error in get customer list from order: $e");
    }
  }

  Future<List<TaskClass>?> getRandomTwoTask() async {
    String url = port + getTwoRandomTaskUrl;

    String? token = await SharedPreferencesUtils.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!
    };

    try {
      final response = await getRequest(url, headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.responseBody);
        int responseCode = jsonData['code'];
        String responseMsg = jsonData['msg'];

        if (responseCode == 0) {
          List<dynamic> data = jsonData['data'];
          List<TaskClass>? responseData =
              data?.map((e) => TaskClass.fromJson(e)).toList();
          return responseData;
        } else {
          return [];
        }
      }
    } catch (e) {
      print("Error in random 2 task: $e");
    }
  }
}
