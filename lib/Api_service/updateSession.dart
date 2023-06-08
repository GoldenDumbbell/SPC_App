// import 'dart:convert';
// // ignore: depend_on_referenced_packages
// import 'package:http/http.dart';

// import 'dart:async';

// import 'package:webspc/DTO/user.dart';

// import '../DTO/section.dart';

// class UpdateSession {
//   static Future<List<Users>> updatesession() async {
//     final response = await get(
//       Uri.parse("https://apiserverplan.azurewebsites.net/api/TbUsers"),
//     );
//     if (response.statusCode == 200) {
//       var data = json.decode(response.body);
//       for (int i = 0; i < data.length; i++) {
//         if (Session.loggedInUser.userId == data[i]['userId']) {
//           Session.loggedInUser = Users(
//             userId: data[i]['userId'],
//             email: data[i]['email'],
//             pass: data[i]['pass'],
//             phoneNumber: data[i]['phoneNumber'],
//             fullname: data[i]['fullname'],
//             identitiCard: data[i]['identitiCard'],
//             familyId: data[i]['familyId'],
//           );
//         }
//       }
//     }
//     return List;
//   }
// }
