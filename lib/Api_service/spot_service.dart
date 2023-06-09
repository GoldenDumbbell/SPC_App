import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';
import 'dart:async';
import 'package:webspc/DTO/spot.dart';

class SpotDetailService {
  static Future<List<Spot>> getListSpot() async {
    List<Spot> listSpot = [];
    final response = await get(
      Uri.parse("https://apiserverplan.azurewebsites.net/api/TbSpots"),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        if (data[i]["available"] == true) {
          listSpot.add(Spot(
              spotId: data[i]["sensorId"],
              available: data[i]["available"],
              location: data[i]["location"],
              blockId: data[i]["ablockId"]));
        }
      }
    }
    return listSpot;
  }
}
