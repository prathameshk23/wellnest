import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellcare/modules/auth/auth_module.dart';
import 'package:wellcare/modules/auth/screens/companion_screen.dart';
import 'package:wellcare/resources/r.dart';
import 'package:wellcare/widgets/custom_button.dart';

import '../../../store/app_store.dart';

class AdoptScreen extends StatefulWidget {
  const AdoptScreen({super.key});

  static String get linkRoute => '/adopt/';
  static String get toRoute => "${AuthModule.moduleRoute}adopt/";

  @override
  State<AdoptScreen> createState() => _AdoptScreenState();
}

class _AdoptScreenState extends State<AdoptScreen> {
  final AppStore store = Modular.get<AppStore>();
  final TextEditingController _pandaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: R.colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left_outlined,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: R.colors.bgPrimary,
        foregroundColor: R.colors.black,
      ),
      body: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            bottom: 0,
            child: Transform.scale(
              scale: 1.2,
              child: SvgPicture.asset(
                R.assets.vector,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 80,
                      height: 4,
                      decoration: BoxDecoration(
                        color: R.colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: R.colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      width: 80,
                      height: 4,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: R.colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      width: 80,
                      height: 4,
                    ),
                  ],
                ),
                Center(child: Image.asset(R.assets.adoptPanda)),
                Text(
                  "You adopted a panda!",
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: R.colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "What will you call them?",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: R.colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: _pandaController,
                    cursorColor: R.colors.green200,
                    decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: R.colors.grey500,
                      ),
                      fillColor: R.colors.grey100,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(9),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                CustomButton(
                  goTo: () {
                    store.panda = _pandaController.text;
                    Modular.to.pushNamed(CompanionScreen.toRoute);
                  },
                  elevation: 0,
                  buttonColor: R.colors.bgPrimary,
                  buttonText: "Continue",
                  buttonWidth: double.infinity,
                  rounded: 100,
                  textStyle: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: R.colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
