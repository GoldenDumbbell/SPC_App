import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:webspc/DTO/section.dart';
import 'package:webspc/styles/button.dart';

import '../DTO/user.dart';

class UserInforScreen extends StatefulWidget {
  static const routeName = '/userScreen';
  final BuildContext? context;

  const UserInforScreen(this.context, {Key? key}) : super(key: key);

  @override
  UserInforPageState createState() => UserInforPageState();
}

class UserInforPageState extends State<UserInforScreen> {
  loginUser? Users;
  String? name;
  String? email;
  String? phone;
  String? identity;
  String? familyID;

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
    final responsecar = await get(
      Uri.parse('https://apiserverplan.azurewebsites.net/api/TbCars'),
    );
    if (response.statusCode == 200 || responsecar.statusCode == 200) {
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

          var itemscar = json.decode(responsecar.body);
          for (int u = 0; u < itemscar.length; u++) {
            if (familyID == itemscar[u]['familyId']) {
              CarName = itemscar[u]['carName'];
              Carplate = itemscar[u]['carPlate'];
              Carfont = itemscar[u]['carPaperFront'];
            }
          }
        });
      }
    }
  }

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
                      left: 150,
                      right: 15,
                      top: 10,
                    ),
                    height: size.height * 0.2 - 1,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'images/user.png',
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 630,
              width: 380,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1.0, color: Colors.black),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      Text(
                        'TRANSPORTATION INFORMATION',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 180,
                        width: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage("${Carfont}")),
                            border: Border.all(width: 1.0, color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      Text('$CarName',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      SizedBox(
                        height: 5,
                      ),
                      Text('$Carplate',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      Text(
                        '--------------------------------------------------------------------------------',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'USER INFORMATION',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      Container(
                        child: TextButton(
                          onPressed: () => {},
                          // padding: const EdgeInsets.all(0.0),
                          style: userstylebutton,
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      Icons.email_sharp,
                                      color: Colors.black,
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      "$email",
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.black),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: TextButton(
                          onPressed: () {},
                          // padding: const EdgeInsets.all(0.0),
                          style: userstylebutton,
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      Icons.phone_android,
                                      color: Colors.black,
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      "$phone",
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.black),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: TextButton(
                          onPressed: null,
                          // padding: const EdgeInsets.all(0.0),
                          style: userstylebutton,
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      Icons.account_box,
                                      color: Colors.black,
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      "$name",
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.black),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: TextButton(
                          onPressed: null,
                          // padding: const EdgeInsets.all(0.0),
                          style: userstylebutton,
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      Icons.perm_identity_sharp,
                                      color: Colors.black,
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      "$identity",
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.black),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
