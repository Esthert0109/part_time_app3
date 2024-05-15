class Collection {
  final int code;
  final String msg;
  final bool? data;

  Collection({
    required this.code,
    required this.msg,
    this.data,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      code: json['code'],
      msg: json['msg'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"code": code, "msg": msg, "data": data};
  }
}
