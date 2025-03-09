import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wellcare/app_module.dart';
import 'package:wellcare/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ScreenUtilInit(
    designSize: const Size(384, 853), // Set your design size
    minTextAdapt: true,
    child: ModularApp(module: AppModule(), child: const AppWidget()),
  ));
}
