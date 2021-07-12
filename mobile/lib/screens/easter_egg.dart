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
          backgroundColor: Colors.black,
          leading: BackButton(
            //implement backbutton in
            color: Colors.white,
          ),
          title: Text("Credits"),
          centerTitle: true,
        ),
        body: new Container(
            color: const Color(0xFF212121),
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  child: Row(children: <Widget>[
                    Image.asset('images/group.jpeg', width: 350),
                  ]),
                ),
                Padding(padding: EdgeInsets.all(15)),
                Container(
                  child: Row(children: <Widget>[
                    Text("Andrew Choi ",
                        style: new TextStyle(color: Colors.white)),
                    Image.asset('images/Andrew.png', width: 200),
                  ]),
                ),
                Padding(padding: EdgeInsets.all(15)),
                Container(
                  child: Row(children: <Widget>[
                    Text(" George Go    ",
                        style: new TextStyle(color: Colors.white)),
                    Image.asset('images/George.jpeg', width: 200),
                  ]),
                ),
                Padding(padding: EdgeInsets.all(15)),
                Container(
                  child: Row(children: <Widget>[
                    Text(" Jinsang Oh   ",
                        style: new TextStyle(color: Colors.white)),
                    Image.asset('images/James.png', width: 200),
                    Container()
                  ]),
                ),
                Padding(padding: EdgeInsets.all(15)),
                Container(
                  child: Row(children: <Widget>[
                    Text("  Juan Kim      ",
                        style: new TextStyle(color: Colors.white)),
                    Image.asset('images/Juan.jpeg', width: 200),
                  ]),
                ),
              ],
            )));
  }
}
