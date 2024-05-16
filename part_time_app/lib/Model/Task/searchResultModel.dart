class ResultResponse {
  final int code;
  final String msg;
  final ResultData data;

  ResultResponse({required this.code, required this.msg, required this.data});

  factory ResultResponse.fromJson(Map<String, dynamic> json) {
    return ResultResponse(
      code: json['code'],
      msg: json['msg'],
      data: ResultData.fromJson(json['data']),
    );
  }
}

class ResultData {
  final int totalAmountOfData;
  final List<TaskClass> tasks;

  ResultData({required this.totalAmountOfData, required this.tasks});

  factory ResultData.fromJson(Map<String, dynamic> json) {
    return ResultData(
      totalAmountOfData: json['totalAmountOfData'],
      tasks: List<TaskClass>.from(
          json['tasks'].map((task) => TaskClass.fromJson(task))),
    );
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
  final List<Tag>? taskTagNames;
  final String? taskUpdatedTime;
  final String? username;
  final String? avatar;
  final int? valid;

  TaskClass({
    this.collectionId,
    this.taskId,
    this.customerId,
    this.taskTitle,
    this.taskContent,
    this.taskSinglePrice,
    this.taskTagIds,
    this.taskTagNames,
    this.taskUpdatedTime,
    this.username,
    this.avatar,
    this.valid,
  });

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
          ?.map((tagJson) => Tag.fromJson(tagJson))
          .toList(),
      taskUpdatedTime: json['taskUpdatedTime'] ?? "",
      username: json['username'] ?? "",
      avatar: json['avatar'] ?? "",
      valid: json['valid'] ?? 1,
    );
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
      'username': username,
      'avatar': avatar,
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
