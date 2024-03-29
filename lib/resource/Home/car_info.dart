import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:webspc/Api_service/car_detail_service.dart';
import 'package:webspc/Api_service/spot_service.dart';
import 'package:webspc/DTO/cars.dart';
import 'package:webspc/DTO/payment.dart';
import 'package:webspc/DTO/section.dart';
import 'package:webspc/DTO/spot.dart';

import '../../Api_service/payment_service.dart';

class CarInfoScreen extends StatefulWidget {
  final BuildContext? context;
  //final Car car;
  const CarInfoScreen(this.context, {Key? key}) : super(key: key);

  @override
  _CarInfoScreenState createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  BuildContext? dialogContext;
  bool isLoading = true;
  String spotId = "No spot";
  List<Car> listCar = [];
  // Get list of spot
  List<Spot> listSpot = [];
  List<Payment> listPayment = [];

  void getListSpot() async {
    SpotDetailService.getAllListSpot().then((value) {
      setState(() {
        listSpot = value;
        isLoading = false;
      });
    });
  }

  void getListCar() async {
    await CarDetailService.getListCar().then((res) {
      setState(() {
        listCar = res;
      });
    });
  }

  void getListPayment() {
    PaymentService.getAllPayment().then((value) {
      value.sort((a, b) => DateTime.parse(b.paymentdate ?? '')
          .compareTo(DateTime.parse(a.paymentdate ?? '')));
      setState(() {
        listPayment = value;
      });
    });
  }

  @override
  void initState() {
    getListSpot();
    getListCar();
    getListPayment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        body: Container(
          width: double.infinity, height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/bga1png.png'),
            fit: BoxFit.cover,
          )),
          // padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
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
              Expanded(
                child: listCar.length == 0
                    ? Text("No car")
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: listCar.length,
                        itemBuilder: (context, index) {
                          return buildCarButton(listCar[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget buildCarButton(Car car) {
    String spotName = "No spot";
    int dayRemain = 0;
    for (var spot in listSpot) {
      if (spot.carId == car.carPlate) {
        spotName = spot.location!;
      }
    }
    for (var payment in listPayment) {
      // Check if purpose contains car plate
      if (payment.purpose!.contains(car.carPlate!) &&
          (payment.purpose!.contains("Buy spot") ||
              payment.purpose!.contains("Buy park"))) {
        // Check if payment is expired
        if (DateTime.parse(payment.paymentdate!)
            .add(Duration(days: 30))
            .isAfter(DateTime.now())) {
          dayRemain = DateTime.parse(payment.paymentdate!)
              .add(Duration(days: 30))
              .difference(DateTime.now())
              .inDays;
        } else {
          dayRemain = 0;
        }
        break;
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: DottedBorder(
        dashPattern: [8, 4],
        color: Colors.white,
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        padding: EdgeInsets.all(6),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child: SizedBox(
            height: 280,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        height: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Car owner: ${Session.loggedInUser.fullname}",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Car color: ${car.carColor}",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  car.carName!,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  car.carPlate!,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Authentication status: ',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                car.verifyState1 ?? false
                                    ? Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                      ),
                              ],
                            ),
                            Text(
                              'Day remain: ${dayRemain.toString()} ${dayRemain == 1 ? 'day' : 'days'}',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 400,
                      child: Image(
                        image: AssetImage('images/car.png'),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Column(
                      children: [
                        Text(
                          car.carName!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          car.carPlate!.substring(0, 3),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          car.carPlate!.substring(4),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      spotName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
