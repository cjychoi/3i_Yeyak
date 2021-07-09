import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/models/ApiResponse.dart';
import 'package:mobile/models/User.dart';

class LoginViewModel {
  final API_HOST = dotenv.env["API_HOST"];

  Future<User> login(String username) async {
    final Response<Map<String, dynamic>> res =
        await Dio().post('$API_HOST/users/login', data: {"username": username});
    log(res.toString());
    if (res.statusCode == 200) {
      ApiResponse response = ApiResponse.fromJson(res.data!);

      return User.fromJson(response.data);
    } else {
      throw Exception("Login failed");
    }
  }
}
