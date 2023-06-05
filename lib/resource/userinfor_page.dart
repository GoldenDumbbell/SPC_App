import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:webspc/DTO/section.dart';

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
  List<User> users = [];
  List<sectionAccount> acc = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fecthUser();
  }

  @override
  String loggedInUser = '';

  Future fecthUser() async {
    final response = await get(
      Uri.parse('https://apiserverplan.azurewebsites.net/api/TbUsers'),
    );
    if (response.statusCode == 200) {
      setState(() {
        var items = json.decode(response.body);
        for (var list in items) {
          User user = User(
            userId: list['userId'],
            email: list['email'],
            phoneNumber: list['phoneNumber'],
            fullname: list['fullname'],
            pass: list['pass'],
            identitiCard: list['identitiCard'],
            // familyId: list['familyId']
          );
          users.add(user);
        }
        String checkemail = Checksection.getLoggedInUser();
        for (int i = 0; i < users.length; i++) {
          if (users[i].email == checkemail) {
            name = users[i].fullname.toString();
            email = users[i].email.toString();
            phone = users[i].phoneNumber.toString();
            identity = users[i].identitiCard.toString();
          }
        }
      });
    }
  }

  int selectedIndex = 0;
  int selectedCatIndex = 0;
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var time = DateTime.now();
    fecthUser();
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
                            color: Colors.red),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 180,
                        width: 200,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.black),
                            // image: DecorationImage(
                            //   image: AssetImage('images/toyota.png'),
                            //   fit: BoxFit.cover,
                            // ),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      Text('Toyota',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      //Spacer(),
                      Text('61A-1234.5',
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
                      Text(
                        'USER INFORMATION',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),

                      Container(
                        width: 250,
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: email, icon: Icon(Icons.email_sharp)
                              // suffixIcon: Icon(FontAwesomeIcons.envelope,size: 17,),
                              ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 250,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: name,
                            icon: Icon(Icons.account_box),
                            // suffixIcon: Icon(FontAwesomeIcons.envelope,size: 17,),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 250,
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: phone, icon: Icon(Icons.phone_android)
                              // suffixIcon: Icon(FontAwesomeIcons.envelope,size: 17,),
                              ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 250,
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: identity,
                              icon: Icon(Icons.perm_identity_sharp)
                              // suffixIcon: Icon(FontAwesomeIcons.envelope,size: 17,),
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
