import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';
import 'dart:async';

import '../DTO/cars.dart';
import '../DTO/section.dart';
import '../DTO/user.dart';

class UserInforService {
  // static Future UserInfor() async {
  //   List<Car> listCar = [];
  //   final response = await get(
  //     Uri.parse("https://apiserverplan.azurewebsites.net/api/TbUser"),
  //   );
  //   if (response.statusCode == 200) {
  //     var data = json.decode(response.body);
  //     for (int i = 0; i < data.length; i++) {
  //       if (Session.loggedInUser.familyId == data[i]['familyId']) {
  //         Session.carUserInfor = Car(
  //           carId: data[i]['carId'],
  //           carName: data[i]['carName'],
  //           carPlate: data[i]['carPlate'],
  //           carColor: data[i]['carColor'],
  //           carPaperFront: data[i]['carPaperFront'],
  //           carPaperBack: data[i]['carPaperBack'],
  //           verifyState1: data[i]['verifyState1'],
  //           verifyState2: data[i]['verifyState2'],
  //           securityCode: data[i]['securityCode'],
  //           familyId: data[i]['familyId'],
  //         );
  //       }
  //     }
  //   }
  //   return listCar;
  // }
  static Future Userinfor() async {
    List<Users> listuser = [];
    final response = await get(
      Uri.parse("https://apiserverplan.azurewebsites.net/api/TbUsers"),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        if (Session.loggedInUser.userId == data[i]['userID']) {
          Session.loggedInUser = Users(
            userId: data[i]['userId'],
            email: data[i]['email'],
            pass: data[i]['pass'],
            phoneNumber: data[i]['phoneNumber'],
            fullname: data[i]['fullname'],
            identitiCard: data[i]['identitiCard'],
            familyId: data[i]['familyId'],
          );
        }
      }
    }
    return listuser;
  }
}

class CarInforofUserService {
  static Future carUserInfor() async {
    final response = await get(
      Uri.parse("https://apiserverplan.azurewebsites.net/api/TbCars"),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        if (Session.loggedInUser.familyId == data[i]['familyId']) {
          Session.carUserInfor = Car(
            carId: data[i]['carId'],
            carName: data[i]['carName'],
            carPlate: data[i]['carPlate'],
            carColor: data[i]['carColor'],
            carPaperFront: data[i]['carPaperFront'],
            carPaperBack: data[i]['carPaperBack'],
            verifyState1: data[i]['verifyState1'],
            verifyState2: data[i]['verifyState2'],
            securityCode: data[i]['securityCode'],
            familyId: data[i]['familyId'],
          );
        }
      }
    }
  }
}
