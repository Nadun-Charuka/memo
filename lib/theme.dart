import 'package:flutter/material.dart';

class MyAppThemes {
  static const Color lightBackground = Color(0xFFFAF0E6); // Linen
  static const Color lightCard = Color(0xFFFFF5F1); // Seashell
  static const Color primaryPink = Color(0xFFFF6F91); // Blush Pink
  static const Color accentGold = Color(0xFFFAD6A5); // Champagne Gold
  static const Color lavender = Color(0xFFB497BD); // Romantic contrast
  static const Color textDark = Color(0xFF2C2C2C); // Main readable text
  static const Color textMuted = Color(0xFF7E7E7E); // Subtle text

  static const Color darkBackground = Color(0xFF2D2D2D); // Deep gray
  static const Color darkCard = Color(0xFF3A3A3A); // Soft surface
  static const Color darkText = Color(0xFFECECEC); // Bright text

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBackground,
    primaryColor: primaryPink,
    cardTheme: CardTheme(
      color: lightCard,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: lightCard,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryPink,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryPink,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryPink,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightCard,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: accentGold),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryPink, width: 2),
      ),
      labelStyle: TextStyle(color: textMuted),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF1C1B1F), // Deep romantic night
    primaryColor: primaryPink,
    cardTheme: CardTheme(
      color: darkCard,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: darkCard,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryPink.withValues(alpha: 0.6),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF2C2A32),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryPink.withValues(alpha: 0.6),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkCard, // Same as card for input fields
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: accentGold),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryPink, width: 2),
      ),
      labelStyle: TextStyle(color: textMuted),
    ),
  );
}
