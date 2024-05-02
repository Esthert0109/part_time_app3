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
