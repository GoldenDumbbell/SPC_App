import 'package:webspc/resource/account_page.dart';
import 'package:webspc/resource/forgot_password.dart';
import 'package:webspc/resource/home_page.dart';
import 'package:webspc/resource/login_page.dart';
import 'package:webspc/resource/topup_page.dart';
import 'package:webspc/resource/undefined_view.dart';
import 'package:flutter/material.dart';
import 'package:webspc/resource/userinfor_page.dart';
import 'package:webspc/styles/plash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final arg = settings.arguments;
  switch (settings.name) {
    // case "/":
    //   return MaterialPageRoute(builder: (context)=> const SplashScreen());
    case "/":
      return MaterialPageRoute(builder: (context) => LoginScreen(context));
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (context) => HomeScreen(context));
    case AccountPage.routeName:
      return MaterialPageRoute(builder: (context) => AccountPage(context));
    case UserInforScreen.routeName:
      return MaterialPageRoute(builder: (context) => UserInforScreen(context));
    case TopupScreen.routeName:
      return MaterialPageRoute(builder: (context) => TopupScreen(context));
      // case ForgotPasswordScreen.routeName:
      // return MaterialPageRoute(builder: (context) => ForgotPasswordScreen(context));
    default:
      return MaterialPageRoute(
          builder: (context) => UndefinedView(name: settings.name.toString()));
  }
}
