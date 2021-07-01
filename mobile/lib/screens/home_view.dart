import 'package:flutter/material.dart';
import 'package:mobile/screens/login_view.dart';
import 'package:hexcolor/hexcolor.dart';
//import 'package:mobile/screens/models.dart';
//import 'models.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<bool> isSelected;

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*title: GestureDetector(
          onTap: () {}, // handle your image tap here
          child: Image.asset(
            'menu.png',
            fit: BoxFit.cover, // this is the solution for border
            width: 20.0,
            height: 20.0,
          ),
        ),*/
        leading: IconButton(
          icon: Image.asset('images/menu.png',
              fit: BoxFit.cover,
              width: 30.0,
              height:
                  30.0), //Icon(Icons.notes), //Image.asset('images/menu.png', width: 50),
          onPressed: () => {},
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
            icon: Icon(
              Icons.edit,
              color: Colors.black,
            ),
            onPressed: () => {Navigator.of(context).popAndPushNamed('/login')},
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, //세로 위에 맞추기
          crossAxisAlignment: CrossAxisAlignment.center, //가로 중앙으로 맞추기
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(30)),
            ToggleButtons(
              //찾기 토글 버튼
              borderColor: Colors.white, //보더색
              fillColor: HexColor("0057FF"), //버튼 색
              borderWidth: 0, //보더 두깨
              selectedBorderColor: Colors.black, // 선택시 보더 색
              selectedColor: Colors.white, // 선택시 텍스트 색
              borderRadius: BorderRadius.circular(10),
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Device', // search by device
                    style: TextStyle(fontSize: 25),
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Time', // serach by time
                    style: TextStyle(fontSize: 25),
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ],
              onPressed: (int index) {
                setState(() {
                  //when one toggle option is selected, de-select the other
                  for (int i = 0; i < isSelected.length; i++) {
                    isSelected[i] = (i ==
                        index); //if i == index, set isSelected[i] = true, if i != index, set isSelcted[i] = false
                  }
                });
              },
              isSelected: isSelected,
            ),
          ],
        ),
      ),
    );
  }
}
