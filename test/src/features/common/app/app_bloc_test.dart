import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:signal/src/features/common/application/bloc.dart';
import 'package:signal/src/features/common/domain/enums/enums.dart';
import 'package:signal/src/features/common/domain/models/models.dart';

import '../../../../mocks.dart';

void main() {
  const defaultAppName = 'Signal';
  const defaultLang = AppLanguageType.english;
  const defaultThemeMode = AutoThemeModeType.off;
  const defaultTheme = AppThemeType.dark;

  const defaultPreferences = Preferences(
    appTheme: defaultTheme,
    appLanguage: defaultLang,
    themeMode: defaultThemeMode,
    isFirstInstall: true,
    doubleBackToClose: true,
  );

  AppBloc appBloc({
    String appName = defaultAppName,
    Preferences? preferences,
    bool versionChanged = false,
  }) {
    final settings = preferences ?? defaultPreferences;
    final logger = MockLoggingService();

    final preferenceService = MockPreferenceService();
    when(() => preferenceService.language).thenReturn(settings.appLanguage);
    when(() => preferenceService.autoThemeMode).thenReturn(settings.themeMode);
    when(() => preferenceService.appTheme).thenReturn(settings.appTheme);
    when(
      () => preferenceService.isFirstInstall,
    ).thenReturn(settings.isFirstInstall);
    when(() => preferenceService.preferences).thenReturn(settings);

    final deviceInfoService = MockDeviceInfoService();
    when(() => deviceInfoService.appName).thenReturn(appName);
    when(() => deviceInfoService.versionChanged).thenReturn(versionChanged);

    return AppBloc(
      logger,
      preferenceService,
      deviceInfoService,
    );
  }

  test('Initial state', () {
    expect(appBloc().state, const AppState.init());
  });

  blocTest<AppBloc, AppState>(
    'emits init state',
    build: appBloc,
    act: (bloc) => bloc.add(AppInit()),
    expect: () => <AppState>[
      const AppState.init().copyWith(
        appTitle: defaultAppName,
        theme: defaultTheme,
        autoThemeMode: defaultThemeMode,
        initialized: true,
        firstInstall: defaultPreferences.isFirstInstall,
        versionChanged: false,
      ),
    ],
  );

  group('Theme changed', () {
    blocTest<AppBloc, AppState>(
      'updates the theme mode in AppState',
      build: appBloc,
      act: (bloc) => bloc
        ..add(AppInit())
        ..add(AppThemeModeChanged(newValue: AutoThemeModeType.on)),
      skip: 1,
      expect: () => <AppState>[
        const AppState.init().copyWith(
          appTitle: defaultAppName,
          theme: defaultPreferences.appTheme,
          autoThemeMode: AutoThemeModeType.on,
          initialized: true,
          firstInstall: defaultPreferences.isFirstInstall,
          versionChanged: false,
        ),
      ],
    );

    blocTest<AppBloc, AppState>(
      'updates the theme in AppState',
      build: appBloc,
      act: (bloc) => bloc
        ..add(AppInit())
        ..add(AppThemeChanged(newValue: AppThemeType.light)),
      skip: 1,
      expect: () => <AppState>[
        const AppState.init().copyWith(
          appTitle: defaultAppName,
          theme: AppThemeType.light,
          autoThemeMode: defaultThemeMode,
          initialized: true,
          firstInstall: defaultPreferences.isFirstInstall,
          versionChanged: false,
        ),
      ],
    );
  });
}
