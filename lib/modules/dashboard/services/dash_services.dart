import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:wellcare/models/health.dart';
import 'package:wellcare/models/mood_track.dart';
import 'package:wellcare/models/other_track.dart';
import 'package:wellcare/models/sleep_track.dart';
import 'package:wellcare/models/symptoms_track.dart';
import 'package:wellcare/models/user_symptoms.dart';
import 'package:http/http.dart' as http;
import '../../../models/medicine.dart';
import '../../../store/app_store.dart';
import '../../../utils/logger.dart';

const baseUrl = "https://bd8d-103-173-195-212.ngrok-free.app";
late String endPoint;
final AppStore store = Modular.get<AppStore>();

class DashServices {
  Future<List<UserSymptoms>> getUserSymptoms(String id) async {
    endPoint = "/user-symptoms/$id";
    final url = "$baseUrl$endPoint";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      logger.i("Success + ${response.body}");
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => UserSymptoms.fromJson(e)).toList();
    }

    throw Exception("Failed to load symptoms");
  }

  Future<List<SymptomsTrack>> getSymptomsTrack(String id) async {
    endPoint = "/symptoms-tracking?userId=$id&date=${store.selectedDate}";
    final url = "$baseUrl$endPoint";
    logger.d(Uri.parse(url));

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      logger.i("Success + ${response.body}");
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => SymptomsTrack.fromJson(e)).toList();
    }

    throw Exception("Failed to load symptoms");
  }

  Future<List<SleepTrack>> getSleepTrack(String id) async {
    endPoint = "/sleep-tracking?userId=$id&date=${store.selectedDate}";
    final url = "$baseUrl$endPoint";
    logger.d(Uri.parse(url));

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      logger.i("Success + ${response.body}");
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => SleepTrack.fromJson(e)).toList();
    }

    throw Exception("Failed to load symptoms");
  }

  Future<List<Health>> getHealth(String id) async {
    endPoint = "/health?userId=$id&date=${store.selectedDate}";
    final url = "$baseUrl$endPoint";
    logger.d(Uri.parse(url));

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      logger.i("Success + ${response.body}");
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => Health.fromJson(e)).toList();
    }

    throw Exception("Failed to load symptoms");
  }

  Future<List<OtherTrack>> getOtherTrack(String id) async {
    endPoint = "/user-other-tracking?userId=$id&date=${store.selectedDate}";
    final url = "$baseUrl$endPoint";
    logger.d(Uri.parse(url));

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      logger.i("Success + ${response.body}");
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => OtherTrack.fromJson(e)).toList();
    }

    throw Exception("Failed to load symptoms");
  }

  Future<List<MoodTrack>> getMoodTrack(String id) async {
    endPoint = "/mood-tracking?userId=$id&date=${store.selectedDate}";
    final url = "$baseUrl$endPoint";
    logger.d(Uri.parse(url));

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      logger.i("Success + ${response.body}");
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => MoodTrack.fromJson(e)).toList();
    }

    throw Exception("Failed to load symptoms");
  }

  Future<UserSymptoms> postUserSymptoms(UserSymptoms symptom) async {
    endPoint = "/user-symptoms";
    final url = "$baseUrl$endPoint";
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(symptom.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      logger.i("Success + ${response.body}");
      return UserSymptoms.fromJson(jsonDecode(response.body));
    }

    throw Exception("Failed to post user symptoms");
  }

  Future<void> postSymptomsTrack(Map<String, dynamic> track) async {
    endPoint = "/symptoms-tracking";
    final url = "$baseUrl$endPoint";
    logger.d(Uri.parse(url));

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(track),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      logger.i("Success + ${response.body}");
      return;
    }

    throw Exception("Failed to post symptoms tracking");
  }

  Future<void> postSleepTrack(Map<String, dynamic> track) async {
    endPoint = "/sleep-tracking";
    final url = "$baseUrl$endPoint";
    logger.d(Uri.parse(url));

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(track),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      logger.i("Success + ${response.body}");
      return;
    }

    throw Exception("Failed to post sleep tracking");
  }

  Future<void> postHealth(Map<String, dynamic> health) async {
    endPoint = "/health";
    final url = "$baseUrl$endPoint";
    logger.d(Uri.parse(url));

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(health),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      logger.i("Success + ${response.body}");
      return;
    }

    throw Exception("Failed to post health data");
  }

  Future<void> postOtherTrack(Map<String, dynamic> track) async {
    endPoint = "/user-other-tracking";
    final url = "$baseUrl$endPoint";
    logger.d(Uri.parse(url));

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(track),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      logger.i("Success + ${response.body}");
      return;
    }

    throw Exception("Failed to post other tracking data");
  }

  Future<void> postMoodTrack(Map<String, dynamic> track) async {
    endPoint = "/mood-tracking";
    final url = "$baseUrl$endPoint";
    logger.d(Uri.parse(url));

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(track),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      logger.i("Success + ${response.body}");
      return;
    }

    throw Exception("Failed to post mood tracking data");
  }

  Future<void> postMedicine(Map<String, dynamic> track) async {
    endPoint = "/medicine";
    final url = "$baseUrl$endPoint";
    logger.d(Uri.parse(url));

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(track),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      logger.i("Success + ${response.body}");
      return;
    }

    throw Exception("Failed to post mood tracking data");
  }

  Future<List<Medicine>> getMedicine(String id) async {
    endPoint = "/medicine?userId=$id&date=${store.selectedDate}";
    final url = "$baseUrl$endPoint";
    logger.d(Uri.parse(url));

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      logger.i("Success + ${response.body}");
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => Medicine.fromJson(e)).toList();
    }

    throw Exception("Failed to load symptoms");
  }
}
