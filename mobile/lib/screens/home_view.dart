import 'dart:async';

import 'package:flutter/cupertino.dart'; //datetime picker api
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile/globals.dart' as globals;
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart'; //
import 'package:intl/intl.dart'; //needed to use date format
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart'; //barcode scanner
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart'; //date picker that supports formfield
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mobile/util/DateUtil.dart';
import 'package:mobile/viewModel/HomeViewModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final HomeViewModel viewModel = HomeViewModel();
  //탭바 앱바 밑 바디에 사용하기
  late TabController _tabController; //tabcontroller to use tab bar
  final format = DateFormat(
      "yyyy-MM-dd HH:mm"); //the date format it will be displayed at date format field
  bool? showResetIcon = true;
  DateTime? value_rent_dev; //search by device -> rent date
  DateTime? value_return_dev; //search by device -> return date
  DateTime? value_rent_date; //search by date -> rent date
  DateTime? value_return_date; //search by date -> return date
  DateTime?
      value; //date time value that will be initial DateTime(default), needed to make minute interval 30 minutes

  final _codeController = TextEditingController();
  bool isLoading = false;

  final DatePickerTheme datePickerTheme = DatePickerTheme(
      headerColor: Colors.blue,
      backgroundColor: Colors.blue,
      itemStyle: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      doneStyle: TextStyle(color: Colors.white, fontSize: 16));
  DateTime? startAt;
  DateTime? endAt;

  void changeStartAt(DateTime value) {
    setState(() {
      startAt = value.roundWithin30Minutes();
    });
  }

  void changeEndAt(DateTime value) {
    setState(() {
      endAt = value.roundWithin30Minutes();
    });
  }

  void reserve() {
    if (startAt != null && endAt != null) {
      setState(() {
        isLoading = true;
      });
      viewModel
          .reserve(_codeController.text, startAt!, endAt!)
          .catchError((err) {
        Fluttertoast.showToast(
            msg: err.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      }).then((value) {
        Fluttertoast.showToast(msg: "무야호");
      }).whenComplete(() {
        setState(() {
          isLoading = false;
        });
      });
    } else {
      Fluttertoast.showToast(msg: "HaHa");
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(length: 2, vsync: this); //tab bar has two views
    DateTime initial = DateTime.now();
    value = DateTime(initial.year, initial.month, initial.day, initial.hour,
        30); //set default minute value as 30, so that minute interval will not have any conflits
  }

  Future<void> scanQR() async {
    //QR Scanner API
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false, //avoid pixel overloading
        appBar: AppBar(
          //appbar is displayed at the top of the screen
          iconTheme: IconThemeData(
              color: HexColor(
                  "0057FF")), //Icon colors will be as our theme color as the default
          leading: IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.black, //Set edit button to black
            ),
            onPressed: () => {
              Navigator.of(context).popAndPushNamed(
                  '/login') //when pressed, redirect to login page
            },
          ),
          backgroundColor: Colors.white, // App bar 배색
          centerTitle: false, //Make title(user name) to be able to be shifted
          titleSpacing: 0.0,
          title: Transform(
            // you can forcefully translate values left side using Transform
            transform: Matrix4.translationValues(
                -15.0, 0.0, 0.0), //make user name shifted towards left
            child: new Text(
              globals.user!.username, //Display user name at the left top corner
              style: new TextStyle(
                  color: Colors.black, fontSize: 25.0), //style of username
            ),
          ),
        ),
        endDrawer: HomeDrawer(),
        body: new Container(
          child: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Image.asset('images/search_by.png',
                        width: 200), //Search by image
                    Container(
                      height: 50,
                      color: HexColor("0057FF"), //themecolor
                      child: TabBar(
                        //tabbar
                        tabs: [
                          Container(
                            width: 70.0, //width of first tab
                            child: new Text(
                              'Device', //Device tab in tab bar
                              style: TextStyle(
                                fontSize: 20,
                                //
                              ),
                            ),
                          ),
                          Container(
                            width: 70.0, //width of second container
                            child: new Text(
                              'Time', //Time tab in tab bar
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                        unselectedLabelColor: const Color(
                            0xffacb3bf), //the color of label that is not selected
                        indicatorColor: Colors
                            .white, //the color of the line that appears below text
                        labelColor: Colors.white, //the color of selected label
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 3.0,
                        indicatorPadding: EdgeInsets.all(10),
                        isScrollable: false,
                        controller: _tabController,
                      ),
                    ),
                    Container(
                      height: 600, //put tabbar below appbar
                      child: TabBarView(controller: _tabController, children: [
                        Column(children: <Widget>[
                          Padding(padding: EdgeInsets.all(10)),
                          Text('Search Devices', //search by device subtitle
                              style: TextStyle(fontSize: 25)),
                          Column(children: <Widget>[
                            Container(
                                //serach bar
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: TextField(
                                          controller: _codeController,
                                          decoration: InputDecoration(
                                              labelText: 'code'),
                                        ),
                                        flex: 9),
                                    Container(
                                        child: IconButton(
                                          iconSize:
                                              50, //Size of QR scanning button
                                          icon: Icon(Icons.qr_code_2_rounded),
                                          onPressed: () => {scanQR()},
                                        ),
                                        width: 50)
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 25)),
                            Container(
                              child: Wrap(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        DatePicker.showDateTimePicker(context,
                                            showTitleActions: true,
                                            minTime: DateTime.now(),
                                            maxTime: endAt,
                                            onChanged: changeStartAt,
                                            onConfirm: changeStartAt,
                                            theme: this.datePickerTheme);
                                      },
                                      child: Container(
                                        child: Text(
                                          startAt != null
                                              ? DateFormat('yyyy-MM-dd HH:mm')
                                                  .format(startAt!)
                                              : 'Please select rent time',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                    .5 -
                                                25 / 2 -
                                                1,
                                        height: 50,
                                        alignment: Alignment.center,
                                      )),
                                  Container(
                                    child: Text('~',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20)),
                                    width: 25,
                                    height: 50,
                                    alignment: Alignment.center,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        DatePicker.showDateTimePicker(context,
                                            showTitleActions: true,
                                            minTime: startAt,
                                            onChanged: changeEndAt,
                                            onConfirm: changeEndAt,
                                            theme: this.datePickerTheme);
                                      },
                                      child: Container(
                                        child: Text(
                                            endAt != null
                                                ? DateFormat('yyyy-MM-dd HH:mm')
                                                    .format(endAt!)
                                                : 'Please select return time',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 17)),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                    .5 -
                                                25 / 2 -
                                                1,
                                        height: 50,
                                        alignment: Alignment.center,
                                      ))
                                ],
                              ),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                            )
                          ]),
                          Padding(padding: EdgeInsets.all(30)),
                          FloatingActionButton.extended(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            onPressed: () {
                              print('Reserve button has been pressed');
                              reserve();
                            },
                            icon: Icon(Icons.check),
                            label:
                                Text('Reserve', style: TextStyle(fontSize: 20)),
                          )
                        ]),
                        Column(children: <Widget>[
                          Padding(padding: EdgeInsets.all(20)),
                          Text('Select Date', style: TextStyle(fontSize: 25)),
                          Padding(padding: EdgeInsets.all(15)),
                          Text('Select Rent Date'),
                          DateTimeField(
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.blue, width: 2.0),
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Enter the date:"),
                            initialValue: value_rent_date,
                            format: format,
                            resetIcon:
                                showResetIcon! ? Icon(Icons.delete) : null,
                            onShowPicker: (context, currentValue) async {
                              await showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    return BottomSheet(
                                      builder: (context) => Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            constraints:
                                                BoxConstraints(maxHeight: 200),
                                            child: CupertinoDatePicker(
                                              initialDateTime: value,
                                              minuteInterval:
                                                  30, //set unit for each minute change to 10 mins
                                              onDateTimeChanged:
                                                  (DateTime date) {
                                                value_rent_date = date;
                                              },
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Ok')),
                                        ],
                                      ),
                                      onClosing: () {},
                                    );
                                  });
                              setState(() {});
                              return value_rent_date;
                            },
                          ),
                          SizedBox(height: 24),
                          Padding(padding: EdgeInsets.all(20)),
                          Text('Select Return Date'),
                          DateTimeField(
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2.0),
                              ),
                              border: OutlineInputBorder(),
                              labelText: "Enter the date:",
                            ),
                            initialValue: value_return_date,
                            format: format,
                            resetIcon:
                                Icon(Icons.delete), //Set reset icon as trashcan
                            onShowPicker: (context, currentValue) async {
                              await showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    return BottomSheet(
                                      builder: (context) => Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            constraints:
                                                BoxConstraints(maxHeight: 200),
                                            child: CupertinoDatePicker(
                                              initialDateTime: value,
                                              minuteInterval:
                                                  30, //set unit for each minute change to 10 mins
                                              onDateTimeChanged:
                                                  (DateTime date) {
                                                value_return_date = date;
                                              },
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Ok')),
                                        ],
                                      ),
                                      onClosing: () {},
                                    );
                                  });
                              setState(() {});
                              return value_return_date;
                            },
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 40)),
                          FloatingActionButton.extended(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            onPressed: () {
                              print('Reserve button has been pressed');
                            },
                            icon: Icon(Icons.check),
                            label:
                                Text('Reserve', style: TextStyle(fontSize: 20)),
                          )
                        ]),
                      ]),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      //use endDrawer to display drawer at right top corner
      child: ListView(
        // Important: Remove any padding from the ListPage.
        padding: EdgeInsets.zero, //No paddings
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              globals.user!.username,
              style: new TextStyle(
                  color: HexColor("0057FF"),
                  fontSize:
                      35.0), //display another username in the drawer when opened
            ),
          ),
          ListTile(
            title: Text('My Reservation',
                style: new TextStyle(color: Colors.black, fontSize: 20.0)),
            onTap: () {
              Navigator.of(context).pushNamed('/myreservation');
              //redirect to the device ListPage
            },
          ),
          ListTile(
            title: Text('Reservation Status',
                style: new TextStyle(color: Colors.black, fontSize: 20.0)),
            onTap: () {
              Navigator.of(context).pushNamed('/reservation');
              //display general reservation status of the devices
            },
          ),
          Padding(padding: EdgeInsets.only(bottom: 260)),
          ListTile(
            title: Text(' ', style: new TextStyle(color: Colors.white)),
            onLongPress: () {
              Navigator.of(context).popAndPushNamed('/credits');
            },
            //display general reservation status of the devices
          )
        ],
      ),
    );
  }
}
