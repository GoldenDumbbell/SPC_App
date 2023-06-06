import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:webspc/resource/navigationbar.dart';
import 'package:webspc/styles/button.dart';
import '../DTO/section.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';
  final BuildContext? context;

  const HomeScreen(this.context, {Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomeScreen> {
  // var time = DateTime.now();
  var code = '';
  String? name;
  String? familyID;

  String? Carplate;
  int selectedIndex = 0;
  int selectedCatIndex = 0;
  String namehome = username.getLoggedInUsername();
  TextEditingController title = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
    this.fecthUser();
  }

  Future fecthUser() async {
    final response = await get(
      Uri.parse('https://apiserverplan.azurewebsites.net/api/TbUsers'),
    );
    final responsecar = await get(
      Uri.parse('https://apiserverplan.azurewebsites.net/api/TbCars'),
    );
    if (response.statusCode == 200) {
      if (this.mounted) {
        setState(() {
          var items = json.decode(response.body);
          String checkemail = Checksection.getLoggedInUser();
          for (int i = 0; i < items.length; i++) {
            if (items[i]['email'] == checkemail) {
              name = items[i]['fullname'].toString();
              // email = items[i]['email'].toString();
              // phone = items[i]['phoneNumber'].toString();
              // identity = items[i]['identitiCard'].toString();
              familyID = items[i]['familyId'].toString();
            }
          }

          var itemscar = json.decode(responsecar.body);
          for (int u = 0; u < itemscar.length; u++) {
            if (familyID == itemscar[u]['familyId']) {
              //   CarName = itemscar[u]['carName'];
              Carplate = itemscar[u]['carPlate'];
              //   Carfont = itemscar[u]['carPaperFront'];
            }
          }
        });
      }
    }
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
              height: size.height * 0.2,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 5,
                    ),
                    height: size.height * 0.2 - 27,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(100, 161, 125, 17),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text('Hello ' + namehome,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'images/user.png',
                            fit: BoxFit.cover,
                            width: 70,
                            height: 70,
                          ),
                        )
                      ],
                    ),
                  ),
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
                                      data: '$Carplate  $currentTime',
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
