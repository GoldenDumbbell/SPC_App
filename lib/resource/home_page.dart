import 'package:intl/intl.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:webspc/Api_service/user_infor_service.dart';
import 'package:webspc/resource/navigationbar.dart';
import 'package:webspc/styles/button.dart';
import '../DTO/section.dart';
import 'dart:math';
import 'BookingScreen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomePageState();
}

class HomePageState extends State<HomeScreen> {
  String? Codesecurity;
  var code = '';
  String? Carplate;
  int selectedIndex = 0;
  int selectedCatIndex = 0;
  @override
  void initState() {
    getCarUserInfor();
    super.initState();
    // fecthUser();
  }

  void getCarUserInfor() {
    CarInforofUserService.carUserInfor().then((value) => setState(() {}));
    Carplate = Session.carUserInfor.carPlate;
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    String currentTime = DateFormat('yyyy-MM-dd  kk:mm').format(now);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/bga.png'),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Image(image: AssetImage('images/iconsy.png')),
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
              height: 50,
              padding: EdgeInsets.only(right: 170, top: 20),
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
                onPressed: () {},
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
                label: Text('CHECK YOUR CAR'),
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
              code = Carplate.toString();

              var rng = Random();
              for (var i = 100000; i < 1000000; i++) {
                Codesecurity = rng.nextInt(1000000).toString();
                print(Codesecurity);
                break;
              }

              DateTime now = DateTime.now();
              String formattedDate =
                  DateFormat('yyyy-MM-dd – kk:mm').format(now);
            });
            showDialog(
                context: context,
                builder: (context) => Form(
                        child: Padding(
                      padding: const EdgeInsets.only(
                          left: 60, right: 60, top: 150, bottom: 200),
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
                                      data:
                                          'carplate: $Carplate \ntime: $currentTime \nHint code: $Codesecurity',
                                      width: 200,
                                      height: 200,
                                    ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  left: 60,
                                  right: 60,
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
                                    Text('$Carplate',
                                        style: TextStyle(
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
                              )
                            ],
                          )),
                    )));
          },
          child: const Icon(Icons.qr_code),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomNavigationBar(selectedCatIndex, context),
    );
  }
}
