import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/models/ApiResponse.dart';
import 'package:mobile/models/Reservation.dart';
import 'package:mobile/globals.dart' as globals;
import 'package:mobile/models/User.dart';

class HomeViewModel {
  final API_HOST = dotenv.env["API_HOST"];

  Future<Reservation> reserve(String code, DateTime start, DateTime end) async {
    try {
      User user = globals.user!;
      final Response<Map<String, dynamic>> res =
          await Dio().post('$API_HOST/reservations', data: {
        "code": code,
        "startedAt": start.toIso8601String(),
        "endedAt": end.toIso8601String(),
        "userId": user.id
      }, options: Options(validateStatus: (status) {
        return status! < 500;
      }));
      log(res.toString());
      if (res.statusCode == 200) {
        ApiResponse response = ApiResponse.fromJson(res.data!);

        return Reservation.fromJson(response.data);
      } else {
        throw Exception(res.data!["resultMsg"] ?? "Login failed");
      }
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }
}
