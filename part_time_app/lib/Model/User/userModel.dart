class LoginUserModel {
  final int code;
  final String msg;
  final LoginData? data;

  LoginUserModel({
    required this.code,
    required this.msg,
    this.data,
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     "code": code,
  //     "msg": msg,
  //     "data": data?.toJson(),
  //   };
  // }
}

class LoginData {
  final String? token;

  LoginData({this.token});

  Map<String, dynamic> toJson() {
    return {
      "token": token,
    };
  }

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(token: json['token']);
  }
}

class CheckOTPModel {
  final int code;
  final String msg;
  final bool? data;

  CheckOTPModel({
    required this.code,
    required this.msg,
    this.data,
  });

  Map<String, dynamic> toJson() {
    return {"code": code, "msg": msg, "data": data};
  }
}

class CheckUserModel {
  final int code;
  final String msg;
  final String data;

  CheckUserModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return {"code": code, "msg": msg, "data": data};
  }
}

class OTPUserModel {
  final int? code;
  final String? msg;
  final OtpData? data;

  OTPUserModel({
    this.code,
    this.msg,
    this.data,
  });

  Map<String, dynamic> toJson() {
    return {"code": code, "msg": msg, "data": data?.toJson()};
  }
}

class OtpData {
  final int datetime;
  final String message;

  OtpData({
    required this.datetime,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {"datetime": datetime, "message": message};
  }

  factory OtpData.fromJson(Map<String, dynamic> json) {
    return OtpData(datetime: json['datetime'], message: json['message']);
  }
}

class UserModel {
  final int? code;
  final String? msg;
  final UserData? data;

  UserModel({
    this.code,
    this.msg,
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

class UpdateCollectionModel {
  final int? code;
  final String? msg;
  final bool? data;

  UpdateCollectionModel({
    this.code,
    this.msg,
    this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "msg": msg,
      "data": data,
    };
  }
}

class UpdateCustomerInfoModel {
  final int? code;
  final String? msg;
  final bool? data;

  UpdateCustomerInfoModel({
    this.code,
    this.msg,
    this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "msg": msg,
      "data": data,
    };
  }
}

class UploadCustomerAvatarModel {
  final int? code;
  final String? msg;
  final String? data;

  UploadCustomerAvatarModel({
    this.code,
    this.msg,
    this.data,
  });

  factory UploadCustomerAvatarModel.fromJson(Map<String, dynamic> json) {
    return UploadCustomerAvatarModel(
      code: json['code'],
      msg: json['msg'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "msg": msg,
      "data": data,
    };
  }
}

class UserData {
  final String? customerId;
  final String? nickname;
  final String? username;
  final String? password;
  final String? country;
  final String? gender;
  final String? avatar;
  final String? firstPhoneNo;
  final String? secondPhoneNo;
  final String? email;
  final int? businessScopeId;
  final String? businessScopeName;
  final String? billingNetwork;
  final String? billingAddress;
  final String? billingCurrency;
  final int? validIdentity;
  final int? valid;
  int? collectionValid; //system setting, default 1 = public, while 0 = private
  final String? createdTime;
  final String? updatedTime;
  final int? status;
  final String? rejectReason;
  final String? rejectedReason;

  UserData(
      {this.customerId,
      this.nickname,
      this.username,
      this.password,
      this.country,
      this.gender,
      this.avatar,
      this.firstPhoneNo,
      this.secondPhoneNo,
      this.email,
      this.businessScopeId,
      this.billingNetwork,
      this.billingAddress,
      this.billingCurrency,
      this.validIdentity,
      this.valid,
      this.collectionValid,
      this.createdTime,
      this.updatedTime,
      this.businessScopeName,
      this.status,
      this.rejectReason,
      this.rejectedReason});

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
      "businessScopeName": businessScopeName,
      "billingNetwork": billingNetwork,
      "billingAddress": billingAddress,
      "billingCurrency": billingCurrency,
      "validIdentity": validIdentity,
      "collectionValid": collectionValid,
      "valid": valid,
      "createdTime": createdTime,
      "updatedTime": updatedTime,
      "status": status,
      "rejectReason": rejectReason,
      "rejectedReason": rejectedReason
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
        businessScopeName: json['businessScopeName'],
        billingNetwork: json['billingNetwork'],
        billingAddress: json['billingAddress'],
        billingCurrency: json['billingCurrency'],
        validIdentity: json['validIdentity'],
        valid: json['valid'],
        collectionValid: json['collectionValid'],
        createdTime: json['createdTime'],
        updatedTime: json['updatedTime'],
        status: json['status'],
        rejectReason: json['rejectReason'],
        rejectedReason: json['rejectedReason']);
  }

  void clear() {}
}
