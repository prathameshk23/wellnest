// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStore, Store {
  late final _$authIdAtom = Atom(name: '_AppStore.authId', context: context);

  @override
  String get authId {
    _$authIdAtom.reportRead();
    return super.authId;
  }

  @override
  set authId(String value) {
    _$authIdAtom.reportWrite(value, super.authId, () {
      super.authId = value;
    });
  }

  late final _$nameAtom = Atom(name: '_AppStore.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$emailAtom = Atom(name: '_AppStore.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$usernameAtom =
      Atom(name: '_AppStore.username', context: context);

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  late final _$genderAtom = Atom(name: '_AppStore.gender', context: context);

  @override
  String get gender {
    _$genderAtom.reportRead();
    return super.gender;
  }

  @override
  set gender(String value) {
    _$genderAtom.reportWrite(value, super.gender, () {
      super.gender = value;
    });
  }

  late final _$ageGroupAtom =
      Atom(name: '_AppStore.ageGroup', context: context);

  @override
  String get ageGroup {
    _$ageGroupAtom.reportRead();
    return super.ageGroup;
  }

  @override
  set ageGroup(String value) {
    _$ageGroupAtom.reportWrite(value, super.ageGroup, () {
      super.ageGroup = value;
    });
  }

  late final _$wellnessGoalsAtom =
      Atom(name: '_AppStore.wellnessGoals', context: context);

  @override
  List<String> get wellnessGoals {
    _$wellnessGoalsAtom.reportRead();
    return super.wellnessGoals;
  }

  @override
  set wellnessGoals(List<String> value) {
    _$wellnessGoalsAtom.reportWrite(value, super.wellnessGoals, () {
      super.wellnessGoals = value;
    });
  }

  late final _$trackMenstrualAtom =
      Atom(name: '_AppStore.trackMenstrual', context: context);

  @override
  bool get trackMenstrual {
    _$trackMenstrualAtom.reportRead();
    return super.trackMenstrual;
  }

  @override
  set trackMenstrual(bool value) {
    _$trackMenstrualAtom.reportWrite(value, super.trackMenstrual, () {
      super.trackMenstrual = value;
    });
  }

  late final _$motivationLevelAtom =
      Atom(name: '_AppStore.motivationLevel', context: context);

  @override
  String get motivationLevel {
    _$motivationLevelAtom.reportRead();
    return super.motivationLevel;
  }

  @override
  set motivationLevel(String value) {
    _$motivationLevelAtom.reportWrite(value, super.motivationLevel, () {
      super.motivationLevel = value;
    });
  }

  late final _$healthStatusAtom =
      Atom(name: '_AppStore.healthStatus', context: context);

  @override
  String get healthStatus {
    _$healthStatusAtom.reportRead();
    return super.healthStatus;
  }

  @override
  set healthStatus(String value) {
    _$healthStatusAtom.reportWrite(value, super.healthStatus, () {
      super.healthStatus = value;
    });
  }

  late final _$symptomsAtom =
      Atom(name: '_AppStore.symptoms', context: context);

  @override
  List<String> get symptoms {
    _$symptomsAtom.reportRead();
    return super.symptoms;
  }

  @override
  set symptoms(List<String> value) {
    _$symptomsAtom.reportWrite(value, super.symptoms, () {
      super.symptoms = value;
    });
  }

  late final _$pandaAtom = Atom(name: '_AppStore.panda', context: context);

  @override
  String get panda {
    _$pandaAtom.reportRead();
    return super.panda;
  }

  @override
  set panda(String value) {
    _$pandaAtom.reportWrite(value, super.panda, () {
      super.panda = value;
    });
  }

  late final _$userAtom = Atom(name: '_AppStore.user', context: context);

  @override
  User get user {
    _$userAtom.reportRead();
    return super.user;
  }

  bool _userIsInitialized = false;

  @override
  set user(User value) {
    _$userAtom.reportWrite(value, _userIsInitialized ? super.user : null, () {
      super.user = value;
      _userIsInitialized = true;
    });
  }

  late final _$selectedDateAtom =
      Atom(name: '_AppStore.selectedDate', context: context);

  @override
  String get selectedDate {
    _$selectedDateAtom.reportRead();
    return super.selectedDate;
  }

  @override
  set selectedDate(String value) {
    _$selectedDateAtom.reportWrite(value, super.selectedDate, () {
      super.selectedDate = value;
    });
  }

  @override
  String toString() {
    return '''
authId: ${authId},
name: ${name},
email: ${email},
username: ${username},
gender: ${gender},
ageGroup: ${ageGroup},
wellnessGoals: ${wellnessGoals},
trackMenstrual: ${trackMenstrual},
motivationLevel: ${motivationLevel},
healthStatus: ${healthStatus},
symptoms: ${symptoms},
panda: ${panda},
user: ${user},
selectedDate: ${selectedDate}
    ''';
  }
}
