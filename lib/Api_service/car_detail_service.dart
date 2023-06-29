import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';

import 'dart:async';

import '../DTO/cars.dart';
import '../DTO/section.dart';

class CarDetailService {
  static Future<List<Car>> getListCar() async {
    List<Car> listCar = [];
    final response = await get(
      Uri.parse("https://primaryapinew.azurewebsites.net/api/TbCars"),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        if (Session.loggedInUser.familyId == data[i]['familyId']) {
          listCar.add(Car(
            carId: data[i]['carId'],
            carName: data[i]['carName'],
            carPlate: data[i]['carPlate'],
            carColor: data[i]['carColor'],
            carPaperFront: data[i]['carPaperFront'],
            carPaperBack: data[i]['carPaperBack'],
            verifyState1: data[i]['verifyState1'],
            verifyState2: data[i]['verifyState2'],
            securityCode: data[i]['securityCode'],
            historyID: data[i]['historyId'],
            familyId: data[i]['familyId'],
          ));
        }
      }
    }
    return listCar;
  }
}
