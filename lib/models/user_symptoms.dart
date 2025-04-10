import 'dart:convert';

class UserSymptoms {
  String id;
  String userId;
  Symptom symptom;

  UserSymptoms({
    required this.id,
    required this.userId,
    required this.symptom,
  });

  UserSymptoms copyWith({
    String? id,
    String? userId,
    Symptom? symptom,
  }) =>
      UserSymptoms(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        symptom: symptom ?? this.symptom,
      );

  factory UserSymptoms.fromRawJson(String str) =>
      UserSymptoms.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserSymptoms.fromJson(Map<String, dynamic> json) => UserSymptoms(
        id: json["id"],
        userId: json["userId"],
        symptom: Symptom.fromJson(json["symptom"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "symptom": symptom.toJson(),
      };
}

class Symptom {
  String id;
  String name;
  dynamic description;

  Symptom({
    required this.id,
    required this.name,
    required this.description,
  });

  Symptom copyWith({
    String? id,
    String? name,
    dynamic description,
  }) =>
      Symptom(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
      );

  factory Symptom.fromRawJson(String str) => Symptom.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Symptom.fromJson(Map<String, dynamic> json) => Symptom(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
