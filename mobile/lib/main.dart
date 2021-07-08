import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/screens/login_view.dart';
import 'package:mobile/screens/home_view.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(LogIn());
}

class LogIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: '3i Yeyak', initialRoute: '/login', routes: {
      '/login': (BuildContext context) => LoginPage(),
      '/home': (BuildContext context) => HomePage(),
    });
  }
}
