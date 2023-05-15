
import 'package:webspc/resource/undefined_view.dart';
import 'package:flutter/material.dart';

import 'route_generator.dart' as router;
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}
Future initialization(BuildContext? context) async{
  await Future.delayed(const Duration(microseconds: 100));
}

class MainApp extends StatefulWidget {
const MainApp({Key? key}) : super(key: key);

// This widget is the root of your application.
@override
MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp>{
  Locale _locale = const Locale('en', 'US');
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Smart Packing System",
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.white),
      ),
      locale: _locale,
      initialRoute: "/",
      onGenerateRoute: router.generateRoute,
      onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => UndefinedView(
            name: settings.name,
          )
      ),
    );
  }
}

