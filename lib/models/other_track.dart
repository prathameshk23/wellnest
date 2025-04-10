import 'dart:convert';

class OtherTrack {
  String id;
  String value;
  DateTime date;
  String? otherfactor;
  String otherFactorName;
  String userId;

  OtherTrack({
    required this.id,
    required this.value,
    required this.date,
    this.otherfactor,
    required this.otherFactorName,
    required this.userId,
  });

  OtherTrack copyWith({
    String? id,
    String? value,
    DateTime? date,
    String? otherfactor,
    String? otherFactorName,
    String? userId,
  }) =>
      OtherTrack(
        id: id ?? this.id,
        value: value ?? this.value,
        date: date ?? this.date,
        otherfactor: otherfactor ?? this.otherfactor,
        otherFactorName: otherFactorName ?? this.otherFactorName,
        userId: userId ?? this.userId,
      );

  factory OtherTrack.fromRawJson(String str) =>
      OtherTrack.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OtherTrack.fromJson(Map<String, dynamic> json) => OtherTrack(
        id: json["id"],
        value: json["value"],
        date: DateTime.parse(json["date"]),
        otherfactor: json["otherfactor"],
        otherFactorName: json["otherFactorName"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "otherfactor": otherfactor,
        "otherFactorName": otherFactorName,
        "userId": userId,
      };
}
