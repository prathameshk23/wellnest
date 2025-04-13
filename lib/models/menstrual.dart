import 'dart:convert';

class Menstrual {
  String id;
  List<String> date;
  String month;
  String year;
  String userId;

  Menstrual({
    required this.id,
    required this.date,
    required this.month,
    required this.year,
    required this.userId,
  });

  Menstrual copyWith({
    String? id,
    List<String>? date,
    String? month,
    String? year,
    String? userId,
  }) =>
      Menstrual(
        id: id ?? this.id,
        date: date ?? this.date,
        month: month ?? this.month,
        year: year ?? this.year,
        userId: userId ?? this.userId,
      );

  factory Menstrual.fromRawJson(String str) =>
      Menstrual.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Menstrual.fromJson(Map<String, dynamic> json) => Menstrual(
        id: json["id"],
        date: List<String>.from(json["date"].map((x) => x)),
        month: json["month"],
        year: json["year"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": List<dynamic>.from(date.map((x) => x)),
        "month": month,
        "year": year,
        "userId": userId,
      };
}
