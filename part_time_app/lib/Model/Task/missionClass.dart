import 'tagModel.dart';

class SearchResult {
  final int totalAmountOfData;
  final List<TaskClass> tasks;

  SearchResult({
    required this.totalAmountOfData,
    required this.tasks,
  });
}

class OrderModel {
  final int code;
  final String msg;
  final List<OrderData>? data;

  OrderModel({
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

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      code: json['code'],
      msg: json['msg'],
      data: json['data'] != null
          ? List<OrderData>.from(
              json['data'].map((data) => OrderData.fromJson(data)))
          : [],
    );
  }
}

class OrderDetailModel {
  final int code;
  final String msg;
  final OrderData? data;

  OrderDetailModel({required this.code, required this.msg, this.data});

  Map<String, dynamic> toJson() {
    return {"code": code, "msg": msg, "data": data};
  }

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
        code: json['code'], msg: json['msg'], data: json['data']);
  }
}

class OrderData {
  final int? orderId;
  int? taskId;
  final String? customerId;
  final String? taskTitle;
  final String? taskContent;
  final String? taskTagIds;
  final List<TagData>? taskTagNames;
  final double? orderSinglePrice;
  final int? orderStatus;
  final String? taskUpdatedTime;
  final String? username;
  final String? nickname;
  final String? avatar;
  final int? categoryId;
  final double? taskSinglePrice;
  final int? taskQuota;
  final int? taskTimeLimit;
  final String? taskTimeLimitUnit;
  final int? taskEstimateTime;
  final String? taskEstimateTimeUnit;
  final int? taskStatus;
  final TaskProcedureModel? taskProcedures;
  final String? orderRejectReason;
  final String? taskCreatedTime;
  final int? taskImagesPreview;
  final int? taskReceivedNum;
  final int? taskIsDelete;
  final int? collectionValid;
  final String? updatedTime;
  final String? orderBExpiredTime;
  final double? taskAmount;
  final double? taskFee;
  final double? taskPrepay;
  final OrderScreenShotList? orderScreenshots;
  final String? taskRejectReason;
  final String? taskReeditTime;

  OrderData({
    this.orderId,
    this.taskId,
    this.customerId,
    this.taskTitle,
    this.taskContent,
    this.taskTagIds,
    this.taskTagNames,
    this.orderSinglePrice,
    this.orderStatus,
    this.taskUpdatedTime,
    this.username,
    this.nickname,
    this.avatar,
    this.categoryId,
    this.taskSinglePrice,
    this.taskQuota,
    this.taskTimeLimit,
    this.taskTimeLimitUnit,
    this.taskEstimateTime,
    this.taskEstimateTimeUnit,
    this.taskStatus,
    this.taskProcedures,
    this.orderRejectReason,
    this.taskCreatedTime,
    this.taskImagesPreview,
    this.taskReceivedNum,
    this.taskIsDelete,
    this.collectionValid,
    this.updatedTime,
    this.orderBExpiredTime,
    this.taskAmount,
    this.orderScreenshots,
    this.taskFee,
    this.taskPrepay,
    this.taskRejectReason,
    this.taskReeditTime,
  });

  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
      "taskId": taskId,
      "customerId": customerId,
      "taskTitle": taskTitle,
      "taskContent": taskContent,
      "taskTagIds": taskTagIds,
      "taskTagNames": taskTagNames?.map((e) => e.toJson()).toList(),
      "orderSinglePrice": orderSinglePrice,
      "orderStatus": orderStatus,
      "taskUpdatedTime": taskUpdatedTime,
      "username": username,
      "avatar": avatar,
      "nickname": nickname,
      "categoryId": categoryId,
      "taskSinglePrice": taskSinglePrice,
      "taskQuota": taskQuota,
      "taskTimeLimit": taskTimeLimit,
      "taskTimeLimitUnit": taskTimeLimitUnit,
      "taskEstimateTime": taskEstimateTime,
      "taskEstimateTimeUnit": taskEstimateTimeUnit,
      "taskStatus": taskStatus,
      "taskProcedures": taskProcedures?.toJson(),
      "orderRejectReason": orderRejectReason,
      "taskCreatedTime": taskCreatedTime,
      "taskImagesPreview": taskImagesPreview,
      "taskReceivedNum": taskReceivedNum,
      "taskIsDelete": taskIsDelete,
      "collectionValid": collectionValid,
      "updatedTime": updatedTime,
      "orderBExpiredTime": orderBExpiredTime,
      "orderScreenshots": orderScreenshots,
      "taskAmount": taskAmount,
      "taskFee": taskFee,
      "taskPrepay": taskPrepay,
      "taskRejectReason": taskRejectReason,
      "taskReeditTime": taskReeditTime,
    };
  }

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      orderId: json['orderId'],
      taskId: json['taskId'],
      customerId: json['customerId'],
      taskTitle: json['taskTitle'],
      taskContent: json['taskContent'],
      taskTagIds: json['taskTagIds'],
      taskTagNames: json['taskTagNames'] != null
          ? List<TagData>.from(
              json['taskTagNames'].map((data) => TagData.fromJson(data)))
          : [],
      orderSinglePrice: json['orderSinglePrice'],
      orderStatus: json['orderStatus'],
      taskUpdatedTime: json['taskUpdatedTime'],
      username: json['username'],
      avatar: json['avatar'],
      nickname: json['nickname'],
      categoryId: json['categoryId'],
      taskSinglePrice: json['taskSinglePrice'],
      taskQuota: json['taskQuota'],
      taskTimeLimit: json['taskTimeLimit'],
      taskTimeLimitUnit: json['taskTimeLimitUnit'],
      taskEstimateTime: json['taskEstimateTime'],
      taskEstimateTimeUnit: json['taskEstimateTimeUnit'],
      taskStatus: json['taskStatus'],
      taskProcedures: json['taskProcedures'] != null
          ? TaskProcedureModel.fromJson(json['taskProcedures'])
          : null,
      orderRejectReason: json['orderRejectReason'],
      taskCreatedTime: json['taskCreatedTime'],
      taskImagesPreview: json['taskImagesPreview'],
      taskReceivedNum: json['taskReceivedNum'],
      taskIsDelete: json['taskIsDelete'],
      collectionValid: json['collectionValid'],
      updatedTime: json['updatedTime'],
      orderBExpiredTime: json['orderBExpiredTime'],
      orderScreenshots: json['orderScreenshots'] != null
          ? OrderScreenShotList.fromJson(json['orderScreenshots'])
          : null,
      taskAmount: json['taskAmount'],
      taskFee: json['taskFee'],
      taskPrepay: json['taskPrepay'],
      taskRejectReason: json['taskRejectReason'],
      taskReeditTime: json['taskReeditTime'],
    );
  }
}

