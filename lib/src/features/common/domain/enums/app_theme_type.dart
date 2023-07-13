enum AppThemeType {
  light,
  dark;

  bool get darkMode {
    switch(this) {
      case AppThemeType.dark:
        return true;
      case AppThemeType.light:
        return false;
    }
  }

  static AppThemeType translate({required bool value}) {
    switch (value) {
      case false:
        return AppThemeType.light;
      case true:
        return AppThemeType.dark;
    }
  }
}
