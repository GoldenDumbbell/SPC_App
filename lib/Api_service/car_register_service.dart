import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';

import 'dart:async';
import '../DTO/cars.dart';
import 'car_detail_service.dart';

class CarRegisterService {
  static Future registerCar(Car car) async {
    int newCarId = 0;
    final response1 = await get(
      Uri.parse("https://apiserverplan.azurewebsites.net/api/TbCars"),
    );
    if (response1.statusCode == 200) {
      var data = json.decode(response1.body);
      // Get list userId and email
      List<Map<String, dynamic>> carDetail = [];
      for (var i = 0; i < data.length; i++) {
        carDetail.add({
          'carId': int.parse(data[i]['carId']),
        });
      }

      // Generate new userId, which is the greatest userId in the list + 1
      for (var i = 0; i < carDetail.length; i++) {
        if (carDetail[i]['carId'] > newCarId) {
          newCarId = carDetail[i]['carId'];
        }
      }
      newCarId += 1;
    }

    final response = await post(
      Uri.parse("https://apiserverplan.azurewebsites.net/api/TbCars"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "carId": newCarId.toString(),
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
