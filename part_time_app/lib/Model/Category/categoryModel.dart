class CategoryModel {
  final int code;
  final String msg;
  final List<CategoryListData>? data;

  CategoryModel({required this.code, required this.msg, required this.data});

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'msg': msg,
      'data': data?.map((json) => json.toJson()).toList()
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        code: json['code'],
        msg: json['msg'],
        data: json['data'] != null
            ? List<CategoryListData>.from(
                json['data'].map((data) => CategoryListData.fromJson(data)))
            : null);
  }
}

class CategoryListData {
  final int categoryId;
  final String categoryName;
  final String categoryAvatar;
  final String categoryCreatedTime;
  final String categoryUpdatedTime;

  CategoryListData({
    required this.categoryId,
    required this.categoryName,
    required this.categoryAvatar,
    required this.categoryCreatedTime,
    required this.categoryUpdatedTime,
  });

  Map<String, dynamic> toJson() {
    return {
      "categoryId": categoryId,
      "categoryName": categoryName,
      "categoryAvatar": categoryAvatar,
      "categoryCreatedTime": categoryCreatedTime,
      "categoryUpdatedTime": categoryUpdatedTime,
    };
  }

  factory CategoryListData.fromJson(Map<String, dynamic> json) {
    return CategoryListData(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      categoryAvatar: json['categoryAvatar'],
      categoryCreatedTime: json['categoryCreatedTime'],
      categoryUpdatedTime: json['categoryUpdatedTime'],
    );
  }
  @override
  String toString() {
    return 'CategoryListData{categoryId: $categoryId, categoryName: $categoryName, categoryAvatar: $categoryAvatar, categoryCreatedTime: $categoryCreatedTime, categoryUpdatedTime: $categoryUpdatedTime}';
  }
}
