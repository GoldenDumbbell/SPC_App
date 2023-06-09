import 'package:flutter/material.dart';
import 'package:webspc/resource/Car_Register&%20Detail/car_detail_screen.dart';
import 'package:webspc/resource/topup_page.dart';
import 'package:webspc/resource/userinfor_page.dart';
import 'package:webspc/styles/button.dart';
import 'package:webspc/resource/Login&Register/login_page.dart';
import 'Car_Register& Detail/car_register_screen.dart';
import 'navigationbar.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  int selectedIndex = 1;
  int selectedCatIndex = 1;
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bga.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Container(
                    width: 70,
                    height: 70,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/user.png'),
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    height: 200,
                    width: 420,
                    decoration: BoxDecoration(
                        color: Colors.black,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserInforScreen()));
                  },
                  child: Text('Your Information'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: buttonPrimary,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CarDetailScreen()));
                  },
                  child: Text('Information Your Car'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: buttonPrimary,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CarRegisterScreen()));
                  },
                  child: Text('Register Your Car'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: buttonPrimary,
                  onPressed: () {
                    Navigator.pushNamed(context, TopupScreen.routeName);
                  },
                  child: Text('Top Up'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: buttonPrimary,
                  onPressed: () {},
                  child: Text('History'),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: ElevatedButton(
              //     style: buttonPrimary,
              //     onPressed: () {},
              //     child: Text('Setting'),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: buttonPrimary,
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Do you want to logout?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LoginScreen(context))),
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text('Logout'),
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
