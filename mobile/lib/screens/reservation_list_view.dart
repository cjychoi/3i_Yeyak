import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile/globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
//import 'package:mobile/models/Reservation.dart';
import 'package:mobile/models/User.dart';
import 'package:mobile/viewModel/MyReservationViewModel.dart';

void main() => runApp(ListPage());

class ListPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DataTableDemo();
  }
}

class reservation {
  String returnDate;
  String date;
  String userName;
  String deviceName;
  reservation(
      {required this.returnDate,
      required this.date,
      required this.deviceName,
      required this.userName});
  static List<reservation> getUsers() {
    return <reservation>[
      reservation(
          date: "2021-07-21 06:30",
          userName: "James",
          returnDate: "2021-07-21 08:30",
          deviceName: "Note 20"),
      reservation(
          date: "2021-07-21 06:30",
          userName: "Andrew",
          returnDate: "2021-07-21 08:30",
          deviceName: "Note 20"),
      reservation(
          date: "2021-07-20 04:30",
          userName: "Juan84",
          returnDate: "2021-07-21 09:30",
          deviceName: "iPhone 8"),
      reservation(
          date: "2021-07-26 07:30",
          userName: "George",
          returnDate: "2021-07-21 10:30",
          deviceName: "iPhone 11 Pro"),
      reservation(
          date: "2021-07-23 04:30",
          userName: "James2",
          returnDate: "2021-07-21 11:30",
          deviceName: "Juan 84"),
    ];
  }
}

class DataTableDemo extends StatefulWidget {
  DataTableDemo() : super();

  final String title = "Reservation List";

  @override
  DataTableDemoState createState() => DataTableDemoState();
}

class DataTableDemoState extends State<DataTableDemo> {
  late List<reservation> users;
  //List<Reservation>? reservations;
  late bool sort;
  bool isLoading = true;

  final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  final viewModel = MyReservationViewModel();

  @override
  void initState() {
    sort = false;
    isLoading = true;
    users = reservation.getUsers();
    viewModel
        .loadThisList()
        .then((value) {
          // print(value);
          print("type is ${value.runtimeType.toString()}");
          setState(() {
            // users= value;
          });
        })
        .catchError((err) => {
              Fluttertoast.showToast(
                msg: err.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              )
            })
        .whenComplete(() => setState(() {
              isLoading = false;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
          ),
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: isLoading || users == null
            ? Text("Loading...")
            : Container(
                child: users != null
                    ? ListView.builder(
                        itemCount: users!.length,
                        itemBuilder: (BuildContext context, int index) {
                          var reservation = users![index];
                          if (index == 0) {
                            return new Row(children: [
                              Icon(Icons.smartphone, color: Colors.green[500]),
                              Icon(Icons.person, color: Colors.green[500]),
                              Icon(Icons.calendar_today,
                                  color: Colors.green[500]),
                              Icon(Icons.calendar_today,
                                  color: Colors.green[500]),
                            ]);
                          }
                          return Row(
                            children: [
                              Text(reservation.deviceName),
                              Text(reservation.userName),
                              Text(reservation.date),
                              Text(reservation
                                  .returnDate) //Text(dateFormat.format(reservation.startedAt)),
                              //Text(dateFormat.format(reservation.endedAt))
                            ],
                          );
                        })
                    : null));
  }
}
// class User {
//   String devices;
//   String date;
//   //String returnDate;
//   String userName;

//   User({required this.devices, required this.date, required this.userName});

//   static List<User> getUsers() {
//     return <User>[
//       User(date: "2021-07-21 05:30", devices: "S 10", userName: "Juan"),
//       User(date: "2021-07-21 06:30", devices: "Note 20", userName: "James"),
//       User(date: "2021-07-20 04:30", devices: "iPhone 11", userName: "George"),
//       User(date: "2021-07-26 07:30", devices: "Juan 12", userName: "Andrew"),
//       User(date: "2021-07-23 04:30", devices: "Juan 84", userName: "Jedi"),
//     ];
//   }
// }

// class DataTableDemo extends StatefulWidget {
//   DataTableDemo() : super();

//   final String title = "Reservation Status";

//   @override
//   DataTableDemoState createState() => DataTableDemoState();
// }

// class DataTableDemoState extends State<DataTableDemo> {
//   late List<User> users;
//   late List<User> selectedUsers;
//   late bool sort;

//   @override
//   void initState() {
//     sort = false;
//     selectedUsers = [];
//     users = User.getUsers();
//     super.initState();
//   }

//   onSortColum(int columnIndex, bool ascending) {
//     if (columnIndex == 0) {
//       if (ascending) {
//         users.sort((a, b) => a.date.compareTo(b.date));
//       } else {
//         users.sort((a, b) => b.date.compareTo(a.date));
//       }
//     }
//   }

//   onSelectedRow(bool selected, User user) async {
//     setState(() {
//       if (selected) {
//         selectedUsers.add(user);
//       } else {
//         selectedUsers.remove(user);
//       }
//     });
//   }

//   SingleChildScrollView dataBody() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: DataTable(
//         sortAscending: sort,
//         sortColumnIndex: 0,
//         columns: [
//           DataColumn(
//               label: Icon(Icons.calendar_today, color: Colors.green[500]),
//               numeric: false,
//               tooltip: "This is Date",
//               onSort: (columnIndex, ascending) {
//                 setState(() {
//                   sort = !sort;
//                 });
//                 onSortColum(columnIndex, ascending);
//               }),
//           DataColumn(
//             label: Icon(Icons.smartphone, color: Colors.green[500]),
//             numeric: false,
//             tooltip: "This is Device Name",
//           ),
//           DataColumn(
//             label: Icon(Icons.person, color: Colors.green[500]),
//             numeric: false,
//             tooltip: "This is the name of the user",
//           )
//         ],
//         rows: users
//             .map(
//               (user) => DataRow(selected: selectedUsers.contains(user), cells: [
//                 DataCell(
//                   Text(user.date),
//                   onTap: () {
//                     print('Selected ${user.date}');
//                   },
//                 ),
//                 DataCell(
//                   Text(user.devices),
//                 ),
//                 DataCell(
//                   Text(user.userName),
//                 ),
//               ]),
//             )
//             .toList(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: BackButton(
//           //onPressed: () {
//           //   Navigator.of(context).popAndPushNamed('/home');
//           // },
//           //implement backbutton in
//           color: Colors.white,
//         ),
//         title: Text(widget.title),
//         centerTitle: true,
//       ),
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         verticalDirection: VerticalDirection.down,
//         children: <Widget>[
//           Expanded(
//             child: dataBody(),
//           ),
//         ],
//       ),
//     );
//   }
// }
