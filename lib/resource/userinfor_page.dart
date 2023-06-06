// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:webspc/DTO/cars.dart';
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
  final RoundedLoadingButtonController _btnSave =
      RoundedLoadingButtonController();
  int selectedIndex = 0;
  int selectedCatIndex = 0;

  loginUser? Users;
  String? userId;
  String? name;
  String? email;
  String? pass;
  String? phone;
  String? identity;
  String? familyID;

  String? familyIDcar;
  String? CarName;
  String? Carplate;
  String? Carfont;
  List<User> users = [];
  List<car> carlist = [];
  List<cars> carlist1 = [];
  bool isLoading = true;
  String? textFiledPhone;

  @override
  void initState() {
    super.initState();
    fecthUser();
  }

  @override
  String loggedInUser = '';

  Future fecthUser() async {
    setState(() {
      isLoading = true;
    });
    final response = await get(
      Uri.parse('https://apiserverplan.azurewebsites.net/api/TbUsers'),
    );
    final responsecar = await get(
      Uri.parse('https://apiserverplan.azurewebsites.net/api/TbCars'),
    );
    if (response.statusCode == 200 || responsecar.statusCode == 200) {
      if (mounted) {
        setState(() {
          isLoading = false;
          var items = json.decode(response.body);
          String checkemail = Checksection.getLoggedInUser();
          for (int i = 0; i < items.length; i++) {
            if (items[i]['email'] == checkemail) {
              userId = items[i]['userId'].toString();
              name = items[i]['fullname'].toString();
              email = items[i]['email'].toString();
              pass = items[i]['pass'].toString();
              phone = items[i]['phoneNumber'].toString();
              identity = items[i]['identitiCard'].toString();
              familyID = items[i]['familyId'].toString();
            }
          }

          var itemscar = json.decode(responsecar.body);
          // for (int u = 0; u < itemscar.length; u++) {
          // if (familyID == itemscar[u]['familyId']) {
          // CarName = itemscar[u]['carName'];
          // Carplate = itemscar[u]['carPlate'];
          // Carfont = itemscar[u]['carPaperFront'];
          for (var i in itemscar) {
            car Cars = car(
                namecar: i['carName'],
                carplate: i['carPlate'],
                carfont: i['carPaperFront'],
                familyId: i['familyId']);
            carlist.add(Cars);
          }
          for (int u = 0; u < carlist.length; u++) {
            if (familyID == carlist[u].familyId) {
              cars Car1 = cars(
                  namecar: carlist[u].namecar,
                  carplate: carlist[u].carplate,
                  carfont: carlist[u].carfont);
              carlist1.add(Car1);
            }
          }
          // }
          // }
        });
      }
    }
  }

  Future updatePhoneNumber(String phoneNumber) {
    final body = jsonEncode(<String, String>{
      'userId': userId!,
      'phoneNumber': phoneNumber,
      'email': email!,
      'pass': pass!,
      'fullname': name!,
      'identitiCard': identity!,
      'familyId': familyID!,
    });
    return put(
      Uri.parse('https://apiserverplan.azurewebsites.net/api/TbUsers/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
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
                        // Container(
                        //   height: 180,
                        //   width: 200,
                        //   decoration: BoxDecoration(
                        //       image: DecorationImage(
                        //           image: NetworkImage("${Carfont}")),
                        //       border: Border.all(width: 1.0, color: Colors.black),
                        //       borderRadius: BorderRadius.circular(10)),
                        // ),
                        Container(
                          height: 250,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: carlist1.length,
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 12,
                                  ),
                              itemBuilder: (context, index) => Container(
                                    width: 180,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              carlist1[index].carfont),
                                        ),
                                        border: Border.all(
                                            width: 1.0, color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(children: [
                                      SizedBox(
                                        height: 190,
                                      ),
                                      Text(carlist1[index].namecar,
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(carlist1[index].carplate,
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                    ]),
                                  )),
                        ),

                        // Text('$CarName',
                        //     style: TextStyle(
                        //         decoration: TextDecoration.none,
                        //         color: Colors.black,
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 20)),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Text('$Carplate',
                        //     style: TextStyle(
                        //         decoration: TextDecoration.none,
                        //         color: Colors.black,
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 20)),
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
                                            fontSize: 20.0,
                                            color: Colors.black),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextButton(
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: SizedBox(
                                    height: 300,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const Text(
                                              'Please enter your phone number',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Image.asset(
                                                      'images/vietnam.png',
                                                      width: 24,
                                                      height: 24,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        border: Border(
                                                          left: BorderSide.none,
                                                          top: BorderSide.none,
                                                          right:
                                                              BorderSide.none,
                                                          bottom: BorderSide(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      child: TextField(
                                                        onChanged: (value) {
                                                          setState(() {
                                                            textFiledPhone =
                                                                value;
                                                          });
                                                        },
                                                        decoration:
                                                            const InputDecoration(
                                                          hintText:
                                                              'Phone number',
                                                          border:
                                                              InputBorder.none,
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 16,
                                                            vertical: 14,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 60, right: 60),
                                              child: RoundedLoadingButton(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.055,
                                                color: const Color.fromRGBO(
                                                    20, 160, 240, 1.0),
                                                controller: _btnSave,
                                                // onPressed: _onLoginPress,
                                                onPressed: () {
                                                  if (textFiledPhone != null) {
                                                    updatePhoneNumber(
                                                            textFiledPhone!)
                                                        .then((value) =>
                                                            fecthUser());
                                                  }
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Save",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    )),
                                                // borderRadius: MediaQuery.of(context).size.height * 0.04,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          // padding: const EdgeInsets.all(0.0),
                          style: userstylebutton,
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      Icons.phone_android,
                                      color: Colors.black,
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      "$phone",
                                      style: const TextStyle(
                                          fontSize: 20.0, color: Colors.black),
                                    ))
                              ],
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
                                            fontSize: 20.0,
                                            color: Colors.black),
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
                                            fontSize: 20.0,
                                            color: Colors.black),
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
}
