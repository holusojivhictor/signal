import 'package:collection/collection.dart' show IterableExtension;
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signal/src/features/common/domain/constants.dart';
import 'package:signal/src/features/common/domain/enums/enums.dart';
import 'package:signal/src/features/common/domain/models/models.dart';
import 'package:signal/src/features/common/infrastructure/infrastructure.dart';

class PreferenceService {
  PreferenceService(
    this._logger, {
    FlutterSecureStorage? secureStorage,
  }) : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final _appThemeKey = 'AppTheme';
  final _appLanguageKey = 'AppLanguageKey';
  final _isFirstInstallKey = 'FirstInstall';
  final _doubleBackToCloseKey = 'DoubleBackToCloseKey';
  final _autoThemeModeKey = 'AutoThemeModeKey';
  final String _usernameKey = 'Username';
  final String _passwordKey = 'Password';

  bool _initialized = false;

  late SharedPreferences _prefs;
  final LoggingService _logger;
  final FlutterSecureStorage _secureStorage;

  AppThemeType get appTheme => AppThemeType.values[_prefs.getInt(_appThemeKey)!];

  set appTheme(AppThemeType theme) => _prefs.setInt(_appThemeKey, theme.index);

  AppLanguageType get language => AppLanguageType.values[_prefs.getInt(_appLanguageKey)!];

  set language(AppLanguageType lang) => _prefs.setInt(_appLanguageKey, lang.index);

  bool get isFirstInstall => _prefs.getBool(_isFirstInstallKey)!;

  set isFirstInstall(bool itIs) => _prefs.setBool(_isFirstInstallKey, itIs);

  bool get doubleBackToClose => _prefs.getBool(_doubleBackToCloseKey)!;

  set doubleBackToClose(bool value) => _prefs.setBool(_doubleBackToCloseKey, value);

  AutoThemeModeType get autoThemeMode => AutoThemeModeType.values[_prefs.getInt(_autoThemeModeKey)!];

  set autoThemeMode(AutoThemeModeType themeMode) => _prefs.setInt(_autoThemeModeKey, themeMode.index);

  Future<bool> get loggedIn async => await username != null;

  Future<String?> get username async => _secureStorage.read(key: _usernameKey);

  Future<String?> get password async => _secureStorage.read(key: _passwordKey);

  Preferences get preferences => Preferences(
    appTheme: appTheme,
    appLanguage: language,
    isFirstInstall: isFirstInstall,
    doubleBackToClose: doubleBackToClose,
    themeMode: autoThemeMode,
  );

  Future<void> init() async {
    if (_initialized) {
      _logger.info(runtimeType, 'Settings are already initialized!');
      return;
    }

    _logger.info(
      runtimeType,
      'Initializing settings...Getting shared preferences instance...',
    );

    _prefs = await SharedPreferences.getInstance();

    if (_prefs.get(_isFirstInstallKey) == null) {
      _logger.info(runtimeType, 'This is the first install of the app');
      isFirstInstall = true;
    } else {
      isFirstInstall = false;
    }

    if (_prefs.get(_appThemeKey) == null) {
      _logger.info(runtimeType, 'Setting dart as the default theme');
      appTheme = AppThemeType.dark;
    }

    if (_prefs.get(_appLanguageKey) == null) {
      language = await _getDefaultLangToUse();
    }

    if (_prefs.get(_doubleBackToCloseKey) == null) {
      _logger.info(
        runtimeType,
        'Double back to close will be set to its default (true)',
      );
      doubleBackToClose = true;
    }

    if (_prefs.get(_autoThemeModeKey) == null) {
      _logger.info(runtimeType, 'Auto theme mode set to false as default');
      autoThemeMode = AutoThemeModeType.off;
    }

    _initialized = true;
    _logger.info(runtimeType, 'Settings were initialized successfully');
  }

  Future<AppLanguageType> _getDefaultLangToUse() async {
    try {
      _logger.info(
        runtimeType,
        '_getDefaultLangToUse: Trying to retrieve device lang...',
      );
      final deviceLocale = await Devicelocale.currentAsLocale;
      if (deviceLocale == null) {
        _logger.warning(
          runtimeType,
          "_getDefaultLangToUse: Couldn't retrieve the device locale, defaulting to english",
        );
        return AppLanguageType.english;
      }

      final appLang = Constants.languagesMap.entries.firstWhereOrNull(
        (val) => val.value.code == deviceLocale.languageCode,
      );
      if (appLang == null) {
        _logger.info(
          runtimeType,
          "_getDefaultLangToUse: Couldn't find an appropriate app language for = ${deviceLocale.languageCode}_${deviceLocale.countryCode}, defaulting to english",
        );
        return AppLanguageType.english;
      }

      _logger.info(
        runtimeType,
        '_getDefaultLangToUse: Found an appropriate language to use for = ${deviceLocale.languageCode}_${deviceLocale.countryCode}, that is = ${appLang.key}',
      );
      return appLang.key;
    } catch (e, s) {
      _logger.error(runtimeType, '_getDefaultLangToUse: Unknown error occurred', e, s);
      return AppLanguageType.english;
    }
  }

  /// Handle auth
  Future<void> setAuth({
    required String username,
    required String password,
  }) async {
    const androidOptions = AndroidOptions(resetOnError: true);
    try {
      await _secureStorage.write(
        key: _usernameKey,
        value: username,
        aOptions: androidOptions,
      );
      await _secureStorage.write(
        key: _passwordKey,
        value: password,
        aOptions: androidOptions,
      );
    } catch (_) {
      try {
        await _secureStorage.deleteAll(
          aOptions: androidOptions,
        );
      } catch (_) {
        _logger.error(runtimeType, 'unknown');
      }

      rethrow;
    }
  }

  Future<void> removeAuth() async {
    await _secureStorage.delete(key: _usernameKey);
    await _secureStorage.delete(key: _passwordKey);
  }
}
