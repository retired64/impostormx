import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const bgTop = Color(0xFF0F2027);
  static const bgBottom = Color(0xFF203A43);
  static const surface = Color(0x1FFFFFFF);
  static const accent = Color(0xFF00F5D4); 
  static const error = Color(0xFFFF4B6E);
  static const text = Color(0xFFEEEEEE);
  static const textDim = Color(0xFFAAAAAA);
  static const cardHidden = Color(0xFF2C3E50);
}

class AppTheme {
  static TextStyle heading(double size) => GoogleFonts.fredoka(fontSize: size, fontWeight: FontWeight.bold, color: AppColors.text);
  static TextStyle body(double size) => GoogleFonts.inter(fontSize: size, color: AppColors.textDim);
  
  static ThemeData get theme => ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.bgTop,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }
    ),
  );
}
