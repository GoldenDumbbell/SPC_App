class History {
  String? historyId;
  String? timeIn;
  String? timeOut;
  String? amount;
  String? carPlate;
  History({
    required this.historyId,
    required this.timeIn,
    required this.timeOut,
    required this.amount,
    required this.carPlate,
  });
  factory History.fromJson(Map<String, dynamic> json) => History(
        historyId: json["historyId"],
        timeIn: json["timeIn"],
        timeOut: json["timeOut"],
        amount: json["amount"],
        carPlate: json["carPlate"],
      );
}
