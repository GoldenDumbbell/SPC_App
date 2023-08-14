class Bundle {
  String? bundleId;
  String? bundleName;
  double? price;
  Bundle({this.bundleId, this.bundleName, this.price});

  factory Bundle.fromJson(Map<String, dynamic> json) => Bundle(
        bundleId: json["bundleId"],
        bundleName: json["bundleName"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "bundleId": bundleId,
        "bundleName": bundleName,
        "price": price,
      };
}
