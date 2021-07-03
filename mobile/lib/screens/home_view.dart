import 'dart:async';

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
  final format = DateFormat("yyyy-MM-dd HH:mm");
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
          actions: [
            IconButton(
              icon: Image.asset('images/menu.png',
                  fit: BoxFit.cover, width: 30.0, height: 30.0),
              onPressed: () => {},
            ),
          ],
        ),
/*

          */
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
                      height: 170, //put tabbar below appbar
                      child: TabBarView(
                          controller: _tabController,
                          children: <Widget>[
                            Container(
                              child: IconButton(
                                icon: Image.asset('images/capture.png',
                                    fit: BoxFit.cover,
                                    width: 150.0,
                                    height: 150.0),
                                onPressed: () => {scanQR()},
                                //Navigator.of(context).popAndPushNamed('/home')},
                              ),
                            ),
                            Column(children: <Widget>[
                              Text('Rent date & time: (${format.pattern})'),
                              DateTimeField(
                                format: format,
                                onShowPicker: (context, currentValue) async {
                                  final date = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(2021, 1, 1),
                                      initialDate:
                                          currentValue ?? DateTime.now(),
                                      lastDate: DateTime(2022, 12, 31));
                                  if (date != null) {
                                    final time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          currentValue ?? DateTime.now()),
                                    );
                                    return DateTimeField.combine(date, time);
                                  } else {
                                    return currentValue;
                                  }
                                },
                              ),
                              Text('Return date & time: (${format.pattern})'),
                              DateTimeField(
                                format: format,
                                onShowPicker: (context, currentValue) async {
                                  final date = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(2021, 1, 1),
                                      initialDate:
                                          currentValue ?? DateTime.now(),
                                      lastDate: DateTime(2022, 12, 31));
                                  if (date != null) {
                                    final time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          currentValue ?? DateTime.now()),
                                    );
                                    return DateTimeField.combine(date, time);
                                  } else {
                                    return currentValue;
                                  }
                                },
                              ),
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
