import 'package:json_annotation/json_annotation.dart';
// part 'user_son.dart';

// @JsonSerializable()

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
  // late final String familyId;

  User({
    required this.userId,
    required this.email,
    required this.phoneNumber,
    required this.fullname,
    required this.pass,
    required this.identitiCard,
    // required this.familyId
  });
  get GetuserId => userId;
  String get Getemail => email;
  String get GetphoneNumber => phoneNumber;
  String get Getfullname => fullname;
  String get Getpass => pass;
  String get GetIdentity => identitiCard;
  // String get GetablockId => familyId;

  set SetuserId(String _userId) {
    userId = _userId;
  }

  set Setemail(String _email) {
    email = _email;
  }

  set SetphoneNumber(String _phoneNumber) {
    phoneNumber = _phoneNumber;
  }

  set Setfullname(String _fullname) {
    fullname = _fullname;
  }

  set Setpass(String _pass) {
    pass = _pass;
  }

  set SetIdentitiCard(String _IdentitiCard) {
    identitiCard = _IdentitiCard;
  }

  // set SetablockId(String _ablockId) {
  //   familyId = _ablockId;
  // }

  // Map<String, dynamic> toJson() => _$UserToJson(this);

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map["email"] = email;
    map['phoneNumber'] = phoneNumber;
    map['fullname'] = fullname;
    map['pass'] = pass;
    map['identitiCard'] = identitiCard;
    // map['familyId'] = familyId;

    if (userId != null) {
      map['userId'] = userId;
    }
    return map;
  }

  // factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  User.fromJson(dynamic o) {
    userId = o["userId"];
    email = o['email'];
    phoneNumber = o['phoneNumber'];
    fullname = o['fullname'];
    pass = o['pass'];
    identitiCard = o['identitiCard'];
    // familyId = o['familyId'];
  }

  // User.fromJson(Map<String, dynamic> json){
  //   userId = json['userId'];
  //   email = json['email'];
  //   phoneNumber = json['phoneNumber'];
  //   fullname = json['fullname'];
  //   pass = json['pass'];
  //   identitiCard = json['identitiCard'];
  //   // paymentStatus = json['paymentStatus'];
  //   ablockId = json['ablockId'];

  // }

  // Map<String, dynamic> toJson() {
  //   final dataa = <String, dynamic>{};
  //   userid:
  //   dataa['userId'];
  //   email:
  //   dataa['email'];
  //   phoneNumber:
  //   dataa['phoneNumber'];
  //   fullname:
  //   dataa['fullname'];
  //   pass:
  //   dataa['pass'];
  //   identitiCard:
  //   dataa['identiticard'];
  //   // paymentStatus:
  //   // dataa['paymentStatus'];
  //   ablockId:
  //   dataa['ablockId'];
  //   return dataa;
  // }
}
