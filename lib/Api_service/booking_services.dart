import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'dart:async';

import '../DTO/booking.dart';

class BookingService {
  // Generate new userId, which is the greatest userId in the list + 1
  static Future BookingSpot(Booking bookingspot) async {
    DateTime now = DateTime.now();
    String currentTime = DateFormat('yyyy-MM-dd  kk:mm').format(now);
    int newBookingId = 0;
    final response1 = await get(
      Uri.parse('https://apiserverplan.azurewebsites.net/api/TbBookings'),
    );
    if (response1.statusCode == 200) {
      var data = json.decode(response1.body);
      // Get list userId and email
      List<Map<String, dynamic>> booking = [];
      for (var i = 0; i < data.length; i++) {
        booking.add({
          'bookingId': int.parse(data[i]['bookingId']),
        });
      }

      // Generate new userId, which is the greatest userId in the list + 1
      for (var i = 0; i < booking.length; i++) {
        if (booking[i]['bookingId'] > newBookingId) {
          newBookingId = booking[i]['bookingId'];
        }
      }
      newBookingId += 1;
    }
    final response = await post(
      Uri.parse("https://apiserverplan.azurewebsites.net/api/TbBookings"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "bookingID": newBookingId.toString(),
        "carPlate": bookingspot.carplate,
        "carColor": bookingspot.carColor,
        "datetime": now.toIso8601String(),
        "userID": bookingspot.userId,
        "sensorID": bookingspot.sensorId,
        "sensor": null,
        "user": null
      }),
    );
  }
}
