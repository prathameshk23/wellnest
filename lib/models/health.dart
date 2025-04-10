import 'dart:convert';

class Health {
  String id;
  String stepCount;
  String weight;
  String heartRate;
  String calorieIntake;
  DateTime date;
  String userId;

  Health({
    required this.id,
    required this.stepCount,
    required this.weight,
    required this.heartRate,
    required this.calorieIntake,
    required this.date,
    required this.userId,
  });

  Health copyWith({
    String? id,
    String? stepCount,
    String? weight,
    String? heartRate,
    String? calorieIntake,
    DateTime? date,
    String? userId,
  }) =>
      Health(
        id: id ?? this.id,
        stepCount: stepCount ?? this.stepCount,
        weight: weight ?? this.weight,
        heartRate: heartRate ?? this.heartRate,
        calorieIntake: calorieIntake ?? this.calorieIntake,
        date: date ?? this.date,
        userId: userId ?? this.userId,
      );

  factory Health.fromRawJson(String str) => Health.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Health.fromJson(Map<String, dynamic> json) => Health(
        id: json["id"],
        stepCount: json["step_count"],
        weight: json["weight"],
        heartRate: json["heart_rate"],
        calorieIntake: json["calorie_intake"],
        date: DateTime.parse(json["date"]),
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "step_count": stepCount,
        "weight": weight,
        "heart_rate": heartRate,
        "calorie_intake": calorieIntake,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "userId": userId,
      };
}
