import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wellcare/modules/auth/screens/login_signup_screen.dart';
import 'package:wellcare/store/app_store.dart';
import 'package:wellcare/widgets/custom_button.dart';

import '../../../resources/r.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  // Dummy user data — you can replace this with dynamic data
  final supabase = Supabase.instance.client;
  final AppStore store = Modular.get<AppStore>();
  final String username = 'healthy_mind_92';
  final String name = 'Aarav Mehta';
  final String email = 'aarav@example.com';
  final String wellnessGoal = 'Stay active and eat balanced meals';
  final String motivation = 'To feel more energetic and improve mental clarity';

  Future<void> signOut() async {
    await supabase.auth.signOut();
    Modular.to
        .pushNamedAndRemoveUntil(SignUpLoginScreen.toRoute, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.white,
      appBar: AppBar(
        title: Text("Welcome ${store.user.name}"),
        automaticallyImplyLeading: false,
        backgroundColor: R.colors.bgPrimary,
        foregroundColor: R.colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Card(
              color: R.colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabelValue('Username', store.user.username),
                    _buildLabelValue('Name', store.user.name),
                    _buildLabelValue('Email', store.user.email),
                    _buildGoalsSection(
                        'Wellness Goals', store.user.wellnessGoals),
                    Spacer(),
                    Center(
                      child: CustomButton(
                        buttonWidth: double.infinity,
                        buttonText: "Sign Out",
                        rounded: 100,
                        textStyle: GoogleFonts.inter(
                          fontSize: 20,
                          color: R.colors.white,
                        ),
                        goTo: () {
                          signOut();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabelValue(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsSection(String label, List<String> goals) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: goals
                .map(
                  (goal) => Chip(
                    label: Text(goal),
                    backgroundColor: R.colors.bgPrimary,
                    labelStyle: TextStyle(color: R.colors.black),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMotivationLevel(String label, String motivationLevel) {
    final int level = int.tryParse(motivationLevel) ?? 0;
    final double percent = (level.clamp(0, 10)) / 10;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            color: Colors.teal,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: percent,
                backgroundColor: Colors.teal.shade100,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                minHeight: 10,
              ),
            ),
            SizedBox(width: 10),
            Text(
              '$level/10',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
