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

  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final RegExp checkUsername = RegExp(
      r"^[a-zA-Z]{1,}(\.)?([a-zA-Z]{1,})?$"); // e.g. juan.kim, andrew.choi

  check() {
    if (_formKey.currentState == null) return;
    if (_formKey.currentState!.validate()) {
      // 검사
      Navigator.of(context).popAndPushNamed('/home'); // 이동
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          // 입력창, validation 적용되어있음.
          controller: usernameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please type your name';
            }
            if (!checkUsername.hasMatch(value)) {
              return 'Please check your name';
            }
            return null;
          },
          decoration: const InputDecoration(
              hintText: 'Enter your name', labelText: 'Username'),
          autofocus: true, // 자동으로 포커스 맞춰지게
          textInputAction: TextInputAction.go, // 키보드 오른쪽 밑 버튼 교체
          onFieldSubmitted: (value) {
            // go 버튼 눌렀을때
            check();
          },
        ),
        backgroundColor: Colors.grey, // App bar 배색
        actions: [
          Icon(Icons.notes), // 우측 상단 노트 아이콘 -> 버튼으로
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, //세로 위에 맞추기
          crossAxisAlignment: CrossAxisAlignment.center, //가로 중앙으로 맞추기
          children: <Widget>[
            ToggleButtons(
              //디바이스 찾기 토글 버튼
              borderColor: Colors.black, //보더색
              fillColor: Colors.grey, //버튼 색
              borderWidth: 1, //보더 두깨
              selectedBorderColor: Colors.yellow, // 선택시 보더 색
              selectedColor: Colors.white, // 선택시 텍스트 색
              borderRadius: BorderRadius.circular(0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Search by Device',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Search by Time',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < isSelected.length; i++) {
                    isSelected[i] = i == index;
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
