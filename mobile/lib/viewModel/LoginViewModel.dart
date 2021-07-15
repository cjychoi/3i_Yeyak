import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/models/ApiResponse.dart';
import 'package:mobile/models/User.dart';

class LoginViewModel {
  final API_HOST = dotenv.env["API_HOST"];

  Future<User> login(String username) async {
    try {
      print("url $API_HOST/users/login");
      final Response<Map<String, dynamic>> res = await Dio()
          .post('$API_HOST/users/login', data: {"username": username},
              options: Options(validateStatus: (status) {
        return status! < 500;
      }));
      log(res.toString());
      if (res.statusCode == 200) {
        ApiResponse response = ApiResponse.fromJson(res.data!);

        return User.fromJson(response.data);
      } else {
        throw Exception(res.data!["resultMsg"] ?? "Login failed");
      }
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }
}
