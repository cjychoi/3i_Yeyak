import 'package:flutter/material.dart';
import 'package:mobile/screens/login_view.dart';
import 'package:mobile/screens/home_view.dart';

void main() => runApp(LogIn());

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
