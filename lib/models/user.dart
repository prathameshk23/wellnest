import 'dart:convert';

class User {
  String name;
  String email;
  String gender;
  String ageGroup;
  String motivationLevel;
  String healthStatus;
  String panda;
  String username;
  List<String> wellnessGoals;
  bool isMenstrual;
  String id;

  User({
    required this.name,
    required this.email,
    required this.gender,
    required this.ageGroup,
    required this.motivationLevel,
    required this.healthStatus,
    required this.panda,
    required this.username,
    required this.wellnessGoals,
    required this.isMenstrual,
    required this.id,
  });

  User copyWith({
    String? name,
    String? email,
    String? gender,
    String? ageGroup,
    String? motivationLevel,
    String? healthStatus,
    String? panda,
    String? username,
    List<String>? wellnessGoals,
    bool? isMenstrual,
    String? id,
  }) =>
      User(
        name: name ?? this.name,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        ageGroup: ageGroup ?? this.ageGroup,
        motivationLevel: motivationLevel ?? this.motivationLevel,
        healthStatus: healthStatus ?? this.healthStatus,
        panda: panda ?? this.panda,
        username: username ?? this.username,
        wellnessGoals: wellnessGoals ?? this.wellnessGoals,
        isMenstrual: isMenstrual ?? this.isMenstrual,
        id: id ?? this.id,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        gender: json["gender"],
        ageGroup: json["age_group"],
        motivationLevel: json["motivation_level"],
        healthStatus: json["health_status"],
        panda: json["panda"],
        username: json["username"],
        wellnessGoals: List<String>.from(json["wellness_goals"].map((x) => x)),
        isMenstrual: json["isMenstrual"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "gender": gender,
        "age_group": ageGroup,
        "motivation_level": motivationLevel,
        "health_status": healthStatus,
        "panda": panda,
        "username": username,
        "wellness_goals": List<dynamic>.from(wellnessGoals.map((x) => x)),
        "isMenstrual": isMenstrual,
        "id": id,
      };
}
