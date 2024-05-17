class Payment {
  final int paymentId;
  final String paymentTotalAmount;
  final String paymentCreatedTime;
  final String paymentHistoryTitle;
  final String paymentHistoryDescription;

  Payment({
    required this.paymentId,
    required this.paymentTotalAmount,
    required this.paymentCreatedTime,
    required this.paymentHistoryTitle,
    required this.paymentHistoryDescription,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentId: json['paymentId'],
      paymentTotalAmount: json['paymentTotalAmount'],
      paymentCreatedTime: json['paymentCreatedTime'],
      paymentHistoryTitle: json['paymentHistoryTitle'],
      paymentHistoryDescription: json['paymentHistoryDescription'],
    );
  }
}

class PaymentData {
  final String date;
  final List<Payment> payments;

  PaymentData({
    required this.date,
    required this.payments,
  });

  factory PaymentData.fromJson(String date, List<dynamic> json) {
    List<Payment> payments =
        json.map((item) => Payment.fromJson(item)).toList();
    return PaymentData(
      date: date,
      payments: payments,
    );
  }
}
