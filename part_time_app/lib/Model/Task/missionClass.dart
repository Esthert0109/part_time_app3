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
