import 'package:mobile/screens/login_view.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path/path.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

// Future<Database> createDatabase(){
//   return getDatabasesPath().then((dbPath) {
//     final String path = join(dbPath, 'bytebank.db');
//     return openDatabase(path, onCreate: (db, version){
//       db.execute('CREATE TABLE reserves('
//           'id INTEGER PRIMARY KEY, '
//           'name TEXT, '
//           'account_number INTEGER)');
//     }, version: 1);
//   });
// }

// Future<int> save(Reserve reserve) {
//   return createDatabase().then((db) {
//     final Map<String, dynamic> reserveMap = Map();
//     reserveMap['id'] = reserve.id;
//     reserveMap['device_name'] = reserve.device_name;
//     reserveMap['date_time'] = reserve.date_time;
//     return db.insert('reserves', reserveMap);
//   });
// }

// Future<List<Reserve>> findAll() {
//   return createDatabase().then((db) {
//     return db.query('reserves').then((maps) {
//       final List<Reserve> reserves = [];
//       for (Map<String, dynamic> map in maps) {
//         final Reserve reserves = Reserve(
//           map['id'],
//           map['device_name'],
//           map['date_time'],
//         );
//         reserves.add(reserves);
//       }
//       return reserves;
//     });
//   });
// }

class _MyPageState extends State<MyPage> {
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
        title: Text(LoginPage.uName),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}

// body: DefaultTextStyle.merge(
//     child: showList(),
//Device and Date contatiner
// style: descTextStyle,
// child: Container(
//   padding: EdgeInsets.all(50),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//       Column(
//         children: [
//           Icon(Icons.phone_android, color: Colors.green[500]),
//           Text('Device:'),
//           Text(deviceName), //add device name
//         ],
//       ),
//       Column(
//         children: [
//           Icon(Icons.calendar_today, color: Colors.green[500]),
//           Text('Date:'),
//           Text(dateTimeForm), //add date time form
//           IconButton(
//             icon: Icon(Icons.delete,
//                 color: Colors.black), //Set edit button to black
//             onPressed: () {
//               //delete Dateform
//             },
//           ),
//         ],
//       ),
//     ],
//   ),
// )));
//   }
// }
