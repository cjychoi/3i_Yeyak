import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mobile/models/Reservation.dart';
import 'package:mobile/models/User.dart';
import 'package:mobile/viewModel/MyReservationViewModel.dart';

//import 'package:mobile/screens/login_view.dart';
void main() => runApp(MyPage());

class MyPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DataTableDemo();
  }
}

// class User {
//   String returnDate;
//   String date;
//   //String returnDate;
//   String deviceName;

// class Reservation {
//   String returnDate;
//   String date;
//   //String returnDate;
//   String deviceName;

// User(
//     {required this.returnDate, required this.date, required this.deviceName});
//   Reservation(
//       {required this.returnDate, required this.date, required this.deviceName});

//   static List<User> getUsers() {
//     return <User>[
//       User(
//           date: "2021-07-21 06:30",
//           returnDate: "2021-07-21 08:30",
//           deviceName: "Note 20"),
//       User(
//           date: "2021-07-21 06:30",
//           returnDate: "2021-07-21 08:30",
//           deviceName: "Note 20"),
//       User(
//           date: "2021-07-20 04:30",
//           returnDate: "2021-07-21 09:30",
//           deviceName: "iPhone 8"),
//       User(
//           date: "2021-07-26 07:30",
//           returnDate: "2021-07-21 10:30",
//           deviceName: "iPhone 11 Pro"),
//       User(
//           date: "2021-07-23 04:30",
//           returnDate: "2021-07-21 11:30",
//           deviceName: "Juan 84"),
//     ];
//   }
// }

class DataTableDemo extends StatefulWidget {
  DataTableDemo() : super();

  final String title = "My Reservation";

  @override
  DataTableDemoState createState() => DataTableDemoState();
}

class DataTableDemoState extends State<DataTableDemo> {
  // late List<User> users;
  // late List<User> selectedUsers;
  static late List<Reservation> reservations;
  late bool sort;
  bool isLoading = true;

  final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  final viewModel = MyReservationViewModel();

  @override
  void initState() {
    sort = false;
    // selectedUsers = [];
    isLoading = true;
    // users = User.getUsers();
    viewModel
        .loadThisList()
        .then((value) {
          // print(value);
          print("type is ${value.runtimeType.toString()}");
          setState(() {
            reservations = value;
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

  // onSortColumn(int columnIndex, bool ascending) {
  //   if (columnIndex == 0) {
  //     if (ascending) {
  //       users.sort((a, b) => a.date.compareTo(b.date));
  //     } else {
  //       users.sort((a, b) => b.date.compareTo(a.date));
  //     }
  //   }
  // }

  // onSelectedRow(bool selected, User user) async {
  //   setState(() {
  //     if (selected) {
  //       selectedUsers.add(user);
  //     } else {
  //       selectedUsers.remove(user);
  //     }
  //   });
  // }

  // deleteSelected() async {
  //   setState(() {
  //     if (selectedUsers.isNotEmpty) {
  //       List<User> temp = [];
  //       temp.addAll(selectedUsers);
  //       for (User user in temp) {
  //         users.remove(user);
  //         selectedUsers.remove(user);
  //       }
  //     }
  //   });
  // }

  // SingleChildScrollView dataBody() {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.vertical,
  //     child: DataTable(

  //       sortAscending: sort,
  //       sortColumnIndex: 0,
  //       columns: [
  //         DataColumn(
  //             label: Icon(Icons.calendar_today, color: Colors.green[500]),
  //             numeric: false,
  //             tooltip: "This is rent date",
  //             onSort: (columnIndex, ascending) {
  //               setState(() {
  //                 sort = !sort;
  //               });
  //               onSortColumn(columnIndex, ascending);
  //             }),
  //         DataColumn(
  //           label: Icon(Icons.calendar_today, color: Colors.green[500]),
  //           numeric: false,
  //           tooltip: "This is return date",
  //         ),
  //         DataColumn(
  //           label: Icon(Icons.smartphone, color: Colors.green[500]),
  //           numeric: false,
  //           tooltip: "This is the device name",
  //         )
  //       ],
  //       rows: reservations!
  //           .map(
  //             (reservation) => DataRow(
  //                 selected: selectedUsers.contains(reservation),
  //                 onSelectChanged: (b) {
  //                   print("Onselect");
  //                   onSelectedRow(b!, reservation.user.username);
  //                 },
  //                 cells: [
  //                   DataCell(
  //                     Text(user.date),
  //                     onTap: () {
  //                       print('Selected ${user.date}');
  //                     },
  //                   ),
  //                   DataCell(
  //                     Text(user.returnDate),
  //                   ),
  //                   DataCell(
  //                           Text(reservation.device.model),
  //                   ),
  //                 ]),
  //           )
  //           .toList(),
  //     ),
  //   );
  // }

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
        body: isLoading || reservations == null
            ? Text("Loading...")
            :
            // body: Column(
            //   mainAxisSize: MainAxisSize.min,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   verticalDirection: VerticalDirection.down,
            //   children: [
            Container(
                child: reservations != null
                    ? ListView.builder(
                        itemCount: reservations!.length,
                        itemBuilder: (BuildContext context, int index) {
                          var reservation = reservations![index];
                          return Row(
                            children: [
                              Text(reservation.device.model),
                              Text(reservation.user.username),
                              Text(dateFormat.format(reservation.startedAt)),
                              Text(dateFormat.format(reservation.endedAt))
                            ],
                          );
                        })
                    : null)
        // Expanded(
        //   child: dataBody(),
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   mainAxisSize: MainAxisSize.min,
        //   children: <Widget>[
        //     Padding(
        //       padding: EdgeInsets.all(20.0),
        //       child: OutlinedButton(
        //         child: Text('DELETE SELECTED'),
        //         onPressed: selectedUsers.isEmpty
        //             ? null
        //             : () {
        //                 deleteSelected();
        //               },
        //       ),
        //     ),
        //   ],
        // ),
        // ],
        // ),
        );
  }
}
