import 'package:flutter/material.dart';
import 'package:webspc/Api_service/booking_services.dart';
import 'package:webspc/Api_service/spot_service.dart';
import 'package:webspc/DTO/booking.dart';
import 'package:webspc/DTO/cars.dart';
import 'package:webspc/DTO/section.dart';
import 'package:webspc/DTO/spot.dart';
import 'package:webspc/styles/button.dart';

class CarInfoScreen extends StatefulWidget {
  final BuildContext? context;
  final Car car;
  const CarInfoScreen(this.context, {Key? key, required this.car})
      : super(key: key);

  @override
  _CarInfoScreenState createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  BuildContext? dialogContext;
  bool isLoading = true;
  String spotId = "No spot";
  // Get list of spot
  List<Spot> listSpot = [];
  void getListSpot() async {
    String tempSpotId = "No spot";
    listSpot = await SpotDetailService.getAllListSpot();
    for (var spot in listSpot) {
      if (spot.carId == widget.car.carId) {
        tempSpotId = spot.spotId!;
      }
    }
    setState(() {
      isLoading = false;
      spotId = tempSpotId;
    });
  }

  @override
  void initState() {
    getListSpot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/bga1png.png'),
          fit: BoxFit.cover,
        )),
        // padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "Your Car",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(
              height: 200,
            ),
            // Show car info include Spot, car name, car plate, car color
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                children: [
                  // Car name
                  Row(
                    children: [
                      Text(
                        "Spot: ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        spotId,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Car name: ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        widget.car.carName!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  // Car plate
                  Row(
                    children: [
                      Text(
                        "Car plate: ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        widget.car.carPlate!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  // Car color
                  Row(
                    children: [
                      Text(
                        "Car color: ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        widget.car.carColor!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}
