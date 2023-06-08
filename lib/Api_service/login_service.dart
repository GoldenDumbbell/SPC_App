import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';

import 'dart:async';

import 'package:webspc/DTO/user.dart';

import '../DTO/section.dart';

class LoginService {
  static Future<bool> login(String email, String password) async {
    final response = await get(
      Uri.parse("https://apiserverplan.azurewebsites.net/api/TbUsers"),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        if (email == data[i]['email'] && password == data[i]['pass']) {
          Session.loggedInUser = Users(
            userId: data[i]['userId'],
            email: email,
            pass: data[i]['pass'],
            phoneNumber: data[i]['phoneNumber'],
            fullname: data[i]['fullname'],
            identitiCard: data[i]['identitiCard'],
            familyId: data[i]['familyId'],
          );
          return true;
        }
      }
    }
    return false;
  }
}
