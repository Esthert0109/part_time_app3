import 'dart:convert';
import 'package:http/http.dart' as http;

class ComplaintType {
  final int complaintTypeId;
  final String complaintName;

  ComplaintType({required this.complaintTypeId, required this.complaintName});

  factory ComplaintType.fromJson(Map<String, dynamic> json) {
    return ComplaintType(
      complaintTypeId: json['complaintTypeId'],
      complaintName: json['complaintName'],
    );
  }
}

class TicketingModel {
  final int code;
  final String msg;
  final List<TicketingData>? data;

  TicketingModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "msg": msg,
      "data": data?.map((e) => e.toJson()).toList(),
    };
  }

  factory TicketingModel.fromJson(Map<String, dynamic> json) {
    return TicketingModel(
        code: json['code'],
        msg: json['msg'],
        data: json['data'] != null
            ? List<TicketingData>.from(
                json['data'].map((data) => TicketingData.fromJson(data)))
            : null);
  }
}

class TicketingData {
  final String? customerId;
  final String? ticketCustomerUsername;
  final String? ticketCustomerPhoneNum;
  final String? ticketCustomerEmail;
  final String? ticketDate;
  final int? taskId;
  final int? complaintTypeId;
  final int? complaintUserId;
  final String? ticketComplaintDescription;
  final String? ticketComplaintAttachment;
  final int? ticketStatus;
  final String? ticketCreatedTime;
  final String? ticketUpdatedTime;
  static Map<int, String> complaintTypeMap = {};

  TicketingData({
    this.customerId,
    this.ticketCustomerUsername,
    this.ticketCustomerPhoneNum,
    this.ticketCustomerEmail,
    this.ticketDate,
    this.taskId,
    this.complaintTypeId,
    this.complaintUserId,
    this.ticketComplaintDescription,
    this.ticketComplaintAttachment,
    this.ticketStatus,
    this.ticketCreatedTime,
    this.ticketUpdatedTime,
  });
  static Future<void> fetchComplaintTypes() async {
    final response = await http
        .get(Uri.parse('http://103.159.133.27:8085/api/v1/ticket/getTypes'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes))['data'];
      print(data);
      for (var item in data) {
        var complaintType = ComplaintType.fromJson(item);
        complaintTypeMap[complaintType.complaintTypeId] =
            complaintType.complaintName;
      }
    } else {
      throw Exception('Failed to load complaint types');
    }
  }

  String get complaintTypeName {
    return complaintTypeMap[complaintTypeId] ?? '未知';
  }

  Map<String, dynamic> toJson() {
    return {
      "customerId": customerId,
      "ticketCustomerUsername": ticketCustomerUsername,
      "ticketCustomerPhoneNum": ticketCustomerPhoneNum,
      "ticketCustomerEmail": ticketCustomerEmail,
      "ticketDate": ticketDate,
      "taskId": taskId,
      "complaintTypeId": complaintTypeId,
      "complaintUserId": complaintUserId,
      "ticketComplaintDescription": ticketComplaintDescription,
      "ticketComplaintAttachment": ticketComplaintAttachment,
      "ticketStatus": ticketStatus,
      "ticketCreatedTime": ticketCreatedTime,
      "ticketUpdatedTime": ticketUpdatedTime,
    };
  }

  factory TicketingData.fromJson(Map<String, dynamic> json) {
    return TicketingData(
      customerId: json['customerId'] ?? "",
      ticketCustomerUsername: json['ticketCustomerUsername'] ?? "",
      ticketCustomerPhoneNum: json['ticketCustomerPhoneNum'] ?? "",
      ticketCustomerEmail: json['ticketCustomerEmail'] ?? "",
      ticketDate: json['ticketDate'] ?? "",
      taskId: json['taskId'] ?? 0,
      complaintTypeId: json['complaintTypeId'] ?? 1,
      complaintUserId: json['complaintUserId'] ?? 1,
      ticketComplaintDescription: json['ticketComplaintDescription'] ?? "",
      ticketComplaintAttachment: json['ticketComplaintAttachment'] ?? "",
      ticketStatus: json['ticketStatus'] ?? 0,
      ticketCreatedTime: json['ticketCreatedTime'] ?? "",
      ticketUpdatedTime: json['ticketUpdatedTime'] ?? "",
    );
  }
}
