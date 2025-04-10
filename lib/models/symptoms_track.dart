import 'dart:convert';

class SymptomsTrack {
  String id;
  String value;
  DateTime date;
  String userSymptomId;
  String userId;

  SymptomsTrack({
    required this.id,
    required this.value,
    required this.date,
    required this.userSymptomId,
    required this.userId,
  });

  SymptomsTrack copyWith({
    String? id,
    String? value,
    DateTime? date,
    String? userSymptomId,
    String? userId,
  }) =>
      SymptomsTrack(
        id: id ?? this.id,
        value: value ?? this.value,
        date: date ?? this.date,
        userSymptomId: userSymptomId ?? this.userSymptomId,
        userId: userId ?? this.userId,
      );

  factory SymptomsTrack.fromRawJson(String str) =>
      SymptomsTrack.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SymptomsTrack.fromJson(Map<String, dynamic> json) => SymptomsTrack(
        id: json["id"],
        value: json["value"],
        date: DateTime.parse(json["date"]),
        userSymptomId: json["userSymptomId"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "date": date.toIso8601String(),
        "userSymptomId": userSymptomId,
        "userId": userId,
      };
}
