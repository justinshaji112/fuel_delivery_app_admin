import 'package:flutter/material.dart';
import 'package:fuel_delivary_app_admin/theme/color_scheme.dart';
import 'package:fuel_delivary_app_admin/theme/custom/text_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    colorScheme: AppColorScheme.lightColorScheme,
    useMaterial3: true,
    fontFamily: GoogleFonts.poppins().fontFamily,
    textTheme: AppTextTheme.textTheme,
    




  );
}
