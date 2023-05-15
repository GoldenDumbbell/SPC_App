import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'login_page.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/registerScreen';
  final BuildContext context;
  // ignore: use_key_in_widget_constructors
  const RegisterScreen(this.context);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterScreen> {
  final RoundedLoadingButtonController _btnRegister =
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
                height: 60,
              ),
              Image.asset('images/logo.png'),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Smart Packing System',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 560,
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
                      'Register',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
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
                      height: 20,
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
                      height: 20,
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
                      height: 20,
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
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 250,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          // suffixIcon: Icon(FontAwesomeIcons.eyeSlash,size: 17,),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.02,
                          right: MediaQuery.of(context).size.width * 0.02),
                      child: RoundedLoadingButton(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.055,
                        child: Text("SIGN UP",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )),
                        color: const Color.fromRGBO(20, 160, 240, 1.0),
                        controller: _btnRegister,
                        onPressed: _onRegisterPress,
                        borderRadius: MediaQuery.of(context).size.height * 0.04,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onRegisterPress() async {
    Timer(const Duration(seconds: 2), () {
      _btnRegister.success();
      Navigator.pushNamed(
        widget.context,
        LoginScreen.routeName,
      );
      _btnRegister.reset();
    });
  }
}
