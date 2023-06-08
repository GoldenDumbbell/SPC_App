// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:webspc/Api_service/login_service.dart';
import 'package:webspc/DTO/cars.dart';
import 'package:webspc/DTO/section.dart';
import 'package:webspc/resource/Login&Register/login_page.dart';
import 'package:webspc/styles/button.dart';
import '../Api_service/car_detail_service.dart';
import '../Api_service/user_infor_service.dart';
import '../DTO/user.dart';
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

  String? userId;
  String? textFiledPhone;
  List<Car> listCar = [];
  List<Users> listUser = [];
  Users? userDetail;
  Car? carDetail;
  bool isLoading = true;

  @override
  void initState() {
    getListCar();
    getUserList();
    super.initState();
    // fecthUser();
  }

  void getUserList() {
    UserInforService.Userinfor().then((response) => setState(() {
          listUser = response;
          if (listUser.isNotEmpty) {
            userDetail = listUser.first;
          }
        }));
  }

  void getListCar() {
    CarDetailService.getListCar().then((response) => setState(() {
          listCar = response;
          if (listCar.isNotEmpty) {
            carDetail = listCar.first;
          }
        }));
  }

  Future updatePhoneNumber(String phoneNumber) {
    userId = Session.loggedInUser.userId;
    final body = jsonEncode(<String, String>{
      'userId': Session.loggedInUser.userId!,
      'phoneNumber': phoneNumber,
      'email': Session.loggedInUser.email!,
      'pass': Session.loggedInUser.pass!,
      'fullname': Session.loggedInUser.fullname!,
      'identitiCard': Session.loggedInUser.identitiCard!,
      'familyId': Session.loggedInUser.familyId!,
    });
    print(Session.loggedInUser.phoneNumber);
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
              height: size.height * 0.15,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: 150,
                      right: 15,
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
              height: 680,
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
                        height: 200,
                        width: 350,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            child: carDetail == null ||
                                    carDetail?.carPaperFront == null ||
                                    carDetail?.carId == ""
                                ? Image.asset(
                                    "images/carrr.png",
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    carDetail!.carPaperFront!,
                                    fit: BoxFit.cover,
                                  )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 60,
                        margin: const EdgeInsets.only(
                            left: 5, right: 5, bottom: 10),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listCar.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  carDetail = listCar[index];
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 60,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: listCar[index].carPaperFront == null ||
                                          listCar[index].carId == ""
                                      ? Image.asset(
                                          "images/carrr.png",
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          listCar[index].carPaperFront!,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Container(
                      //   height: 250,
                      //   padding: EdgeInsets.only(left: 10, right: 10),
                      //   child: ListView.separated(
                      //       scrollDirection: Axis.horizontal,
                      //       itemCount: listCar.length,
                      //       separatorBuilder: (context, index) => SizedBox(
                      //             width: 12,
                      //           ),
                      //       itemBuilder: (context, index) => Container(
                      //             width: 180,
                      //             height: 100,

                      //             // decoration: BoxDecoration(
                      //                 // image: DecorationImage(
                      //                 // //   image: NetworkImage(
                      //                 // //       listCar[index].carPaperFront!),
                      //                 // // ),
                      //                 // border: Border.all(
                      //                 //     width: 1.0, color: Colors.black),
                      //                 // borderRadius: BorderRadius.circular(10)),
                      //             child: Column(children: [
                      //               SizedBox(
                      //                 height: 190,
                      //               ),
                      //               Text(listCar[index].carName!,
                      //                   style: TextStyle(
                      //                       decoration: TextDecoration.none,
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       fontSize: 20)),
                      //               SizedBox(
                      //                 height: 4,
                      //               ),
                      //               Text(listCar[index].carPlate!,
                      //                   style: TextStyle(
                      //                       decoration: TextDecoration.none,
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       fontSize: 20)),
                      //             ]),
                      //           )),
                      // ),
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
                                      Session.loggedInUser.email!,
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
                                                      const EdgeInsets.all(8.0),
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
                                                        right: BorderSide.none,
                                                        bottom: BorderSide(
                                                            color: Colors.grey),
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
                                                          getUserList());
                                                }
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Save",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                  )),
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
                                    '${Session.loggedInUser.phoneNumber}',
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
                                      "${Session.loggedInUser.fullname}",
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
                                      "${Session.loggedInUser.identitiCard}",
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
