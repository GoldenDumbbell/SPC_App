import 'package:webspc/resource/account_page.dart';
import 'package:webspc/resource/home_page.dart';
import 'package:webspc/resource/login_page.dart';
import 'package:webspc/resource/undefined_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  final arg = settings.arguments;
  switch(settings.name){
    case "/":
      return MaterialPageRoute(builder: (context)=> LoginScreen(context));
    case "/loginScreen":
      return MaterialPageRoute(builder: (context) => LoginScreen(context));
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (context)=> HomeScreen(context));
      case AccountPage.routeName:
      return MaterialPageRoute(builder: (context)=> AccountPage(context));
     default:
      return MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name.toString()));
  }
}