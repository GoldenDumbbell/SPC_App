import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:webspc/resource/account_page.dart';
import 'package:webspc/resource/navigationbar.dart';
import 'package:webspc/styles/button.dart';
import 'account_page.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';
  final BuildContext? context;

  const HomeScreen(this.context, {Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomeScreen> {
  int selectedIndex = 0;
  int selectedCatIndex = 0;
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var time = DateTime.now();
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
                        Text('Hi Phuong',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30)),
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
                              Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 7.0, color: Colors.blue),
                                    image: DecorationImage(
                                      image: AssetImage('images/qr.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
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
                                    Spacer(),
                                    Text('61A-1234.5',
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ],
                                ),
                              ),
                              // Text('61A 1234.5',
                              // style: TextStyle(
                              //             decoration: TextDecoration.none,
                              //             fontSize: 20,
                              //             fontWeight: FontWeight.bold,
                              //             color: Colors.black),
                              // ),
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
                                      "${time}",
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
