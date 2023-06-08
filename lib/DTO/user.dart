import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

class loginUser {
  late final String email;
  late final String pass;

  loginUser({required this.email, required this.pass});
}

class sectionAccount {
  late final String email;
  sectionAccount({
    required this.email,
  });
}

class User {
  late final String userId;
  late final String email;
  late final String phoneNumber;
  late final String fullname;
  late final String pass;
  late final String identitiCard;
  // late final bool paymentStatus;
  late final String familyId;

  User(
      {required this.userId,
      required this.email,
      required this.phoneNumber,
      required this.fullname,
      required this.pass,
      required this.identitiCard,
      required this.familyId});
  get GetuserId => userId;
  String get Getemail => email;
  String get GetphoneNumber => phoneNumber;
  String get Getfullname => fullname;
  String get Getpass => pass;
  String get GetIdentity => identitiCard;
  String get GetFamilyId => familyId;
}

Users userFromJson(String str) => Users.fromJson(json.decode(str));

String userToJson(Users data) => json.encode(data.toJson());

class Users {
  String? userId;
  String? email;
  String? phoneNumber;
  String? pass;
  String? fullname;
  String? identitiCard;
  String? familyId;

  Users({
    this.userId,
    this.email,
    this.phoneNumber,
    this.pass,
    this.fullname,
    this.identitiCard,
    this.familyId,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        userId: json["userId"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        pass: json["pass"],
        fullname: json["fullname"],
        identitiCard: json["identitiCard"],
        familyId: json["familyId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "phoneNumber": phoneNumber,
        "pass": pass,
        "fullname": fullname,
        "identitiCard": identitiCard,
        "familyId": familyId,
      };
}
