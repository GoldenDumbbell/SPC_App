// import 'dart:convert';
// // ignore: depend_on_referenced_packages
// import 'package:http/http.dart';

// import 'dart:async';

// import 'package:webspc/DTO/user.dart';

// import '../DTO/section.dart';

// class LoginService {
//   static Future<bool> CheckId() async {
//     bool check= true;
//     final response = await get(
//       Uri.parse("https://apiserverplan.azurewebsites.net/api/TbCars"),
//     );
//     if (response.statusCode == 200) {
//       var data = json.decode(response.body);
//       for (int i = 0; i < data.length; i++) {
//         if (Session.carUserInfor.carId == data[i]["carId"]) {
//           check= true;
//         } else {
//           check= false;
//         }
//       }
//     }
//     return check;
//   }
// }
