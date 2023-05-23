import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class UserInforScreen extends StatefulWidget {
  static const routeName = '/userScreen';
  final BuildContext? context;

  const UserInforScreen(this.context, {Key? key}) : super(key: key);

  @override
  UserInforPageState createState() => UserInforPageState();
}

class UserInforPageState extends State<UserInforScreen> {
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
                            labelText: 'Email',
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
                            labelText: 'Full Name',
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
                            labelText: 'Phone Number',
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
                            labelText: 'Identity',
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