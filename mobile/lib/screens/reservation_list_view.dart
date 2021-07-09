import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile/globals.dart' as globals;

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
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
          title: Text(globals.user!.username),
          centerTitle: true,
        ),
        body: DataTable(
          columns: [
            DataColumn(
              label: Icon(Icons.phone_android, color: Colors.green[500]),
            ),
            DataColumn(
              label: Icon(Icons.calendar_today, color: Colors.green[500]),
            ),
            DataColumn(
              label: Icon(Icons.person, color: Colors.green[500]),
            )
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('Galaxy S10')),
              DataCell(Text('2010-5-14 5:10')),
              DataCell(Text('James'))
            ]),
            DataRow(cells: [
              DataCell(Text('Galaxy S9')),
              DataCell(Text('2010-5-14 5:10')),
              DataCell(Text('Andrew'))
            ]),
            DataRow(cells: [
              DataCell(Text('iPhone 11')),
              DataCell(Text('2010-5-14 5:10')),
              DataCell(Text('George'))
            ]),
            DataRow(cells: [
              DataCell(Text('iPHone SE2')),
              DataCell(Text('2010-5-14 5:10')),
              DataCell(Text('Juan'))
            ]),
          ],
        ));
  }
}
