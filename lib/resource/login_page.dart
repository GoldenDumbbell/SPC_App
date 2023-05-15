import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'register_page.dart';
import 'home_page.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';
  final BuildContext context;

  // ignore: use_key_in_widget_constructors
  const LoginScreen(this.context);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginScreen> {
  final RoundedLoadingButtonController _btnLogin =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/bga.png'),
            fit: BoxFit.cover,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
              ),
              Image.asset('images/logo.png'),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Smart Packing System',
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 480,
                width: 325,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Log In',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
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
                      height: 10,
                    ),
                    Container(
                      width: 250,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          // suffixIcon: Icon(FontAwesomeIcons.eyeSlash,size: 17,),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forget Password',
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 60,
                          right: 60),
                      child: RoundedLoadingButton(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.055,
                        child: Text("SIGN IN",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )),
                        color: const Color.fromRGBO(20, 160, 240, 1.0),
                        controller: _btnLogin,
                        onPressed: _onLoginPress,
                        borderRadius: MediaQuery.of(context).size.height * 0.04,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        child: RichText(
                      text: TextSpan(
                        text: "Do you have account ?",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        children: <TextSpan>[
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen(context)));
                                },
                              text: " Register",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 15)),
                        ],
                      ),
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onLoginPress() async {
    Timer(const Duration(seconds: 2), () {
      _btnLogin.success();
      Navigator.pushNamed(
        widget.context,
        HomeScreen.routeName,
      );
      _btnLogin.reset();
    });
  }
}
