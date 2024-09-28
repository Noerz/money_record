import 'package:flutter/material.dart';
import 'package:catatan_keuangan/app/core/theme/app_color.dart';
import 'package:catatan_keuangan/app/core/theme/app_string.dart';
import 'package:catatan_keuangan/app/core/theme/app_style.dart';

class AppTheme {
  AppTheme._();

  // Light Theme Configuration
  static final ThemeData lightAppTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    fontFamily: AppString.appFont,
    appBarTheme: _lightAppBarTheme(),
    dialogTheme: _dialogTheme(),
    inputDecorationTheme: _inputDecorationTheme(),
    elevatedButtonTheme: _lightElevatedButtonTheme(),
    floatingActionButtonTheme: _lightFloatingActionButtonTheme(),
    textButtonTheme: _lightTextButtonTheme(),
    timePickerTheme: _timePickerTheme(),
    bottomSheetTheme: _bottomSheetTheme(),
    colorScheme: _lightColorScheme(),
    scaffoldBackgroundColor: Colors.white,
  );

  // Dark Theme Configuration
  static final ThemeData darkAppTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.dark,
    fontFamily: AppString.appFont,
    appBarTheme: _darkAppBarTheme(),
    dialogTheme: _dialogTheme(),
    inputDecorationTheme: _inputDecorationTheme(),
    elevatedButtonTheme: _darkElevatedButtonTheme(),
    floatingActionButtonTheme: _darkFloatingActionButtonTheme(),
    textButtonTheme: _darkTextButtonTheme(),
    timePickerTheme: _darkTimePickerTheme(),
    bottomSheetTheme: _bottomSheetTheme(),
    colorScheme: _darkColorScheme(),
    scaffoldBackgroundColor: AppColors.darkGrey,
  );

  // Light Theme Components
  static AppBarTheme _lightAppBarTheme() {
    return AppBarTheme(
      backgroundColor: AppColors.lightBlue,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 20,
      ),
    );
  }

  static ElevatedButtonThemeData _lightElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  static FloatingActionButtonThemeData _lightFloatingActionButtonTheme() {
    return const FloatingActionButtonThemeData(
      backgroundColor: AppColors.red,
    );
  }

  static TextButtonThemeData _lightTextButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: AppColors.grey),
        ),
      ),
    );
  }

  static ColorScheme _lightColorScheme() {
    return const ColorScheme.light(
      primary: AppColors.lightBlue,
      secondary: AppColors.green,
      error: AppColors.red,
      background: Colors.white,
      surface: AppColors.whiteShade,
    );
  }

  // Dark Theme Components
  static AppBarTheme _darkAppBarTheme() {
    return AppBarTheme(
      backgroundColor: AppColors.darkGrey,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 20,
      ),
    );
  }

  static ElevatedButtonThemeData _darkElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkGreen,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  static FloatingActionButtonThemeData _darkFloatingActionButtonTheme() {
    return const FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
    );
  }

  static TextButtonThemeData _darkTextButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.white38),
        ),
      ),
    );
  }

  static ColorScheme _darkColorScheme() {
    return const ColorScheme.dark(
      primary: AppColors.darkGrey,
      secondary: AppColors.darkGreen,
      error: AppColors.red,
      background: AppColors.black,
      surface: AppColors.blackShade,
    );
  }

  // Common Components
  static DialogTheme _dialogTheme() {
    return const DialogTheme(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.red, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme() {
    return const InputDecorationTheme(
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      border: inputBorder,
    );
  }

  static TimePickerThemeData _timePickerTheme() {
    return TimePickerThemeData(
      dialHandColor: AppColors.red,
      hourMinuteColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.red;
        }
        return Colors.black12;
      }),
      hourMinuteTextColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.black54;
        }
        return Colors.grey;
      }),
      dayPeriodBorderSide: const BorderSide(color: Colors.grey),
      dayPeriodShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      dayPeriodColor: Colors.transparent,
      dayPeriodTextColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.red;
        }
        return Colors.black12;
      }),
      hourMinuteShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.black12),
      ),
    );
  }

  static TimePickerThemeData _darkTimePickerTheme() {
    return TimePickerThemeData(
      dialHandColor: AppColors.darkGreen,
      hourMinuteColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.red;
        }
        return Colors.black26;
      }),
      hourMinuteTextColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.white;
        }
        return Colors.white38;
      }),
      dayPeriodBorderSide: const BorderSide(color: Colors.white38),
      dayPeriodShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      dayPeriodColor: Colors.transparent,
      dayPeriodTextColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.red;
        }
        return Colors.white38;
      }),
      hourMinuteShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.white38),
      ),
    );
  }

  static BottomSheetThemeData _bottomSheetTheme() {
    return const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }
}
