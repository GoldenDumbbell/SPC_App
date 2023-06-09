import 'dart:convert';

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
