import 'package:mobile/screens/login_view.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    super.initState();
  }

  final format = DateFormat("yyyy-MM-dd HH:mm");
  DateTime? value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: HexColor("0057FF"),
        ),
        title: Text(LoginPage.uName),
        centerTitle: true,
      ),
      body: new Container(
          child: ListView(children: <Widget>[
        Container(
          child: Column(
              //Text(format.toString()),
              ),
        )
      ])),
    );
  }
}
