import 'dart:convert';

class Symptoms {
  String id;
  String name;
  dynamic description;

  Symptoms({
    required this.id,
    required this.name,
    required this.description,
  });

  Symptoms copyWith({
    String? id,
    String? name,
    dynamic description,
  }) =>
      Symptoms(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
      );

  factory Symptoms.fromRawJson(String str) =>
      Symptoms.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Symptoms.fromJson(Map<String, dynamic> json) => Symptoms(
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
