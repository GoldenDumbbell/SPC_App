///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';
import 'package:webspc/resource/navigationbar.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:webspc/main.dart';
import 'package:http/http.dart';
import 'package:webspc/styles/button.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:webspc/DTO/user.dart';
import 'package:webspc/DTO/section.dart';
import 'package:intl/intl.dart';

import '../../DTO/spot.dart';

class Booking1Screen extends StatefulWidget {
  static const routerName = 'booking1Screen';
  final BuildContext? context;
  const Booking1Screen(this.context, {Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _BookingPage1State createState() => _BookingPage1State();
}

//const List<String> listSpot = ["one", "two", "three"];
//List listspot1 = [];
List<spot> listspot1 = [];
List<String> listspot = [];

class _BookingPage1State extends State<Booking1Screen> {
  DateTime date = DateTime(2023, 6, 7);
  TimeOfDay time = TimeOfDay(hour: 10, minute: 30);
  String? dropdownValue;

  loginUser? Users;
  String? name;
  String? email;
  String? phone;
  String? identity;
  String? familyID;

  String? sensorId;
  String? available;

  String? familyIDcar;
  String? CarName;
  String? Carplate;
  String? Carfont;
  List<User> users = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fecthUser();
  }

  @override
  String loggedInUser = '';

  Future fecthUser() async {
    final response = await get(
      Uri.parse('https://apiserverplan.azurewebsites.net/api/TbUsers'),
    );
    final responspot = await get(
      Uri.parse('https://apiserverplan.azurewebsites.net/api/TbSpots'),
    );

    final responsecar = await get(
      Uri.parse('https://apiserverplan.azurewebsites.net/api/TbCars'),
    );
    if (response.statusCode == 200 ||
        responspot.statusCode == 200 ||
        responsecar.statusCode == 200) {
      if (this.mounted) {
        setState(() {
          var items = json.decode(response.body);
          String checkemail = Checksection.getLoggedInUser();
          for (int i = 0; i < items.length; i++) {
            if (items[i]['email'] == checkemail) {
              name = items[i]['fullname'].toString();
              email = items[i]['email'].toString();
              phone = items[i]['phoneNumber'].toString();
              identity = items[i]['identitiCard'].toString();
              familyID = items[i]['familyId'].toString();
            }
          }
          var itemspot = json.decode(responspot.body);
          //String check = checkAvailable.getloggedInSpot();
          for (var u in itemspot) {
            spot Spot = spot(
                spotId: u['sensorId'],
                available: u['available'],
                blockId: u['ablockId']);
            listspot1.add(Spot);
          }

          listspot = listspot1.map((c) => c.spotId).toList();
          dropdownValue = listspot.first;
          /*var itemspot = json.decode(responspot.body);
          //String check = checkAvailable.getloggedInSpot();
          /*for (var u in itemspot)*/
          
          for (int u = 0; u < listspot1.length; u++) {
            sensorId = itemspot[u]['sensorId'];
            listspot1 = ['$sensorId'];
            for(bool u in listspot1){   
              if (u["available"] as bool){
                print(u);}
            //spot Spot = spot(
            //spotId: u['sensorId'],
            //available: u['available'],
            //blockId: u['ablockId']//);
            //listspot1.add(Spot);
            //if (itemspot[u]['available'] == check) {
            // sensorId = itemspot[u]['sensorId'];
            //available = itemspot[u]['available'];
            //}
          }*/
          print(listspot1[0].spotId);
          print(listspot1[0].available);
          var itemscar = json.decode(responsecar.body);
          for (int n = 0; n < itemscar.length; n++) {
            if (familyID == itemscar[n]['familyId']) {
              CarName = itemscar[n]['carName'];
              Carplate = itemscar[n]['carPlate'];
              Carfont = itemscar[n]['carPaperFront'];
            }
          }
        });
      }
    }
  }

  List categoryItemlist = [];

  int selectedIndex = 0;
  int selectedCatIndex = 0;
  @override
  Widget build(BuildContext context) {
    spacing:
    20;
    int selectedIndex = 0;
    int selectedCatIndex = 0;
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.all(0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color(0x1f000000),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.zero,
            border: Border.all(color: Color(0xfff7f2f2), width: 0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child:

                    ///***If you have exported images you must have to copy those images in assets/images directory.

                    Image(
                  // ignore: prefer_const_constructors
                  image: AssetImage("images/spot.png"),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.all(0),
                padding: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  color: Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Spot:",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        fontSize: 24,
                        color: Color(0xff000000),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.62,
                              height: MediaQuery.of(context).size.height * 0.07,
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                border: Border.all(
                                    color: Color(0xfff2ebeb), width: 1),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      dropdownValue = value!;
                                    });
                                  },
                                  value: dropdownValue,
                                  items: listspot.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  style: TextStyle(
                                    color: Color(0xff000000),
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
              Container(
                padding: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment(-0.9, 0.0),
                      child: Text(
                        "Date:",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          fontSize: 24,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            '${date.day}/${date.month}/${date.year}',
                            style: TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            child: Text('Select Date'),
                            onPressed: () async {
                              DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: date,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2024));
                              if (newDate == null) return;
                              setState(() => date = newDate);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment(-0.9, 0.0),
                      child: Text(
                        "Time:",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          fontSize: 24,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            '${time.hour}:${time.minute}',
                            style: TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            child: Text('Select Time'),
                            onPressed: () async {
                              TimeOfDay? newTime = await showTimePicker(
                                  context: context, initialTime: time);
                              if (newTime == null) return;
                              setState(() => time = newTime);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(0),
                padding: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Name:",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        fontSize: 24,
                        color: Color(0xff000000),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "$name",
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 24,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(0),
                padding: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "License Plate:",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        fontSize: 24,
                        color: Color(0xff000000),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '$Carplate',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 24,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(0),
                padding: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Phone:",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        fontSize: 24,
                        color: Color(0xff000000),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "$phone",
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 24,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(0),
                padding: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.19,
                decoration: BoxDecoration(
                  color: Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment(0.0, -1.0),
                      child: Text(
                        "Parking Rate:",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          fontSize: 28,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "30 min : 10.000 VNĐ",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "1 hourse: 15.000 VNĐ",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "2 hours: 25.000 VNĐ",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Over 4 hours: 50.000 VNĐ",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(0),
                padding: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.196,
                decoration: BoxDecoration(
                  color: Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    onPressed: () {},
                    color: Color(0xffee8b60),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Color(0xff808080), width: 1),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Book Now",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    textColor: Color(0xfffcf4f4),
                    height: MediaQuery.of(context).size.height * 0.1,
                    minWidth: MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(selectedCatIndex, context),
    );
  }
}
