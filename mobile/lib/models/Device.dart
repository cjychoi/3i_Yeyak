class Device {
  final String id;

  final String code;

  final String manufacturer;
  final String model;
  final String color;
  final String os;
  final bool? availability;
  final String? description;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  Device(
      {required this.id,
      required this.code,
      required this.manufacturer,
      required this.model,
      required this.color,
      required this.os,
      this.availability,
      this.description,
      this.createdAt,
      this.updatedAt});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
        id: json["_id"],
        code: json["code"],
        manufacturer: json["manufacturer"],
        model: json["model"],
        color: json["color"],
        os: json["os"],
        availability: json["availability"],
        description: json["description"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null);
  }
}
