import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';

import 'dart:async';
import '../DTO/cars.dart';

class CarRegisterService {
  static Future registerCar(Car car) async {
    final response = await post(
      Uri.parse("https://apiserverplan.azurewebsites.net/api/TbCars"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "carId": car.carId,
        "carName": car.carName,
        "carPlate": car.carPlate,
        "carColor": car.carColor,
        "carPaperFront": car.carPaperFront,
        "carPaperBack": car.carPaperBack,
        "verifyState1": car.verifyState1,
        "verifyState2": car.verifyState2,
        "securityCode": car.securityCode,
        "familyId": car.familyId,
        "family": null,
        "tbHistories": []
      }),
    );
  }
}
