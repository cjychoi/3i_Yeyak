import 'package:mobile/models/Device.dart';
import 'package:mobile/models/User.dart';

class Reservation {
  final String id;

  final User user;
  final Device device;

  final DateTime startedAt;
  final DateTime endedAt;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  Reservation(
      {required this.id,
      required this.user,
      required this.device,
      required this.startedAt,
      required this.endedAt,
      this.createdAt,
      this.updatedAt});

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
        id: json["_id"],
        user: User.fromJson(json["user"]),
        device: Device.fromJson(json["device"]),
        startedAt: DateTime.parse(json["startedAt"]),
        endedAt: DateTime.parse(json["endedAt"]),
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null);
  }
}