class TaskProcedureModel {
  List<TaskProcedureData> step;

  TaskProcedureModel({required this.step});

  Map<String, dynamic> toJson() {
    return {"step": step?.map((e) => e.toJson()).toList()};
  }

  factory TaskProcedureModel.fromJson(Map<String, dynamic> json) {
    return TaskProcedureModel(
        step: json['step'] != null
            ? List<TaskProcedureData>.from(
                json['step'].map((data) => TaskProcedureData.fromJson(data)))
            : []);
  }
}

class TaskProcedureData {
  List<String>? image;
  String instruction;

  TaskProcedureData({this.image, required this.instruction});

  Map<String, dynamic> toJson() {
    return {"image": image, "instruction": instruction};
  }

  factory TaskProcedureData.fromJson(Map<String, dynamic> json) {
    return TaskProcedureData(
        image: (json['image'] as List<dynamic>?)
            ?.map((item) => item as String)
            .toList(),
        instruction: json['instruction']);
  }
}

class TaskClass {
  final int? collectionId;
  final int? taskId;
  final String? customerId;
  final String? taskTitle;
  final String? taskContent;
  final double? taskSinglePrice;
  final String? taskTagIds;
  final List<TagData>? taskTagNames;
  final String? taskUpdatedTime;
  final String? nickname;
  final String? avatar;
  final bool? collectionValid;
  final String? updatedTime;

  TaskClass(
      {this.collectionId,
      this.taskId,
      this.customerId,
      this.taskTitle,
      this.taskContent,
      this.taskSinglePrice,
      this.taskTagIds,
      this.taskTagNames,
      this.taskUpdatedTime,
      this.nickname,
      this.avatar,
      this.collectionValid,
      this.updatedTime});

  factory TaskClass.fromJson(Map<String, dynamic> json) {
    return TaskClass(
        collectionId: json['collectionId'] ?? 0,
        taskId: json['taskId'] ?? 0,
        customerId: json['customerId'] ?? "",
        taskTitle: json['taskTitle'] ?? "",
        taskContent: json['taskContent'] ?? "",
        taskSinglePrice: json['taskSinglePrice'] ?? 0,
        taskTagIds: json['taskTagIds'] ?? "",
        taskTagNames: (json['taskTagNames'] as List<dynamic>?)
                ?.map((tagJson) => TagData.fromJson(tagJson))
                .toList() ??
            [],
        taskUpdatedTime: json['taskUpdatedTime'] ?? "",
        nickname: json['nickname'] ?? "",
        avatar: json['avatar'] ?? "",
        collectionValid: json['collectionValid'] == 1,
        updatedTime: json['updatedTime']);
  }

  Map<String, dynamic> toJson() {
    return {
      'taskId': taskId,
      'customerId': customerId,
      'taskTitle': taskTitle,
      'taskContent': taskContent,
      'taskSinglePrice': taskSinglePrice,
      'taskTagIds': taskTagIds,
      'taskTagNames': taskTagNames?.map((tag) => tag.toJson()).toList(),
      'taskUpdatedTime': taskUpdatedTime,
      'nickname': nickname,
      'avatar': avatar,
      'updatedTime': updatedTime
    };
  }
}

