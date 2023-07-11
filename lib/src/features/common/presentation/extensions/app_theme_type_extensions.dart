import 'package:flutter/material.dart';
import 'package:signal/src/features/common/domain/enums/enums.dart';
import 'package:signal/src/features/common/presentation/theme.dart';

extension AppThemeTypeExtensions on AppThemeType {
  ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
      ),
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      typography: AppTheme.appMaterialTypography,
      primaryTextTheme: AppTheme.appMaterialLightPrimaryTextTheme,
      textTheme: AppTheme.appMaterialLightTextTheme,
      colorScheme: AppTheme.appMaterialLightColorScheme,
      extensions: const <ThemeExtension<dynamic>>[
        AppThemeExtension(
          baseTextColor: Colors.black,
        ),
      ],
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
      ),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0E2033),
      typography: AppTheme.appMaterialTypography,
      primaryTextTheme: AppTheme.appMaterialDarkPrimaryTextTheme,
      textTheme: AppTheme.appMaterialDarkTextTheme,
      colorScheme: AppTheme.appMaterialDarkColorScheme,
      extensions: const <ThemeExtension<dynamic>>[
        AppThemeExtension(
          baseTextColor: Colors.white,
        ),
      ],
    );
  }

  ThemeData getThemeData() {
    switch (this) {
      case AppThemeType.light:
        return lightTheme();
      case AppThemeType.dark:
        return darkTheme();
    }
  }
}
