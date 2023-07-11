part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.themeMode,
    required this.currentTheme,
    required this.currentLanguage,
    required this.appVersion,
    required this.doubleBackToClose,
  });

  const SettingsState.init()
      : themeMode = AutoThemeModeType.off,
        currentTheme = AppThemeType.dark,
        currentLanguage = AppLanguageType.english,
        appVersion = '1.0',
        doubleBackToClose = true;

  SettingsState copyWith({
    AutoThemeModeType? themeMode,
    AppThemeType? currentTheme,
    AppLanguageType? currentLanguage,
    String? appVersion,
    bool? doubleBackToClose,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      currentTheme: currentTheme ?? this.currentTheme,
      currentLanguage: currentLanguage ?? this.currentLanguage,
      appVersion: appVersion ?? this.appVersion,
      doubleBackToClose: doubleBackToClose ?? this.doubleBackToClose,
    );
  }

  final AutoThemeModeType themeMode;
  final AppThemeType currentTheme;
  final AppLanguageType currentLanguage;
  final String appVersion;
  final bool doubleBackToClose;

  @override
  List<Object?> get props => [
    themeMode,
    currentTheme,
    currentLanguage,
    appVersion,
    doubleBackToClose,
  ];
}