class Tag {
  final int? tagId;
  final String? tagName;

  Tag({
    this.tagId,
    this.tagName,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      tagId: json['tagId'] ?? 0,
      tagName: json['tagName'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tagId': tagId,
      'tagName': tagName,
    };
  }
}

//above is using for api only, below this is mock.
class MessageMockClass {
  final String title;
  bool? isApproved; // check if mission status out
  String? description;
  bool? isAccepted; // check it mission accepted by organize
  String? reason;
  double? rating;
  final String createdTime;
  final String updatedTime;

  MessageMockClass(
      {required this.title,
      this.isApproved,
      this.description,
      this.isAccepted,
      this.reason,
      this.rating,
      required this.createdTime,
      required this.updatedTime});
}

class PaymentMockClass {
  final bool complete;
  final String title;
  final String description;
  final int amount;
  final String date;

  PaymentMockClass({
    required this.complete,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
  });
}

class TicketMockClass {
  final bool complete;
  final String title;
  final String description;
  final String date;

  TicketMockClass({
    required this.complete,
    required this.title,
    required this.description,
    required this.date,
  });
}

class TicketRecordDetailsMockClass {
  final List<String>? submittedPic;

  TicketRecordDetailsMockClass({
    required this.submittedPic,
  });
}

class MissionMockClass {
  final String missionTitle;
  final String missionDesc;
  List<String>? tagList;
  final double missionPrice;
  final String userAvatar;
  final String username;
  final String? missionDate;
  bool isStatus;
  bool? isFavorite;
  int? missionStatus;
  final String? updatedTime;

  MissionMockClass(
      {required this.missionTitle,
      required this.missionDesc,
      required this.tagList,
      required this.missionPrice,
      required this.userAvatar,
      required this.username,
      this.missionDate,
      required this.isStatus,
      this.isFavorite,
      this.missionStatus,
      this.updatedTime});
}

class CustomerListModel {
  final int code;
  final String msg;
  final CustomerListData? data;

  CustomerListModel({
    required this.code,
    required this.msg,
    this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'msg': msg,
      'data': data?.toJson(),
    };
  }

  factory CustomerListModel.fromJson(Map<String, dynamic> json) {
    return CustomerListModel(
      code: json['code'],
      msg: json['msg'],
      data:
          json['data'] != null ? CustomerListData.fromJson(json['data']) : null,
    );
  }
}

class CustomerListData {
  final int totalCount;
  final List<CustomerList>? customerList;

  CustomerListData({required this.totalCount, required this.customerList});

  Map<String, dynamic> toJson() {
    return {
      'totalCount': totalCount,
      'customerList':
          customerList?.map((customer) => customer.toJson()).toList(),
    };
  }

  factory CustomerListData.fromJson(Map<String, dynamic> json) {
    return CustomerListData(
      totalCount: json['totalCount'],
      customerList: (json['customerList'] as List)
          .map((data) => CustomerList.fromJson(data))
          .toList(),
    );
  }
}

class CustomerList {
  final String customerId;
  final int? taskId;
  final int? orderId;
  final String nickname;
  final String avatar;
  final String? orderAExpiredTime;
  final String? orderBExpiredTime;

  CustomerList({
    required this.customerId,
    this.taskId,
    this.orderId,
    required this.nickname,
    required this.avatar,
    this.orderAExpiredTime,
    this.orderBExpiredTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'taskId': taskId,
      'orderId': orderId,
      'nickname': nickname,
      'avatar': avatar,
      'orderAExpiredTime': orderAExpiredTime,
      'orderBExpiredTime': orderBExpiredTime,
    };
  }

  factory CustomerList.fromJson(Map<String, dynamic> json) {
    return CustomerList(
      customerId: json['customerId'],
      taskId: json['taskId'],
      orderId: json['orderId'],
      nickname: json['nickname'],
      avatar: json['avatar'],
      orderAExpiredTime: json['orderAExpiredTime'],
      orderBExpiredTime: json['orderBExpiredTime'],
    );
  }
}

// class OrderSubmission {
//   final int orderId;
//   final OrderScreenShotList orderScreenshots;

//   OrderSubmission({
//     required this.orderId,
//     required this.orderScreenshots
//   });

//   Map<String, dynamic> toJson(){
//     return {
//       "orderId":orderId,
//       "orderScreenshots":orderScreenshots,
//     };
//   }
// }

class OrderScreenShotList {
  final List<String> image;

  OrderScreenShotList({required this.image});

  Map<String, dynamic> toJson() {
    return {"image": image};
  }

  factory OrderScreenShotList.fromJson(Map<String, dynamic> json) {
    return OrderScreenShotList(
      image: List<String>.from(json['image']),
    );
  }
}
