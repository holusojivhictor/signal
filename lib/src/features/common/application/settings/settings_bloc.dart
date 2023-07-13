import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signal/src/features/common/application/bloc.dart';
import 'package:signal/src/features/common/domain/enums/enums.dart';
import 'package:signal/src/features/common/infrastructure/infrastructure.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(
    this._preferenceService,
    this._deviceInfoService,
    this._appBloc,
  ) : super(const SettingsState.init()) {
    on<SettingsInit>(_onInit);
    on<SettingsThemeChanged>(_onThemeChanged);
    on<SettingsLanguageChanged>(_onLanguageChanged);
    on<SettingsBackToCloseChanged>(_onDoubleBackToCloseChanged);
    on<SettingsThemeModeChanged>(_onAutoThemeModeTypeChanged);
  }

  final PreferenceService _preferenceService;
  final DeviceInfoService _deviceInfoService;
  final AppBloc _appBloc;

  void _onInit(SettingsInit event, Emitter<SettingsState> emit) {
    final preferences = _preferenceService.preferences;

    emit(
      const SettingsState.init().copyWith(
        themeMode: preferences.themeMode,
        currentTheme: preferences.appTheme,
        currentLanguage: preferences.appLanguage,
        appVersion: _deviceInfoService.versionWithBuildNumber,
        doubleBackToClose: preferences.doubleBackToClose,
      ),
    );
  }

  void _onThemeChanged(
    SettingsThemeChanged event,
    Emitter<SettingsState> emit,
  ) {
    if (event.newValue == _preferenceService.appTheme) {
      return emit(state);
    }
    _preferenceService.appTheme = event.newValue;
    _appBloc.add(AppThemeChanged(newValue: event.newValue));
    emit(state.copyWith(currentTheme: event.newValue));
  }

  void _onLanguageChanged(
    SettingsLanguageChanged event,
    Emitter<SettingsState> emit,
  ) {
    if (event.newValue == _preferenceService.language) {
      return emit(state);
    }
    _preferenceService.language = event.newValue;
    _appBloc.add(AppLanguageChanged(newValue: event.newValue));
    emit(state.copyWith(currentLanguage: event.newValue));
  }

  void _onDoubleBackToCloseChanged(
    SettingsBackToCloseChanged event,
    Emitter<SettingsState> emit,
  ) {
    _preferenceService.doubleBackToClose = event.newValue;
    emit(state.copyWith(doubleBackToClose: event.newValue));
  }

  void _onAutoThemeModeTypeChanged(
    SettingsThemeModeChanged event,
    Emitter<SettingsState> emit,
  ) {
    if (event.newValue == _preferenceService.autoThemeMode) {
      return emit(state);
    }
    _preferenceService.autoThemeMode = event.newValue;
    _appBloc.add(AppThemeModeChanged(newValue: event.newValue));
    emit(state.copyWith(themeMode: event.newValue));
  }

  bool get doubleBackToClose => _preferenceService.doubleBackToClose;

  bool get isFirstInstall => _preferenceService.isFirstInstall;
}
