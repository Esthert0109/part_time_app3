class Payment {
  final String date;
  final List<PaymentData> payments;

  Payment({
    required this.date,
    required this.payments,
  });

  factory Payment.fromJson(String date, List<dynamic> json) {
    List<PaymentData> payments =
        json.map((item) => PaymentData.fromJson(item)).toList();
    return Payment(
      date: date,
      payments: payments,
    );
  }
}

class PaymentData {
  final int paymentId;
  final String paymentTotalAmount;
  final String paymentCreatedTime;
  final String paymentHistoryTitle;
  final String paymentHistoryDescription;

  PaymentData({
    required this.paymentId,
    required this.paymentTotalAmount,
    required this.paymentCreatedTime,
    required this.paymentHistoryTitle,
    required this.paymentHistoryDescription,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      paymentId: json['paymentId'],
      paymentTotalAmount: json['paymentTotalAmount'],
      paymentCreatedTime: json['paymentCreatedTime'],
      paymentHistoryTitle: json['paymentHistoryTitle'],
      paymentHistoryDescription: json['paymentHistoryDescription'],
    );
  }
}

class PaymentDetail {
  final int? paymentId;
  final int? taskId;
  final String? taskTitle;
  final String? paymentFromCustomerId;
  final String? paymentToCustomerId;
  final String? paymentToCustomerName;
  final int? paymentType;
  final int? paymentStatus;
  final int? paymentSide;
  final String? paymentUsername;
  final String? paymentBillingAddress;
  final String? paymentBillingNetwork;
  final String? paymentBillingCurrency;
  final String? paymentBillingImage;
  final String? paymentBillingUrl;
  final double? paymentAmount;
  final double? paymentFee;
  final double? paymentTotalAmount;
  final String? paymentCreatedTime;

  PaymentDetail({
    this.paymentId,
    this.taskId,
    this.taskTitle,
    this.paymentFromCustomerId,
    this.paymentToCustomerId,
    this.paymentToCustomerName,
    this.paymentType,
    this.paymentStatus,
    this.paymentSide,
    this.paymentUsername,
    this.paymentBillingAddress,
    this.paymentBillingNetwork,
    this.paymentBillingCurrency,
    this.paymentBillingImage,
    this.paymentBillingUrl,
    this.paymentAmount,
    this.paymentFee,
    this.paymentTotalAmount,
    this.paymentCreatedTime,
  });

  factory PaymentDetail.fromJson(Map<String, dynamic> json) {
    return PaymentDetail(
        paymentId: json['paymentId'] ?? 0,
        taskId: json['taskId'] ?? 0,
        taskTitle: json['taskTitle'] ?? "",
        paymentFromCustomerId: json['paymentFromCustomerId'] ?? "",
        paymentToCustomerId: json['paymentToCustomerId'] ?? "",
        paymentToCustomerName: json['paymentToCustomerName'] ?? "",
        paymentType: json['paymentType'] ?? 5,
        paymentStatus: json['paymentStatus'] ?? 5,
        paymentSide: json['paymentSide'] ?? 5,
        paymentUsername: json['paymentUsername'],
        paymentBillingAddress: json['paymentBillingAddress'] ?? "",
        paymentBillingNetwork: json['paymentBillingNetwork'] ?? "",
        paymentBillingCurrency: json['paymentBillingCurrency'] ?? "",
        paymentBillingImage: json['paymentBillingImage'] ?? "",
        paymentBillingUrl: json['paymentBillingUrl'] ?? "",
        paymentAmount: json['paymentAmount'] ?? 0,
        paymentFee: json['paymentFee'] ?? 0,
        paymentTotalAmount: json['paymentTotalAmount'] ?? 0,
        paymentCreatedTime: json['paymentCreatedTime']);
  }
  String paymentTypeStatus() {
    if (paymentType == null || paymentStatus == null || paymentSide == null) {
      return 'Invalid data';
    }
    return '${paymentType}${paymentStatus}${paymentSide}';
  }
}
