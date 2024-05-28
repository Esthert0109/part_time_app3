class BusinessScopeModel {
  final int code;
  final String msg;
  final BusinessScopeData? data;

  BusinessScopeModel({
    required this.code,
    required this.msg,
    this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "msg": msg,
      "data": data?.toJson(),
    };
  }
}

class BusinessScopeData {
  final int businessScopeId;
  final String businessScopeName;

  BusinessScopeData({
    required this.businessScopeId,
    required this.businessScopeName,
  });

  Map<String, dynamic> toJson() {
    return {
      "businessScopeId": businessScopeId,
      "businessScopeName": businessScopeName,
    };
  }

  factory BusinessScopeData.fromJson(Map<String, dynamic> json) {
    return BusinessScopeData(
      businessScopeId: json['businessScopeId'],
      businessScopeName: json['businessScopeName'],
    );
  }
}
