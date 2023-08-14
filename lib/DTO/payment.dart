class Payment {
  /*
  "paymentId": "4",
    "paymentdate": "2023-03-03T00:00:00",
    "status": true,
    "amount": 1400000,
    "userId": "1",
    "purpose": "buy spot"
    */
  String? paymentId;
  String? paymentdate;
  bool? status;
  double? amount;
  String? userId;
  String? purpose;
  String? bundleId;
  DateTime? joinDay;
  DateTime? expiredDay;

  Payment({
    required this.paymentId,
    required this.paymentdate,
    required this.status,
    required this.amount,
    required this.userId,
    required this.purpose,
    required this.bundleId,
    required this.joinDay,
    required this.expiredDay,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        paymentId: json["paymentId"],
        paymentdate: json["paymentdate"],
        status: json["status"],
        amount: json["amount"],
        userId: json["userId"],
        purpose: json["purpose"],
        bundleId: json["bundleId"],
        joinDay: DateTime.parse(json["joinDay"]),
        expiredDay: DateTime.parse(json["expiredDay"]),
      );
}
