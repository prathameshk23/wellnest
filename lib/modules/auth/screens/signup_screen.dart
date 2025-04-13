import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wellcare/modules/auth/auth_module.dart';
import 'package:wellcare/modules/auth/screens/user_setup_screen.dart';
import 'package:wellcare/resources/r.dart';
import 'package:wellcare/store/app_store.dart';
import 'package:wellcare/utils/logger.dart';
import 'package:wellcare/widgets/custom_button.dart';
import 'package:wellcare/widgets/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static String get linkRoute => '/signup/';
  static String get toRoute => "${AuthModule.moduleRoute}signup/";
  // static String get toRoute => linkRoute;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

enum Gender { male, female, other }

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final AppStore store = Modular.get<AppStore>();

  Gender? _gender;

  final supabase = Supabase.instance.client;

  Future<void> signUpNewUser() async {
    try {
      if (_nameController.text.isEmpty ||
          _emailController.text.isEmpty ||
          _usernameController.text.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please fill all the fields...!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        return;
      } else {
        store.name = _nameController.text;
        store.email = _emailController.text;
        store.username = _usernameController.text;
        store.gender = _gender.toString();
        final AuthResponse res = await supabase.auth.signUp(
          email: _emailController.text,
          password: _passwordController.text,
        );

        Fluttertoast.showToast(
          msg: "Signup successful!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        logger.d(res.user?.id);
        store.authId = res.user!.id;
        Modular.to.pushNamed(UserSetupScreen.toRoute);
      }
      Modular.to.pushNamed(UserSetupScreen.toRoute);
    } catch (e) {
      if (e is AuthException) {
        Fluttertoast.showToast(
          msg: e.message,
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Sign Up",
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
                  labelText: "Name",
                  controller: _nameController,
                ),
                const SizedBox(
                  height: 15,
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
                  height: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  labelText: "Username",
                  controller: _usernameController,
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gender",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: R.colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<Gender>(
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>(
                                  (Set<WidgetState> states) {
                                    if (states.contains(WidgetState.selected)) {
                                      return R.colors
                                          .green200; // Change to your desired color
                                    }
                                    return R.colors
                                        .black; // Default color when not selected
                                  },
                                ),
                                value: Gender.male,
                                groupValue: _gender,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                              const Text('Male'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<Gender>(
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>(
                                  (Set<WidgetState> states) {
                                    if (states.contains(WidgetState.selected)) {
                                      return R.colors
                                          .green200; // Change to your desired color
                                    }
                                    return R.colors
                                        .black; // Default color when not selected
                                  },
                                ),
                                value: Gender.female,
                                groupValue: _gender,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                              const Text('Female'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<Gender>(
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>(
                                  (Set<WidgetState> states) {
                                    if (states.contains(WidgetState.selected)) {
                                      return R.colors
                                          .green200; // Change to your desired color
                                    }
                                    return R.colors
                                        .black; // Default color when not selected
                                  },
                                ),
                                value: Gender.other,
                                groupValue: _gender,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                              const Text('Other'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                CustomButton(
                  goTo: () {
                    signUpNewUser();
                  },
                  buttonText: "SIGNUP",
                  buttonWidth: double.infinity,
                  rounded: 100,
                  textStyle: GoogleFonts.inter(
                    color: R.colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
