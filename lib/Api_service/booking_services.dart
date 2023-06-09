import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';

import 'dart:async';

import '../DTO/booking.dart';

class BookingService {
  // Generate new userId, which is the greatest userId in the list + 1
  static Future BookingSpot(Booking bookingspot) async {
    final response = await post(
      Uri.parse("https://apiserverplan.azurewebsites.net/api/TbBookings"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "bookingID": bookingspot.bookingId,
        "carPlate": bookingspot.carplate,
        "carColor": bookingspot.carColor,
        "datetime": bookingspot.dateTime,
        "userID": bookingspot.userId,
        "sensorID": bookingspot.sensorId,
        "sensor": null,
        "user": null
      }),
    );
  }
}
