import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(); // username 저장용

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size; // 앱 구동 맥락에서의 사이즈 정의

    return Scaffold(
      /*
      appBar: AppBar(
        title: Text('3i Yeyak'), // 상단 App Bar 텍스트
        backgroundColor: Colors.indigo, // 상단 App Bar 색상
      ),
      */
      body: Stack(
        alignment: Alignment.center, // 세로 가운데 정렬
        children: <Widget>[
          // Container(color: Colors.white,), // 배경 색
          Column(
            crossAxisAlignment: CrossAxisAlignment.center, // 세로 가운데 정렬
            mainAxisAlignment: MainAxisAlignment.start, // 가로 아래로 정렬
            children: <Widget>[
              Container(
                // 상단부 갭
                height: size.height * 0.2,
              ),
              Image.asset('images/logo.png', width: 250, height: 250),
              TextFormField(
                // Username 입력창
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    // 입력값이 없으면 메시지 출력
                    return 'Please enter text';
                  }
                  return null;
                },
                controller: _usernameController, // username 컨트롤러로 변수에 값 저장

                // 텍스트폼필드에 스타일 적용
                decoration: InputDecoration(
                    icon: Icon(Icons.account_circle), // 계정 아이콘
                    border: OutlineInputBorder(), // 텍스트필드의 외각선
                    hintText: 'Enter Username', // 텍스트필드상에 출력되는 텍스트. 실제 값이 되진 않음
                    labelText: "Enter Username"), // 텍스트필드의 상단에 출력되는 레이블 텍스트
              ),
              Container(
                // 텍스트, 로그인 버튼 사이 갭
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed('/home');
                  }, // 버튼 press시 home_view로 전환
                  child: Text('Login')),
            ],
          ),
        ],
      ),
    );
  }
}
