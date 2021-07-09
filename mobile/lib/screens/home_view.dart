import 'dart:async';

import 'package:flutter/cupertino.dart'; //datetime picker api
import 'package:flutter/material.dart';
import 'package:mobile/globals.dart' as globals;
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart'; //
import 'package:intl/intl.dart'; //needed to use date format
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart'; //barcode scanner
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart'; //date picker that supports formfield

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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
        endDrawer: Drawer(
          //use endDrawer to display drawer at right top corner
          child: ListView(
            // Important: Remove any padding from the ListPage.
            padding: EdgeInsets.zero, //No paddings
            children: <Widget>[
              DrawerHeader(
                // decoration: BoxDecoration(
                //   color: Colors.blue,
                // ),
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
              Padding(padding: EdgeInsets.only(bottom: 60)),
              ListTile(
                title:
                    Text('Credit', style: new TextStyle(color: Colors.white)),
                onLongPress: () {
                  Navigator.of(context).popAndPushNamed('/credits');
                },
                //display general reservation status of the devices
              )
            ],
          ),
        ),
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
                      child: TabBarView(controller: _tabController, children: <
                          Widget>[
                        Column(children: <Widget>[
                          Padding(padding: EdgeInsets.all(10)),
                          Text('Search Devices', //search by device subtitle
                              style: TextStyle(fontSize: 25)),
                          Column(children: <Widget>[
                            Container(
                                //serach bar
                                ),
                            Container(
                              child: IconButton(
                                iconSize: 50, //Size of QR scanning button
                                icon: Image.asset(
                                  'images/capture.png', //Camera image that proeceeds to QR scanning screen
                                ),
                                onPressed: () => {scanQR()},
                              ),
                            )
                          ]),
                          Text('Select Date',
                              style: TextStyle(
                                  fontSize: 25)), //select Date subtitle
                          Padding(padding: EdgeInsets.only(bottom: 10)),
                          Text(
                              'Select Rent Date'), //rent date under search by device
                          DateTimeField(
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2.0),
                              ),
                              border: OutlineInputBorder(),
                              labelText: "Enter the date:",
                            ),
                            initialValue:
                                value_rent_dev, //initial value is set as current time
                            format: format,
                            resetIcon: Icon(Icons
                                .delete), //trashcan icon as default delete button
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
                                              minuteInterval: 30,
                                              onDateTimeChanged:
                                                  (DateTime date) {
                                                value_rent_dev = date;
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
                              setState(
                                  () {}); //it runs whenever internal state of the object change occurs,
                              return value_rent_dev;
                            },
                          ),
                          Padding(padding: EdgeInsets.all(20)),
                          Text(
                              'Select Return Date'), //Return date under search by device
                          DateTimeField(
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2.0),
                              ),
                              border: OutlineInputBorder(),
                              labelText: "Enter the date:",
                            ),
                            initialValue: value_return_dev,
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
                                                  30, //set unit for each minute change to 30 mins
                                              onDateTimeChanged:
                                                  (DateTime date) {
                                                value_return_dev = date;
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
                              return value_return_dev;
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
                        Column(children: <Widget>[
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
                                              constraints: BoxConstraints(
                                                  maxHeight: 200),
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
                              resetIcon: Icon(
                                  Icons.delete), //Set reset icon as trashcan
                              onShowPicker: (context, currentValue) async {
                                await showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) {
                                      return BottomSheet(
                                        builder: (context) => Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              constraints: BoxConstraints(
                                                  maxHeight: 200),
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
                              label: Text('Reserve',
                                  style: TextStyle(fontSize: 20)),
                            )
                          ]),
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
