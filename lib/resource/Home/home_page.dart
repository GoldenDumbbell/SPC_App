import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:webspc/Api_service/car_service.dart';
import 'package:webspc/Api_service/user_infor_service.dart';
import 'package:webspc/DTO/Qr.dart';
import 'package:webspc/DTO/spot.dart';
import 'package:webspc/resource/Home/Parking_spot.dart';
import 'package:webspc/navigationbar.dart';
import 'package:webspc/resource/Home/BookingScreen.dart';
import 'package:webspc/resource/Home/View_hisbooking.dart';
import 'package:webspc/styles/button.dart';
import '../../Api_service/car_detail_service.dart';
import '../../DTO/cars.dart';
import '../../DTO/section.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomePageState();
}

class HomePageState extends State<HomeScreen> {
  String? Codesecurity;
  String? code = '';
  int selectedIndex = 0;
  int selectedCatIndex = 0;
  List<Car> listCar = [];
  Car? carDetail;
  Car? dropdownValue;
  String? Carplate;
  BuildContext? dialogContext;

  @override
  void initState() {
    getListCar();
    // getCarUserInfor();
    super.initState();
  }

  // void getCarUserInfor() {
  //   CarInforofUserService.carUserInfor().then((value) => setState(() {}));
  //   // Carplate = Session.carUserInfor.carPlate;
  // }

