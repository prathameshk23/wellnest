import 'dart:convert';

class SleepTrack {
  String id;
  String sleepQuality;
  String sleepFacrtor;
  String sleepTime;
  DateTime date;
  String userId;

  SleepTrack({
    required this.id,
    required this.sleepQuality,
    required this.sleepFacrtor,
    required this.sleepTime,
    required this.date,
    required this.userId,
  });

  SleepTrack copyWith({
    String? id,
    String? sleepQuality,
    String? sleepFacrtor,
    String? sleepTime,
    DateTime? date,
    String? userId,
  }) =>
      SleepTrack(
        id: id ?? this.id,
        sleepQuality: sleepQuality ?? this.sleepQuality,
        sleepFacrtor: sleepFacrtor ?? this.sleepFacrtor,
        sleepTime: sleepTime ?? this.sleepTime,
        date: date ?? this.date,
        userId: userId ?? this.userId,
      );

  factory SleepTrack.fromRawJson(String str) =>
      SleepTrack.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SleepTrack.fromJson(Map<String, dynamic> json) => SleepTrack(
        id: json["id"],
        sleepQuality: json["sleep_quality"],
        sleepFacrtor: json["sleep_facrtor"],
        sleepTime: json["sleep_time"],
        date: DateTime.parse(json["date"]),
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sleep_quality": sleepQuality,
        "sleep_facrtor": sleepFacrtor,
        "sleep_time": sleepTime,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "userId": userId,
      };
}
