import 'package:flutter/material.dart';
import 'package:mobile/screens/login.dart';

void main() => runApp(LogIn());

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: LoginPage(),
    );
  }
}
