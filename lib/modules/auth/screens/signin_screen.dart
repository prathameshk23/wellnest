import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wellcare/modules/auth/screens/signup_screen.dart';
import 'package:wellcare/modules/dashboard/screens/dashboard_screen.dart';
import 'package:wellcare/resources/r.dart';
import 'package:wellcare/utils/logger.dart';
import 'package:wellcare/widgets/custom_button.dart';
import 'package:wellcare/widgets/custom_textfield.dart';
import '../../../models/user.dart';
import '../services/auth_service.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  static String get linkRoute => '/singin/';
  static String get toRoute => linkRoute;

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

final supabase = Supabase.instance.client;

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthServices apiServices = AuthServices();

  @override
  void initState() {
    super.initState();
  }

  Future<void> signInUser() async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
          email: _emailController.text, password: _passwordController.text);

      Fluttertoast.showToast(
        msg: "Signup successful!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      logger.d(res.user?.id);
      var response = await apiServices.getUser(res.user!.id);
      Modular.to.pushNamed(DashboardScreen.toRoute);
    } catch (e) {
      if (e is AuthException) {
        Fluttertoast.showToast(
          msg: "jsdbfjhiebf",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        Fluttertoast.showToast(
          msg: "An unexpected error occurred",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Sign In",
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            CustomTextField(
              labelText: "Email",
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              labelText: "Password",
              controller: _passwordController,
              obscureText: true,
            ),
            const SizedBox(
              height: 60,
            ),
            CustomButton(
              goTo: () {
                signInUser();
              },
              buttonText: "SIGNIN",
              buttonWidth: double.infinity,
              rounded: 100,
              textStyle: GoogleFonts.inter(
                color: R.colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Modular.to.pushNamed(SignupScreen.toRoute);
                  },
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: R.colors.green200,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
