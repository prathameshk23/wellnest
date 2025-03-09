import 'package:flutter_modular/flutter_modular.dart';
import 'package:wellcare/modules/welcome/screens/welcome_screen.dart';

class WelcomeModule extends Module {
  static String get moduleRoute => "/welcome";

  @override
  void routes(r) {
    // r.child(WelcomeScreen.linkRoute, child: (context) => const WelcomeScreen());
    r.child('/', child: (context) => const WelcomeScreen());
  }
}
