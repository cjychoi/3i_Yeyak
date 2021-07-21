import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/models/ApiResponse.dart';
import 'package:mobile/models/Reservation.dart';
import 'package:mobile/globals.dart' as globals;

class MyReservationViewModel extends ChangeNotifier {
  final API_HOST = dotenv.env["API_HOST"] ?? "http://localhost:8080/api";

  Future<List<Reservation>> loadThisList() async {
    try {
      print("url $API_HOST/reservations");
      final Response<Map<String, dynamic>> res = await Dio().get(
          '$API_HOST/reservations',
          queryParameters: {"userId": globals.user!.id},
          options: Options(validateStatus: (status) {
        return status! < 500;
      }));
      // print(res.toString());
      if (res.statusCode == 200) {
        ApiResponse response = ApiResponse.fromJson(res.data!);

        return (response.data as List<dynamic>).map((e) {
          return Reservation.fromJson(e);
        }).toList();
      } else {
        throw Exception(
            res.data!["resultMsg"] ?? "Failed to load my reservation list");
      }
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }
}
