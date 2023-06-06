import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webspc/DTO/section.dart';
import 'package:webspc/DTO/user.dart';
import 'package:webspc/resource/forgot_password.dart';
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
  late String name;
  final RoundedLoadingButtonController _btnLogin =
      RoundedLoadingButtonController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  String loggedInUser = '';

  Future<List<loginUser>> login(String inputemail, inputpassword) async {
    bool check = false;
    final response = await get(
      Uri.parse('https://apiserverplan.azurewebsites.net/api/TbUsers'),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<loginUser> listAccount = [];
      for (int i = 0; i < data.length; i++) {
        if (inputemail == data[i]['email'] &&
            inputpassword == data[i]['pass']) {
          name = data[i]['fullname'];
          check = true;
          break;
        } else {
          check = false;
        }
      }
      if (check == true) {
        Checksection.setLoggecInUser(inputemail);
        username.setLoggecInUsername(name);
        _onLoginPress();
      } else {
        _btnLogin.reset();
        emailController.clear();
        passwordController.clear();
      }
      return listAccount;
    } else {
      throw Exception('fail');
    }
  }

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
                      child: TextFormField(
                        controller: emailController,
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
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          // suffixIcon: Icon(FontAwesomeIcons.eyeSlash,size: 17,),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 130),
                        child: RichText(
                          text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPasswordScreen(context)));
                                },
                              text: " Forget Password",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 15)),
                        )),
                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 60, right: 60),
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
                        // onPressed: _onLoginPress,
                        onPressed: () {
                          login(emailController.text, passwordController.text);
                        },
                        // borderRadius: MediaQuery.of(context).size.height * 0.04,
                      ),
                    ),
                    // ),
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

  //  void login() async {
  //   try{
  //   Response response = await get(
  //     Uri.parse('https://spsapiservice.azurewebsites.net/api/TbUsers'),
  //   );

  //   var data = jsonDecode(response.body);

  // User user = User(email: data['email'], pass: data['pass']);

  // for(int i=0; i< data.size(); i++){
  //   User user = data.get(i);
  //   print(user);
  // }

  // String email = emailController.toString();
  // String password = passwordController.toString();
  //   if( email == user.Getemail&& password == user.Getpassword){
  //     print('ok');
  //   }else{
  //     print('fail');
  //   }
  // print(data);

  //   }catch(e){
  //     print(e);
  //   }
  //  }
  // if (email == email1 && password == password1){
  //   print('Login successfully');
  // Navigator.pushNamed(
  //   widget.context,
  //   HomeScreen.routeName,
  // );
  // }else{
  //   print('fail');
  // }

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
