class AboutUsModel {
  final int code;
  final String msg;
  final AboutUsData? data;

  AboutUsModel({
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

class AboutUsData {
  final int aboutId;
  final String logo;
  final String workingTime;
  final String contactNumber;
  final String email;
  final String businessCooperation;
  final String companyName;
  final String createdTime;
  final String updatedTime;

  AboutUsData({
    required this.aboutId,
    required this.logo,
    required this.workingTime,
    required this.contactNumber,
    required this.email,
    required this.businessCooperation,
    required this.companyName,
    required this.createdTime,
    required this.updatedTime,
  });

  Map<String, dynamic> toJson() {
    return {
      "aboutId": aboutId,
      "logo": logo,
      "workingTime": workingTime,
      "contactNumber": contactNumber,
      "email": email,
      "businessCooperation": businessCooperation,
      "companyName": companyName,
      "createdTime": createdTime,
      "updatedTime": updatedTime
    };
  }

  factory AboutUsData.fromJson(Map<String, dynamic> json) {
    return AboutUsData(
      aboutId: json['aboutId'],
      logo: json['logo'],
      workingTime: json['workingTime'],
      contactNumber: json['contactNumber'],
      email: json['email'],
      businessCooperation: json['businessCooperation'],
      companyName: json['companyName'],
      createdTime: json['createdTime'],
      updatedTime: json['updatedTime']
    );
  }
}
