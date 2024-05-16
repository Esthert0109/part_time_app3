class AdvertisementModel {
  final int code;
  final String msg;
  final List<AdvertisementData>? data;

  AdvertisementModel({
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

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) {
    return AdvertisementModel(
        code: json['code'],
        msg: json['msg'],
        data: json['data'] != null
            ? List<AdvertisementData>.from(
                json['data'].map((data) => AdvertisementData.fromJson(data)))
            : null);
  }
}

class AdvertisementData {
  final int? advertisementId;
  final String? advertisementImage;
  final int? taskId;
  final int? isDelete;
  final String? createdTime;
  final String? updatedTime;

  AdvertisementData({
    this.advertisementId,
    this.advertisementImage,
    this.taskId,
    this.isDelete,
    this.createdTime,
    this.updatedTime,
  });

  Map<String, dynamic> toJson() {
    return {
      "advertisementId": advertisementId,
      "advertisementImage": advertisementImage,
      "taskId": taskId,
      "isDelete": isDelete,
      "createdTime": createdTime,
      "updatedTime": updatedTime,
    };
  }

  factory AdvertisementData.fromJson(Map<String, dynamic> json) {
    return AdvertisementData(
      advertisementId: json['advertisementId'],
      advertisementImage: json['advertisementImage'],
      taskId: json['taskId'],
      isDelete: json['isDelete'],
      createdTime: json['createdTime'],
      updatedTime: json['updatedTime'],
    );
  }
}
