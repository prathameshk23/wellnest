import 'dart:convert';

class MoodTrack {
  String id;
  String value;
  DateTime date;
  List<String> moods;
  String userId;

  MoodTrack({
    required this.id,
    required this.value,
    required this.date,
    required this.moods,
    required this.userId,
  });

  MoodTrack copyWith({
    String? id,
    String? value,
    DateTime? date,
    List<String>? moods,
    String? userId,
  }) =>
      MoodTrack(
        id: id ?? this.id,
        value: value ?? this.value,
        date: date ?? this.date,
        moods: moods ?? this.moods,
        userId: userId ?? this.userId,
      );

  factory MoodTrack.fromRawJson(String str) =>
      MoodTrack.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MoodTrack.fromJson(Map<String, dynamic> json) => MoodTrack(
        id: json["id"],
        value: json["value"],
        date: DateTime.parse(json["date"]),
        moods: List<String>.from(json["moods"].map((x) => x)),
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "moods": List<dynamic>.from(moods.map((x) => x)),
        "userId": userId,
      };
}
