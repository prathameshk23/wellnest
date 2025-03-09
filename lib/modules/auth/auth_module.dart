import 'package:flutter_modular/flutter_modular.dart';
import 'package:wellcare/modules/auth/screens/adopt_screen.dart';
import 'package:wellcare/modules/auth/screens/companion_screen.dart';
import 'package:wellcare/modules/auth/screens/condition_screen.dart';
import 'package:wellcare/modules/auth/screens/describe_screen.dart';
import 'package:wellcare/modules/auth/screens/login_signup_screen.dart';
import 'package:wellcare/modules/auth/screens/signin_screen.dart';
import 'package:wellcare/modules/auth/screens/signup_screen.dart';
import 'package:wellcare/modules/auth/screens/user_setup_screen.dart';

class AuthModule extends Module {
  static String get moduleRoute => "/";

  @override
  void routes(r) {
    r.child(SignUpLoginScreen.linkRoute,
        child: (context) => const SignUpLoginScreen());
    r.child(SigninScreen.linkRoute, child: (context) => const SigninScreen());
    r.child(SignupScreen.linkRoute, child: (context) => const SignupScreen());
    r.child(UserSetupScreen.linkRoute,
        child: (context) => const UserSetupScreen());
    r.child(DescribeScreen.linkRoute,
        child: (context) => const DescribeScreen());
    r.child(ConditionScreen.linkRoute,
        child: (context) => const ConditionScreen());
    r.child(AdoptScreen.linkRoute, child: (context) => const AdoptScreen());
    r.child(CompanionScreen.linkRoute,
        child: (context) => const CompanionScreen());
  }
}
