import 'dart:convert';

// class car {
//   late final String namecar;
//   late final String carplate;
//   late final String carfont;
//   late final String familyId;

//   car(
//       {required this.namecar,
//       required this.carplate,
//       required this.carfont,
//       required this.familyId});
// }

// class cars {
//   late final String namecar;
//   late final String carplate;
//   late final String carfont;

//   cars({
//     required this.namecar,
//     required this.carplate,
//     required this.carfont,
//   });
// }

Car carFromJson(String str) => Car.fromJson(json.decode(str));

String carToJson(Car data) => json.encode(data.toJson());

class Car {
  String? carId;
  String? carName;
  String? carPlate;
  String? carColor;
  String? carPaperFront;
  String? carPaperBack;
  bool? verifyState1;
  bool? verifyState2;
  String? securityCode;
  String? familyId;

  Car({
    this.carId,
    this.carName,
    this.carPlate,
    this.carColor,
    this.carPaperFront,
    this.carPaperBack,
    this.verifyState1,
    this.verifyState2,
    this.securityCode,
    this.familyId,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        carId: json["carId"],
        carName: json["carName"],
        carPlate: json["carPlate"],
        carColor: json["carColor"],
        carPaperFront: json["carPaperFront"],
        carPaperBack: json["carPaperBack"],
        verifyState1: json["verifyState1"],
        verifyState2: json["verifyState2"],
        securityCode: json["securityCode"],
        familyId: json["familyId"],
      );

  Map<String, dynamic> toJson() => {
        "carId": carId,
        "carName": carName,
        "carPlate": carPlate,
        "carColor": carColor,
        "carPaperFront": carPaperFront,
        "carPaperBack": carPaperBack,
        "verifyState1": verifyState1,
        "verifyState2": verifyState2,
        "securityCode": securityCode,
        "familyId": familyId,
        "family": null,
        "tbHistories": [],
      };
}
