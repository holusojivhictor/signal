import 'package:equatable/equatable.dart';
import 'package:signal/src/features/common/domain/enums/enums.dart';

class Preferences extends Equatable {
  const Preferences({
    required this.appTheme,
    required this.appLanguage,
    required this.themeMode,
    required this.isFirstInstall,
    required this.doubleBackToClose,
  });

  final AppThemeType appTheme;
  final AppLanguageType appLanguage;
  final AutoThemeModeType themeMode;
  final bool isFirstInstall;
  final bool doubleBackToClose;

  @override
  List<Object?> get props => <Object?>[
    appTheme,
    appLanguage,
    themeMode,
    isFirstInstall,
    doubleBackToClose,
  ];
}
