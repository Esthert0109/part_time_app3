class UserModel {
  final int code;
  final String msg;
  final UserData? data;

  UserModel({
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

class UserData {
  final String customerId;
  final String? nickname;
  final String username;
  final String password;
  final String? country;
  final String? gender;
  final String? avatar;
  final String firstPhoneNo;
  final String? secondPhoneNo;
  final String? email;
  final int? businessScopeId;
  final String? bilingNetwork;
  final String? bilingAddress;
  final String? bilingCurrency;
  final int? validIdentity;
  final int? collectionValid;
  final String? createdTime;
  final String? updatedTime;

  UserData({
    required this.customerId,
    this.nickname,
    required this.username,
    required this.password,
    this.country,
    this.gender,
    this.avatar,
    required this.firstPhoneNo,
    this.secondPhoneNo,
    this.email,
    this.businessScopeId,
    this.bilingNetwork,
    this.bilingAddress,
    this.bilingCurrency,
    this.validIdentity,
    this.collectionValid,
    this.createdTime,
    this.updatedTime,
  });

  Map<String, dynamic> toJson() {
    return {
      "customerId": customerId,
      "nickname": nickname,
      "username": username,
      "password": password,
      "country": country,
      "gender": gender,
      "avatar": avatar,
      "firstPhoneNo": firstPhoneNo,
      "secondPhoneNo": secondPhoneNo,
      "email": email,
      "businessScopeId": businessScopeId,
      "bilingNetwork": bilingNetwork,
      "bilingAddress": bilingAddress,
      "bilingCurrency": bilingCurrency,
      "validIdentity": validIdentity,
      "collectionValid": collectionValid,
      "createdTime": createdTime,
      "updatedTime": updatedTime,
    };
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      customerId: json['customerId'],
      nickname: json['nickname'],
      username: json['username'],
      password: json['password'],
      country: json['country'],
      gender: json['gender'],
      avatar: json['avatar'],
      firstPhoneNo: json['firstPhoneNo'],
      secondPhoneNo: json['secondPhoneNo'],
      email: json['email'],
      businessScopeId: json['businessScopeId'],
      bilingNetwork: json['bilingNetwork'],
      bilingAddress: json['bilingAddress'],
      bilingCurrency: json['bilingCurrency'],
      validIdentity: json['validIdentity'],
      collectionValid: json['collectionValid'],
      createdTime: json['createdTime'],
      updatedTime: json['updatedTime'],
    );
  }
}
