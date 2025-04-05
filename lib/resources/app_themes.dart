import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFFF8E1),
    primaryColor: const Color(0xFF6D4C41), // Warm brown
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF6D4C41),
      secondary: const Color(0xFFFFA726),
      surface: const Color(0xFFFFF8E1),
      background: const Color(0xFFFFF8E1),
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: const Color(0xFF4E342E),
      onBackground: const Color(0xFF4E342E),
      tertiary: Colors.brown.shade200,
      onTertiary: Colors.brown.shade100,
      inversePrimary: Colors.blueGrey.shade100,
    ),

    // Responsive Text Theme
    textTheme: TextTheme(
      displayLarge: TextStyle(
          color: const Color(0xFF4E342E),
          fontSize: 25.sp,
          fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(
        color: const Color(0xFF5D4037),
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
          color: const Color(0xFF5D4037),
          fontSize: 16.sp,
          fontWeight: FontWeight.bold),
      bodySmall: TextStyle(
        // color: const Color(0xFF5D4037),
        color: Colors.grey.shade600,
        fontSize: 14.sp,
      ),
      titleSmall: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          height: 1.1.h),
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      elevation: 2,
      backgroundColor: Colors.white54,
      iconTheme: IconThemeData(
          color: const Color(0xFF4E342E), size: 20.w), // Responsive icon size
      titleTextStyle: TextStyle(
          color: const Color(0xFF4E342E),
          fontSize: 20.sp,
          fontWeight: FontWeight.bold),
    ),

    // Button Theme (for elevated buttons)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6D4C41),
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r), // Responsive border radius
        ),
      ),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 5,
      backgroundColor: Colors.white54,
      selectedItemColor: const Color(0xFF6D4C41),
      unselectedItemColor: const Color(0xFFA28F89),
      selectedIconTheme: IconThemeData(size: 22.w), // Responsive icon size
      unselectedIconTheme: IconThemeData(size: 20.w),
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    primaryColor: const Color(0xFF80CBC4),
    colorScheme: ColorScheme.dark(
        primary: const Color(0xFF80CBC4),
        secondary: const Color(0xFFFFD54F),
        surface: const Color(0xFF1E1E1E),
        background: const Color(0xFF121212),
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: const Color(0xFFCFD8DC),
        onBackground: const Color(0xFFCFD8DC),
        tertiary: Colors.grey.shade900,
        onTertiary: Colors.grey.shade800,
        tertiaryContainer: Colors.grey.shade700,
        inversePrimary: Colors.blueGrey.shade900),
    textTheme: TextTheme(
      displayLarge: TextStyle(
          color: const Color(0xFFCFD8DC),
          fontSize: 25.sp,
          fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: const Color(0xFFB0BEC5), fontSize: 22.sp),
      bodyMedium: TextStyle(
        color: const Color(0xFFB0BEC5),
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        color: const Color(0xFFB0BEC5),
        fontSize: 14.sp,
      ),
      titleSmall: TextStyle(
          color: const Color(0xFFB0BEC5),
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          height: 1.1.h),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1E1E1E),
      iconTheme: IconThemeData(color: const Color(0xFFCFD8DC), size: 20.w),
      titleTextStyle: TextStyle(
          color: const Color(0xFFCFD8DC),
          fontSize: 20.sp,
          fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF80CBC4),
        foregroundColor: Colors.black,
        textStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 6,
      backgroundColor: const Color(0xFF1E1E1E),
      selectedItemColor: const Color(0xFF80CBC4),
      unselectedItemColor: const Color(0xFF757575),
      selectedIconTheme: IconThemeData(size: 22.w),
      unselectedIconTheme: IconThemeData(size: 20.w),
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
  );
}
