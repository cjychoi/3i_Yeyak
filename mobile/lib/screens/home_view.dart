import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/screens/login_view.dart';
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
  late List<bool> isSelected;
  late TabController _tabController;
  final format = DateFormat("yyyy-MM-dd HH");
  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;
  bool? showResetIcon = true;
  DateTime? value = DateTime.now();
 


  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
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
          iconTheme: IconThemeData(color: HexColor("0057FF")),
          leading: IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.black,
            ),
            onPressed: () => {
              //Navigator.pop(context)},
              Navigator.of(context).popAndPushNamed('/login')
            },
          ),

          backgroundColor: Colors.white, // App bar 배색
          centerTitle: false,
          titleSpacing: 0.0,
          title: Transform(
            // you can forcefully translate values left side using Transform
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: new Text(
              LoginPage.uName,
              style: new TextStyle(color: Colors.black, fontSize: 25.0),
            ),
          ),
         
        ),
        endDrawer: Drawer(

  // Add a ListView to the drawer. This ensures the user can scroll
  // through the options in the drawer if there isn't enough vertical
  // space to fit everything.
  child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Text(
              LoginPage.uName,
              style: new TextStyle(color: HexColor("0057FF"), fontSize: 35.0),
            ),
      ),
      ListTile(
        title: Text('My Reservation', style: new TextStyle(color: Colors.black, fontSize: 20.0)),
        onTap: () {
          // Update the state of the app.
          // ...
        },
      ),
      ListTile(
        title: Text('Reservation Status (TBD) ', style: new TextStyle(color: Colors.black, fontSize: 20.0)),
        onTap: () {
          // Update the state of the app.
          // ...
        },
      ),
    ],
  ),
),           
        body: new Container(
          child: ListView(
            children: <Widget>[
              //   Image.asset("path"),
              Container(
                child: Column(
                  children: <Widget>[
                    Image.asset('images/search_by.png', width: 200),
                    Container(
                      height: 50,
                      color: HexColor("0057FF"),
                      child: TabBar(
                        tabs: [
                          Container(
                            width: 70.0,
                            child: new Text(
                              'Device',
                              style: TextStyle(
                                fontSize: 20,
                                //
                              ),
                            ),
                          ),
                          Container(
                            width: 70.0,
                            child: new Text(
                              'Time',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                        unselectedLabelColor: const Color(0xffacb3bf),
                        indicatorColor: Colors.white,
                        labelColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 3.0,
                        indicatorPadding: EdgeInsets.all(10),
                        isScrollable: false,
                        controller: _tabController,
                      ),
                    ),
                    Container(
                      height: 600, //put tabbar below appbar
                      child: TabBarView(
                          controller: _tabController,
                          children: <Widget>[
                            Column(children: <Widget>[
                            Text('Search Device', style: TextStyle(fontSize: 25)),
                            Container(
                              child: IconButton(
                                icon: Image.asset('images/capture.png',
                                    fit: BoxFit.cover,
                                    width: 250.0,
                                    height: 250.0),
                                onPressed: () => {
                                  scanQR()
                                },
                              ),
                            ),
                            Text('Select Date', style: TextStyle(fontSize: 25)),
                            Text('Select rent date: (${format.pattern})'),
                                DateTimeField(
                                  initialValue: value,
                                  format: format,
                                  resetIcon: showResetIcon! ? Icon(Icons.delete) : null,
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
                                                    onDateTimeChanged:
                                                        (DateTime date) {
                                                      value = date;
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
                                    return value;
                                  },
                                ),
                                Text('select return date: (${format.pattern})'),
                                DateTimeField(
                                  initialValue: value,
                                  format: format,
                                  resetIcon: showResetIcon! ? Icon(Icons.delete) : null,
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
                                                    onDateTimeChanged:
                                                        (DateTime date) {
                                                      value = date;
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
                                    return value;
                                  },
                                ),
                            ]),
                            Column(children: <Widget>[
                              Column(children: <Widget>[
                                Text('Select rent date: (${format.pattern})'),
                                DateTimeField(
                                  initialValue: value,
                                  format: format,
                                  resetIcon: showResetIcon! ? Icon(Icons.delete) : null,
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
                                                    onDateTimeChanged:
                                                        (DateTime date) {
                                                      value = date;
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
                                    return value;
                                  },
                                ),

                              Column(children: <Widget>[
                                Text('select return date: (${format.pattern})'),
                                DateTimeField(
                                  initialValue: value,
                                  format: format,
                                  resetIcon: showResetIcon! ? Icon(Icons.delete) : null,
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
                                                    onDateTimeChanged:
                                                        (DateTime date) {
                                                      value = date;
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
                                    return value;
                                  },
                                ),
                               
      
    ]),
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