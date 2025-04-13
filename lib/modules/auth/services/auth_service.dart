import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:wellcare/models/conditions.dart';

import '../../../models/user.dart';
import '../../../store/app_store.dart';
import '../../../utils/logger.dart';
import '../../dashboard/screens/dashboard_screen.dart';

const baseUrl = "https://c419-115-96-217-84.ngrok-free.app";
late String endPoint;
final AppStore store = Modular.get<AppStore>();

class AuthServices {
  Future<List<Symptoms>> getAllSymptoms() async {
    endPoint = "/symptoms";
    final url = "$baseUrl$endPoint";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      logger.i("Success + ${response.body}");
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => Symptoms.fromJson(e)).toList();
    }

    throw Exception("Failed to load symptoms");
  }

  Future<void> postUser() async {
    endPoint = "/user";
    final url = "$baseUrl$endPoint";
    User user;

    var body = {
      'name': store.name,
      'email': store.email,
      'gender': store.gender,
      'age_group': store.ageGroup,
      'motivation_level': store.motivationLevel,
      'health_status': store.healthStatus,
      'panda': store.panda,
      'username': store.username,
      'wellness_goals': store.wellnessGoals, // 👍 List is OK in JSON
      'isMenstrual': store.trackMenstrual,
      "authid": store.authId
    };

    print(body);
    logger.d(body);

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    print(response.body);
    var data = jsonDecode(response.body);
    user = User.fromJson(data);
    store.user = user;
    print(data);
    for (var symptomId in store.symptoms) {
      var body = {
        'user': data['id'],
        'symptom': symptomId,
      };
      endPoint = "/user-symptoms";
      final url = "$baseUrl$endPoint";
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      print(body);
    }
  }

  Future<User?> getUser(String authId) async {
    endPoint = "/user/${authId}";
    final url = "$baseUrl$endPoint";
    final response = await http.get(Uri.parse(url));
    print("hello");
    User user;

    final decoded = jsonDecode(response.body); // Map<String, dynamic>
    user = User.fromJson(decoded);
    print(user);
    store.user = user;
    logger.i(store.user);

    if (response.statusCode == 200) {
      logger.i("Success + ${response.body}");
      // List<dynamic> jsonList = jsonDecode(response.body);
      Modular.to.pushNamed(DashboardScreen.toRoute);
      print("hello");
      return user;
    }
  }
}
