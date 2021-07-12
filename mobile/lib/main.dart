import 'package:flutter/material.dart';
import 'package:mobile/screens/easter_egg.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/screens/login_view.dart';
import 'package:mobile/screens/home_view.dart';
import 'package:mobile/screens/my_reservation_view.dart';
import 'package:mobile/screens/reservation_list_view.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '3i Yeyak',
        initialRoute: '/home', // '/login',
        theme: ThemeData(backgroundColor: Colors.white),
        routes: {
          '/login': (BuildContext context) => LoginPage(),
          '/home': (BuildContext context) => HomePage(),
          '/reservation': (BuildContext context) => ListPage(),
          '/myreservation': (BuildContext context) => MyPage(),
          '/credits': (BuildContext context) => CreditPage(),
        });
  }
}
