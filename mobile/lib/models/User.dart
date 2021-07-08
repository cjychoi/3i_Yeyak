class User {
  final String id;

  final String username;
  final String? team;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  User(
      {required this.id,
      required this.username,
      this.team,
      this.createdAt,
      this.updatedAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["_id"],
        username: json["username"],
        team: json["team"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null);
  }
}
