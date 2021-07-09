import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart'; //hexcolor

class CreditPage extends StatefulWidget {
  @override
  _CreditPageState createState() => _CreditPageState();
}

class _CreditPageState extends State<CreditPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("0057FF"),
        leading: BackButton(
          //implement backbutton in
          color: Colors.white,
        ),
        title: Text("Credits"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Text("Andrew Choi"),
            Image.asset('images/capture.png', width: 200),
            Text("SWE Engineer intern \n"),
            Text("Swe")
          ]),
          Padding(padding: EdgeInsets.all(15)),
          Row(children: <Widget>[
            Text("George Go"),
            Image.asset('images/capture.png', width: 200),
            Container()
          ]),
          Row(children: <Widget>[
            Text("Juan Kim"),
            Image.asset('images/capture.png', width: 200),
            Container()
          ]),
          Row(children: <Widget>[
            Text("Jinsang Oh"),
            Image.asset('images/capture.png', width: 200),
            Container()
          ]),
        ],
      ),
    );
  }
}
