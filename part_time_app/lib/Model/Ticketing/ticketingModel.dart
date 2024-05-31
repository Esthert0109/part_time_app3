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
  final int? code;
  final String? msg;
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
  final int? ticketId;
  final String? customerId;
  final String? ticketCustomerUsername;
  final String? ticketCustomerPhoneNum;
  final String? ticketCustomerEmail;
  final String? ticketDate;
  final int? taskId;
  final int? complaintTypeId;
  final String? complaintUserId;
  final String? ticketComplaintDescription;
  final List<String>? ticketComplaintAttachment;
  final int? ticketStatus;
  final String? ticketCreatedTime;
  final String? ticketUpdatedTime;
  static Map<int, String> complaintTypeMap = {};

  TicketingData({
    this.ticketId,
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

  Map<String, dynamic> toJson() {
    return {
      "ticketId": ticketId,
      "customerId": customerId,
      "ticketCustomerUsername": ticketCustomerUsername,
      "ticketCustomerPhoneNum": ticketCustomerPhoneNum,
      "ticketCustomerEmail": ticketCustomerEmail,
      "ticketDate": ticketDate,
      "taskId": taskId,
      "complaintTypeId": complaintTypeId,
      "complaintUserId": complaintUserId,
      "ticketComplaintDescription": ticketComplaintDescription,
      'ticketComplaintAttachment': {'image': ticketComplaintAttachment},
      "ticketStatus": ticketStatus,
      "ticketCreatedTime": ticketCreatedTime,
      "ticketUpdatedTime": ticketUpdatedTime,
    };
  }

  factory TicketingData.fromJson(Map<String, dynamic> json) {
    List<String> ticketComplaintAttachment = [];
    try {
      final attachmentValue = json['ticketComplaintAttachment'];
      if (attachmentValue is String) {
        Map<String, dynamic> attachmentMap = jsonDecode(attachmentValue);
        if (attachmentMap.containsKey('image') &&
            attachmentMap['image'] is List) {
          ticketComplaintAttachment = List<String>.from(attachmentMap['image']);
        } else {
          print('Invalid format for ticketComplaintAttachment: $attachmentMap');
        }
      } else {
        print('ticketComplaintAttachment is not a JSON string');
      }
    } catch (e) {
      print('Error parsing ticketComplaintAttachment: $e');
    }
    return TicketingData(
      ticketId: json['ticketId'] ?? 1,
      customerId: json['customerId'] ?? "",
      ticketCustomerUsername: json['ticketCustomerUsername'] ?? "",
      ticketCustomerPhoneNum: json['ticketCustomerPhoneNum'] ?? "",
      ticketCustomerEmail: json['ticketCustomerEmail'] ?? "",
      ticketDate: json['ticketDate'] ?? "",
      taskId: json['taskId'] ?? 0,
      complaintTypeId: json['complaintTypeId'] ?? "1",
      complaintUserId: json['complaintUserId'] ?? "1",
      ticketComplaintDescription: json['ticketComplaintDescription'] ?? "",
      ticketComplaintAttachment: ticketComplaintAttachment ?? [],
      ticketStatus: json['ticketStatus'] ?? 0,
      ticketCreatedTime: json['ticketCreatedTime'] ?? "",
      ticketUpdatedTime: json['ticketUpdatedTime'] ?? "",
    );
  }
  @override
  String toString() {
    return 'TicketingData(customerId: $customerId, '
        'ticketCustomerUsername: $ticketCustomerUsername, '
        'ticketCustomerPhoneNum: $ticketCustomerPhoneNum, '
        'ticketCustomerEmail: $ticketCustomerEmail, '
        'ticketDate: $ticketDate, '
        'taskId: $taskId, '
        'complaintTypeId: $complaintTypeId, '
        'complaintUserId: $complaintUserId, '
        'ticketComplaintDescription: $ticketComplaintDescription, '
        'ticketComplaintAttachment: $ticketComplaintAttachment)';
  }
}
