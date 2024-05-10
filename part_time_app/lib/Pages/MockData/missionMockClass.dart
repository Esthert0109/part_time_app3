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
