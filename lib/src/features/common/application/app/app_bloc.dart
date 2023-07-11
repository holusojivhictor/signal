import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signal/src/features/common/domain/enums/enums.dart';
import 'package:signal/src/features/common/domain/models/models.dart';
import 'package:signal/src/features/common/infrastructure/infrastructure.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(
    this._logger,
    this._preferenceService,
    this._deviceInfoService,
  ) : super(const AppState.init()) {
    on<AppInit>(_onInit);
    on<AppThemeChanged>(_onThemeChanged);
    on<AppThemeModeChanged>(_onThemeModeChanged);
    on<AppLanguageChanged>(_onLanguageChanged);
  }

  final LoggingService _logger;
  final PreferenceService _preferenceService;
  final DeviceInfoService _deviceInfoService;

  AppState loadedState(
    AppThemeType theme,
    AutoThemeModeType autoThemeMode, {
    bool isInitialized = true,
  }) {
    return const AppState.init().copyWith(
      appTitle: _deviceInfoService.appName,
      initialized: isInitialized,
      theme: theme,
      autoThemeMode: autoThemeMode,
      firstInstall: _preferenceService.isFirstInstall,
      versionChanged: _deviceInfoService.versionChanged,
    );
  }

  void _logInfo() {
    _logger.info(
        runtimeType,
        '_init: Is first install = ${_preferenceService.isFirstInstall}. '
        'Refreshing settings');
  }

  void _onInit(AppInit event, Emitter<AppState> emit) {
    _logger.info(runtimeType, '_init: Initializing all...');

    final preferences = _preferenceService.preferences;
    _logInfo();

    emit(loadedState(preferences.appTheme, preferences.themeMode));
  }

  void _onThemeChanged(AppThemeChanged event, Emitter<AppState> emit) {
    _logInfo();

    emit(loadedState(event.newValue, _preferenceService.autoThemeMode));
  }

  void _onThemeModeChanged(AppThemeModeChanged event, Emitter<AppState> emit) {
    _logInfo();

    emit(loadedState(_preferenceService.appTheme, event.newValue));
  }

  void _onLanguageChanged(AppLanguageChanged event, Emitter<AppState> emit) {
    _logger.info(runtimeType, '_init: Language changed, reloading blocs');

    final preferences = _preferenceService.preferences;
    _logInfo();

    emit(loadedState(preferences.appTheme, preferences.themeMode));
  }
}
