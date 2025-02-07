
import 'package:flutter/material.dart';
import 'package:fuel_delivary_app_admin/theme/theme.dart';

import 'package:fuel_delivary_app_admin/view/pages/home.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:fuel_delivary_app_admin/firebase_options.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AdminDashboardScreen(),
    );
  }
}


