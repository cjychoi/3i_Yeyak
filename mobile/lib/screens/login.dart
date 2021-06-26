import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size; // 앱 구동 맥락에서의 사이즈 정의

    return Scaffold(
      appBar: AppBar(
        title: Text('3i Yeyak'), // 상단 App Bar 텍스트
        backgroundColor: Colors.indigo, // 상단 App Bar 색상
      ),
      body: Stack(
        alignment: Alignment.center, // 세로 가운데 정렬
        children: <Widget>[
          // Container(color: Colors.white,), // 배경 색
          Column(
            crossAxisAlignment: CrossAxisAlignment.center, // 세로 가운데 정렬
            mainAxisAlignment: MainAxisAlignment.end, // 가로 아래로 정렬
            children: <Widget>[
              Image.asset('images/logo.png', width: 250, height: 250),
              TextField(
                  decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Name',
              )),
              Container(
                height: size.height * 0.02,
              ), // 갭
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed('/home');
                  }, //버튼 press시 홈뷰로 전환
                  child: Text('Login')),

              Container(
                height: size.height * 0.4,
              ) // 하단부 갭
            ],
          ),
        ],
      ),
    );
  }
}
