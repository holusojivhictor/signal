import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:signal/src/features/common/application/bloc.dart';
import 'package:signal/src/features/common/domain/enums/enums.dart';
import 'package:signal/src/features/common/domain/models/models.dart';

import '../../../../mocks.dart';

class _FakeAppBloc extends Fake implements AppBloc {
  @override
  void add(AppEvent event) {}
}

void main() {
  const appVersion = '1.0.0';
  const defaultPreferences = Preferences(
    appTheme: AppThemeType.dark,
    appLanguage: AppLanguageType.english,
    isFirstInstall: true,
    doubleBackToClose: true,
    themeMode: AutoThemeModeType.on,
  );

  SettingsBloc getBloc({Preferences? preferences}) {
    final settings = preferences ?? defaultPreferences;
    final preferenceService = MockPreferenceService();
    when(() => preferenceService.preferences).thenReturn(settings);
    when(() => preferenceService.autoThemeMode).thenReturn(settings.themeMode);
    when(() => preferenceService.appTheme).thenReturn(settings.appTheme);
    when(() => preferenceService.language).thenReturn(settings.appLanguage);
    when(
      () => preferenceService.isFirstInstall,
    ).thenReturn(settings.isFirstInstall);
    when(
      () => preferenceService.doubleBackToClose,
    ).thenReturn(settings.doubleBackToClose);

    final deviceInfoService = MockDeviceInfoService();
    when(() => deviceInfoService.versionWithBuildNumber).thenReturn(appVersion);
    when(() => deviceInfoService.appName).thenReturn('Signal');

    final appBloc = _FakeAppBloc();

    return SettingsBloc(
      preferenceService,
      deviceInfoService,
      appBloc,
    );
  }

  test('Initial state', () {
    expect(getBloc().state, const SettingsState.init());
  });

  group('Getter', () {
    test('doubleBackToClose returns valid value', () {
      expect(getBloc().doubleBackToClose, defaultPreferences.doubleBackToClose);
    });

    test('isFirstInstall returns valid value', () {
      expect(getBloc().isFirstInstall, defaultPreferences.isFirstInstall);
    });
  });

  blocTest<SettingsBloc, SettingsState>(
    'Init',
    build: getBloc,
    act: (bloc) => bloc.add(SettingsInit()),
    expect: () => <SettingsState>[
      const SettingsState.init().copyWith(
        currentTheme: defaultPreferences.appTheme,
        currentLanguage: defaultPreferences.appLanguage,
        appVersion: appVersion,
        doubleBackToClose: defaultPreferences.doubleBackToClose,
        themeMode: defaultPreferences.themeMode,
      ),
    ],
  );

  blocTest<SettingsBloc, SettingsState>(
    'Settings changed',
    build: getBloc,
    act: (bloc) => bloc
      ..add(SettingsInit())
      ..add(SettingsThemeChanged(newValue: AppThemeType.light))
      ..add(SettingsThemeModeChanged(newValue: AutoThemeModeType.off))
      ..add(
        SettingsBackToCloseChanged(
          newValue: !defaultPreferences.doubleBackToClose,
        ),
      ),
    skip: 3,
    expect: () => <SettingsState>[
      const SettingsState.init().copyWith(
        currentTheme: AppThemeType.light,
        currentLanguage: AppLanguageType.english,
        themeMode: AutoThemeModeType.off,
        appVersion: appVersion,
        doubleBackToClose: !defaultPreferences.doubleBackToClose,
      ),
    ],
  );
}
