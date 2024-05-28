class TagModel {
  final int code;
  final String msg;
  final List<TagData>? data;

  TagModel({required this.code, required this.msg, required this.data});

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "msg": msg,
      "data": data?.map((e) => e.toJson()).toList()
    };
  }

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
        code: json['code'],
        msg: json['msg'],
        data: json['data'] != null
            ? List<TagData>.from(
                json['data'].map((data) => TagData.fromJson(data)))
            : []);
  }
}

class TagData {
  final int tagId;
  final String tagName;
  final int? totalOccurrence;

  TagData({
    required this.tagId,
    required this.tagName,
    this.totalOccurrence,
  });

  Map<String, dynamic> toJson() {
    return {
      "tagId": tagId,
      "tagName": tagName,
      "totalOccurrence": totalOccurrence,
    };
  }

  factory TagData.fromJson(Map<String, dynamic> json) {
    return TagData(
        tagId: json['tagId'],
        tagName: json['tagName'],
        totalOccurrence: json['totalOccurrence']);
  }
}
