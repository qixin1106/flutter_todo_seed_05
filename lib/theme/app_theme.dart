import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTheme {
  // Light Theme Colors
  static const Color _lightPrimaryColor = Color(0xFF6366F1);
  static const Color _lightSecondaryColor = Color(0xFF8B5CF6);
  static const Color _lightBackgroundColor = Color(0xFFF8FAFC);
  static const Color _lightSurfaceColor = Colors.white;
  static const Color _lightTextColor = Color(0xFF1E293B);
  static const Color _lightHintColor = Color(0xFF64748B);
  static const Color _lightDividerColor = Color(0xFFE2E8F0);
  static const Color _lightErrorColor = Color(0xFFEF4444);

  // Dark Theme Colors
  static const Color _darkPrimaryColor = Color(0xFF818CF8);
  static const Color _darkSecondaryColor = Color(0xFFA78BFA);
  static const Color _darkBackgroundColor = Color(0xFF0F172A);
  static const Color _darkSurfaceColor = Color(0xFF1E293B);
  static const Color _darkTextColor = Color(0xFFF1F5F9);
  static const Color _darkHintColor = Color(0xFF94A3B8);
  static const Color _darkDividerColor = Color(0xFF334155);
  static const Color _darkErrorColor = Color(0xFFF87171);

  // Light Theme
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _lightPrimaryColor,
          brightness: Brightness.light,
          primary: _lightPrimaryColor,
          secondary: _lightSecondaryColor,
          background: _lightBackgroundColor,
          surface: _lightSurfaceColor,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onBackground: _lightTextColor,
          onSurface: _lightTextColor,
          error: _lightErrorColor,
        ),
        scaffoldBackgroundColor: _lightBackgroundColor,
        cardColor: _lightSurfaceColor,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: _lightTextColor),
          bodyMedium: TextStyle(color: _lightTextColor),
          bodySmall: TextStyle(color: _lightHintColor),
          titleLarge: TextStyle(color: _lightTextColor, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(color: _lightTextColor, fontWeight: FontWeight.w600),
          titleSmall: TextStyle(color: _lightTextColor, fontWeight: FontWeight.w500),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: _lightPrimaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: _lightPrimaryColor,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _lightPrimaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: _lightDividerColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: _lightDividerColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: _lightPrimaryColor, width: 2),
          ),
          hintStyle: TextStyle(color: _lightHintColor),
        ),
        dividerTheme: DividerThemeData(
          color: _lightDividerColor,
          thickness: 1,
        ),
      );

  // Dark Theme
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _darkPrimaryColor,
          brightness: Brightness.dark,
          primary: _darkPrimaryColor,
          secondary: _darkSecondaryColor,
          background: _darkBackgroundColor,
          surface: _darkSurfaceColor,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onBackground: _darkTextColor,
          onSurface: _darkTextColor,
          error: _darkErrorColor,
        ),
        scaffoldBackgroundColor: _darkBackgroundColor,
        cardColor: _darkSurfaceColor,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: _darkTextColor),
          bodyMedium: TextStyle(color: _darkTextColor),
          bodySmall: TextStyle(color: _darkHintColor),
          titleLarge: TextStyle(color: _darkTextColor, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(color: _darkTextColor, fontWeight: FontWeight.w600),
          titleSmall: TextStyle(color: _darkTextColor, fontWeight: FontWeight.w500),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: _darkPrimaryColor,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: _darkPrimaryColor,
          foregroundColor: Colors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _darkPrimaryColor,
            foregroundColor: Colors.black,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: _darkDividerColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: _darkDividerColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: _darkPrimaryColor, width: 2),
          ),
          hintStyle: TextStyle(color: _darkHintColor),
        ),
        dividerTheme: DividerThemeData(
          color: _darkDividerColor,
          thickness: 1,
        ),
      );

  // Toggle Theme
  static void toggleTheme() {
    Get.changeThemeMode(
      Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
    );
  }
}