  void getListCar() {
    CarDetailService.getListCar().then((response) => setState(() {
          listCar = response;
        }));
  }

  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String currentTime = DateFormat('yyyy-MM-dd  kk:mm').format(now);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/bga1png.png'),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Image(image: AssetImage('images/iconn.png')),
            ),
            Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  '----------------------------------------------------------------------------------------------------',
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Color.fromARGB(100, 161, 125, 17)),
                )),
            Container(
              // decoration: BoxDecoration(
              //   color: Colors.cyanAccent,
              // ),
              height: 50,
              padding: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.favorite_sharp,
                        color: Color.fromARGB(100, 161, 125, 17),
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Hello, ${Session.loggedInUser.fullname ?? ""}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  SizedBox(
                    width: 110,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, ViewHistoryPage.routerName);
                      },
                      child: Icon(
                        Icons.book_online_sharp,
                        size: 40,
                        color: Color.fromARGB(255, 165, 110, 7),
                      )),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              width: 390,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 143, 146, 146).withOpacity(0.4),
                border: Border.all(color: Colors.black38, width: 3),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                            padding: EdgeInsets.only(left: 50),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Car>(
                                alignment: Alignment.center,
                                dropdownColor:
                                    Color.fromARGB(255, 143, 146, 146),
                                underline: Container(),
                                borderRadius: BorderRadius.circular(30),
                                hint: const Text(
                                  'Today, What car you use?',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                // icon: Image.asset('images/carrr.png'),
                                // iconSize: 45,
                                onChanged: (Car? newvalue) {
                                  setState(() {
                                    dropdownValue = newvalue!;
                                  });
                                },
                                value: dropdownValue,
                                items: listCar
                                    .map<DropdownMenuItem<Car>>((Car value) {
                                  return DropdownMenuItem<Car>(
                                      value: value,
                                      // child: Text('${value.carPlate}'),
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            WidgetSpan(
                                                child: Icon(
                                              Icons.directions_car_sharp,
                                              size: 30,
                                            )),
                                            TextSpan(
                                                text:
                                                    '          ${value.carPlate}'),
                                          ],
                                        ),
                                      ));
                                }).toList(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                ),
                                elevation: 8,
                                isExpanded: true,
                              ),
                            )),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  height: 200,
                  width: 420,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                          width: 2.0, color: Color.fromARGB(100, 161, 125, 17)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text('Balance',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold))
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: buttonPrimary,
                onPressed: () {
                  Navigator.pushNamed(context, Booking1Screen.routerName);
                },
                child: Text(
                  'Booking',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton.icon(
                style: buttonPrimary,
                onPressed: () {
                  Navigator.pushNamed(context, viewSpotPage.routerName);
                },
                icon: Icon(
                  Icons.directions_car_outlined,
                  size: 50,
                ),
                label: Text(
                  'CHECK SPOT',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton.icon(
                style: buttonPrimary,
                onPressed: () {},
                icon: Icon(
                  Icons.directions_car_outlined,
                  size: 50,
                ),
                label: Text(
                  'CHECK YOUR CAR',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(color: Colors.white, spreadRadius: 7, blurRadius: 1)
        ]),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              code = dropdownValue?.carPlate;
              var rng = Random();
              for (var i = 100000; i < 1000000; i++) {
                Codesecurity = rng.nextInt(1000000).toString();
                break;
              }

              DateTime now = DateTime.now();
              String formattedDate =
                  DateFormat('yyyy-MM-dd – kk:mm').format(now);

              Map<String, dynamic> toJson() => {
                    "carID": dropdownValue?.carPlate,
                    "time": currentTime,
                    "securityCode": Codesecurity,
                    "fullname": Session.loggedInUser.fullname,
                  };
            });
            if (dropdownValue?.carPlate == null) {
              showDialog(
                  context: context,
                  builder: (context) => Form(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            left: 60, right: 60, top: 350, bottom: 400),
                        child: Container(
                          padding: EdgeInsets.only(left: 9, top: 30),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              border: Border.all(
                                  width: 2.0,
                                  color: Color.fromARGB(100, 161, 125, 17)),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            "Please choose your car!",
                            style: TextStyle(
                                fontSize: 20,
                                decoration: TextDecoration.none,
                                color: Colors.black),
                          ),
                        ),
                      )));
            } else if (dropdownValue?.verifyState1 == null ||
                dropdownValue?.verifyState1 == false) {
              showDialog(
                  context: context,
                  builder: (context) => Form(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            left: 40, right: 40, top: 350, bottom: 390),
                        child: Container(
                          padding: EdgeInsets.only(left: 9),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              border: Border.all(
                                  width: 2.0,
                                  color: Color.fromARGB(100, 161, 125, 17)),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            "*Your car is not authenticated state 1!\n*Please waiting for admin to authenticated state 1",
                            style: TextStyle(
                                fontSize: 20,
                                decoration: TextDecoration.none,
                                color: Colors.black),
                          ),
                        ),
                      )));
            } else {
              Car car = Car(
                  carId: dropdownValue!.carId,
                  carName: dropdownValue!.carName,
                  carPlate: dropdownValue!.carPlate,
                  carColor: dropdownValue!.carColor,
                  carPaperFront: dropdownValue!.carPaperFront,
                  carPaperBack: dropdownValue!.carPaperBack,
                  verifyState1: dropdownValue!.verifyState1,
                  verifyState2: dropdownValue!.verifyState2,
                  securityCode: Codesecurity,
                  historyID: dropdownValue!.historyID,
                  familyId: dropdownValue!.familyId);
              CarService.updateCar(car, dropdownValue!.carId!)
                  .then((value) => Timer(const Duration(seconds: 120), () {
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => HomeScreen()),
                            //   (route) => false,
                            // );
                          })

                      //       Car car = Car(
                      //           carId: dropdownValue!.carId,
                      //           carName: dropdownValue!.carName,
                      //           carPlate: dropdownValue!.carPlate,
                      //           carColor: dropdownValue!.carColor,
                      //           carPaperFront: dropdownValue!.carPaperFront,
                      //           carPaperBack: dropdownValue!.carPaperBack,
                      //           verifyState1: dropdownValue!.verifyState1,
                      //           verifyState2: dropdownValue!.verifyState2,
                      //           securityCode: null,
                      //           familyId: dropdownValue!.familyId);
                      //       CarService.updateCar(car, dropdownValue!.carId!)
                      //           .then((value) => Navigator.pop(context));
                      //     })

                      );

              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => Form(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            left: 60, right: 60, top: 150, bottom: 150),
                        child: Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 2.0,
                                    color: Color.fromARGB(100, 161, 125, 17)),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                const Text('Your QR Code',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Text(
                                      'Please present your QR code to the parking lot',
                                      style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.grey,
                                        fontSize: 8,
                                      )),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                code == ''
                                    ? Text('')
                                    : BarcodeWidget(
                                        barcode: Barcode.qrCode(
                                          errorCorrectLevel:
                                              BarcodeQRCorrectionLevel.high,
                                        ),

                                        data: QrToJson(Qrcode(
                                            carplate: dropdownValue?.carPlate,
                                            datetime: currentTime,
                                            securityCode: Codesecurity,
                                            username:
                                                Session.loggedInUser.fullname)),
                                        // 'carplate: ${dropdownValue?.carPlate} \ntime: $currentTime \nHint code: $Codesecurity\n user: ${Session.loggedInUser.fullname}',
                                        width: 200,
                                        height: 200,
                                      ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 60,
                                    // right: 60,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Image.asset(
                                        'images/carrr.png',
                                        fit: BoxFit.cover,
                                        width: 30,
                                        height: 30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('${dropdownValue?.carPlate}',
                                          style: const TextStyle(
                                              decoration: TextDecoration.none,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  height: 50,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 3.0, color: Colors.blue),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Time In',
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "${now}",
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 26, 145, 243)),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    height: 50,
                                    width: 250,
                                    child: ElevatedButton(
                                      child: Text(
                                        "Exit",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()),
                                          (route) => false,
                                        );
                                      },
                                    )),
                              ],
                            )),
                      )));
            }
            ;
          },
          child: const Icon(
            Icons.qr_code,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomNavigationBar(selectedCatIndex, context),
    );
  }
}
