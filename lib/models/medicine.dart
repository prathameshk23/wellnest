import 'dart:convert';

class Medicine {
  String id;
  String name;
  String dosage;
  DateTime date;
  String userId;

  Medicine({
    required this.id,
    required this.name,
    required this.dosage,
    required this.date,
    required this.userId,
  });

  Medicine copyWith({
    String? id,
    String? name,
    String? dosage,
    DateTime? date,
    String? userId,
  }) =>
      Medicine(
        id: id ?? this.id,
        name: name ?? this.name,
        dosage: dosage ?? this.dosage,
        date: date ?? this.date,
        userId: userId ?? this.userId,
      );

  factory Medicine.fromRawJson(String str) =>
      Medicine.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        id: json["id"],
        name: json["name"],
        dosage: json["dosage"],
        date: DateTime.parse(json["date"]),
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dosage": dosage,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "userId": userId,
      };
}
