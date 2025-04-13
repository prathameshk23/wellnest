import 'package:mobx/mobx.dart';

import '../models/user.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  String authId = "";

  @observable
  String name = "";

  @observable
  String email = "";

  @observable
  String username = "";

  @observable
  String gender = "";

  @observable
  String ageGroup = "";

  @observable
  List<String> wellnessGoals = [];

  @observable
  bool trackMenstrual = false;

  @observable
  String motivationLevel = '';

  @observable
  String healthStatus = "";

  @observable
  List<String> symptoms = [];

  @observable
  String panda = "";

  @observable
  late User user;

  @observable
  String selectedDate = "";

  @observable
  List<String> menstrualDates = [];
}
