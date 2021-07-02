import 'package:flutter/material.dart';
import 'package:mobile/screens/login_view.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late List<bool> isSelected;
  late TabController _tabController;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.edit,
            color: Colors.black,
          ),
          onPressed: () => {Navigator.of(context).popAndPushNamed('/login')},
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
      body: Column(
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
                  height: 100,
                  child:
                      TabBarView(controller: _tabController, children: <Widget>[
                    Container(
                      child: IconButton(
                        icon: Image.asset('images/capture.png',
                            fit: BoxFit.cover, width: 150.0, height: 150.0),
                        onPressed: () =>
                            {Navigator.of(context).popAndPushNamed('/home')},
                      ),
                    ),
                    Container(
                      child: Text("Calandar :)"),
                    )
                  ]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
