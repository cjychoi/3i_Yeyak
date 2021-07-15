import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile/viewModel/LoginViewModel.dart';
import 'package:mobile/globals.dart' as globals;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(); // username 저장용
  final LoginViewModel viewModel = LoginViewModel();
  bool _isLoading = false;

  check() {
    if (_formKey.currentState == null) return;
    if (_formKey.currentState!.validate()) {
      // 검사
      if (!_isLoading) {
        setState(() {
          _isLoading = true;
        });
        viewModel
            .login(_usernameController.text)
            .then((value) => {
                  setState(() {
                    _isLoading = false;
                  }),
                  globals.user = value,
                  Navigator.of(context).popAndPushNamed('/home') // 이동
                })
            .catchError((err) {
          Fluttertoast.showToast(
            msg: err.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }).whenComplete(() {
          setState(() {
            _isLoading = false;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size; // 앱 구동 맥락에서의 사이즈 정의

    return Scaffold(
      body: Stack(
        alignment: Alignment.center, // 세로 가운데 정렬
        children: <Widget>[
          Container(
            color: Colors.white,
          ), // 배경 색
          Column(
            crossAxisAlignment: CrossAxisAlignment.center, // 세로 가운데 정렬
            mainAxisAlignment: MainAxisAlignment.start, // 가로 아래로 정렬
            children: <Widget>[
              Container(
                height: size.height * 0.05,
              ), // 상단부 갭
              Image.asset('images/login_view_logo.png', width: 250),
              Padding(
                padding: EdgeInsets.all(20), // Username 입력창 주위 갭
                child: Card(
                  // 위로 떠오른 효과
                  elevation: 3, // 떠오른 정도
                  child: Form(
                      key: _formKey, // unique ID 지정
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            // Username 입력창
                            controller:
                                _usernameController, // username 컨트롤러로 변수에 값 저장
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                // 입력값이 없으면 메시지 출력
                                return 'Please enter text';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                // icon: Icon(Icons.account_circle), // 계정 아이콘
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.blue, width: 2.0),
                                ),
                                border: OutlineInputBorder(), // 텍스트필드의 외각선
                                hintText:
                                    'Enter Username', // 텍스트필드상에 출력되는 텍스트. 실제 값이 되진 않음
                                labelText: "Username"),
                            autofocus: true, // 자동으로 포커스 맞춰지게
                            textInputAction: TextInputAction.go,
                            onFieldSubmitted: (value) {
                              check();
                            }, // 텍스트필드의 상단에 출력되는 레이블 텍스트
                          ),
                        ],
                      )),
                ),
              ),
              Container(
                // 텍스트, 로그인 버튼 사이 갭
                height: 25,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              // 버튼 테두리 둥글게
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: Colors.white)))),
                  onPressed: () {
                    // 버튼 press시 home_view로 전환
                    check();
                  },
                  child: Text(_isLoading ? 'Logging in...' : 'Login',
                      style: TextStyle(fontSize: 20))),
            ],
          ),
        ],
      ),
    );
  }
}
