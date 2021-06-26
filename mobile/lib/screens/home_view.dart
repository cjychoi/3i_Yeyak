import 'package:flutter/material.dart';

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
        title: TextFormField(
            decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Enter Name',
        )),
        backgroundColor: Colors.grey, // App bar 배색
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => {Navigator.of(context).popAndPushNamed('/login')},
          ),
          Padding(padding: EdgeInsets.all(100)),
          IconButton(
            icon: Icon(Icons.notes),
            onPressed: () => {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, //세로 위에 맞추기
          crossAxisAlignment: CrossAxisAlignment.center, //가로 중앙으로 맞추기
          children: <Widget>[
            ToggleButtons(
              //찾기 토글 버튼
              borderColor: Colors.black, //보더색
              fillColor: Colors.grey, //버튼 색
              borderWidth: 1, //보더 두깨
              selectedBorderColor: Colors.black, // 선택시 보더 색
              selectedColor: Colors.white, // 선택시 텍스트 색
              borderRadius: BorderRadius.circular(0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Search by Device', // search by device
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Search by Time', // serach by time
                    style: TextStyle(fontSize: 16),
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
