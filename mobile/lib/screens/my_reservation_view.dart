import 'package:flutter/material.dart';
import 'package:mobile/screens/login_view.dart';

void main() => runApp(MyPage());

class MyPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DataTableDemo();
  }
}

class User {
  String devices;
  String date;
  String userName;

  User({required this.devices, required this.date, required this.userName});

  static List<User> getUsers() {
    return <User>[
      User(date: "2021-07-21 05:30", devices: "S 10", userName: "Juan"),
      User(date: "2021-07-21 06:30", devices: "Note 20", userName: "James"),
      User(date: "2021-07-20 04:30", devices: "iPhone 11", userName: "George"),
      User(date: "2021-07-26 07:30", devices: "Juan 12", userName: "Andrew"),
      User(date: "2021-07-23 04:30", devices: "Juan 84", userName: "Jedi"),
    ];
  }
}

class DataTableDemo extends StatefulWidget {
  DataTableDemo() : super();

  final String title = "My Reservation";

  @override
  DataTableDemoState createState() => DataTableDemoState();
}

class DataTableDemoState extends State<DataTableDemo> {
  late List<User> users;
  late List<User> selectedUsers;
  late bool sort;

  @override
  void initState() {
    sort = false;
    selectedUsers = [];
    users = User.getUsers();
    super.initState();
  }

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        users.sort((a, b) => a.date.compareTo(b.date));
      } else {
        users.sort((a, b) => b.date.compareTo(a.date));
      }
    }
  }

  onSelectedRow(bool selected, User user) async {
    setState(() {
      if (selected) {
        selectedUsers.add(user);
      } else {
        selectedUsers.remove(user);
      }
    });
  }

  deleteSelected() async {
    setState(() {
      if (selectedUsers.isNotEmpty) {
        List<User> temp = [];
        temp.addAll(selectedUsers);
        for (User user in temp) {
          users.remove(user);
          selectedUsers.remove(user);
        }
      }
    });
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        sortAscending: sort,
        sortColumnIndex: 0,
        columns: [
          DataColumn(
              label: Icon(Icons.calendar_today, color: Colors.green[500]),
              numeric: false,
              tooltip: "This is Date",
              onSort: (columnIndex, ascending) {
                setState(() {
                  sort = !sort;
                });
                onSortColum(columnIndex, ascending);
              }),
          DataColumn(
            label: Icon(Icons.phone_android, color: Colors.green[500]),
            numeric: false,
            tooltip: "This is Device Name",
          ),
          DataColumn(
            label: Icon(Icons.person, color: Colors.green[500]),
            numeric: false,
            tooltip: "This is the name of the user",
          )
        ],
        rows: users
            .map(
              (user) => DataRow(
                  selected: selectedUsers.contains(user),
                  onSelectChanged: (b) {
                    print("Onselect");
                    onSelectedRow(b!, user);
                  },
                  cells: [
                    DataCell(
                      Text(user.date),
                      onTap: () {
                        print('Selected ${user.date}');
                      },
                    ),
                    DataCell(
                      Text(user.devices),
                    ),
                    DataCell(
                      Text(user.userName),
                    ),
                  ]),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          //onPressed: () {
          //   Navigator.of(context).popAndPushNamed('/home');
          // },
          //implement backbutton in
          color: Colors.white,
        ),
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Expanded(
            child: dataBody(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Padding(
              //   padding: EdgeInsets.all(20.0),
              //   child: OutlinedButton(
              //     child: Text('SELECTED ${selectedUsers.length}'),
              //     onPressed: () {},
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: OutlinedButton(
                  child: Text('DELETE SELECTED'),
                  onPressed: selectedUsers.isEmpty
                      ? null
                      : () {
                          deleteSelected();
                        },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
