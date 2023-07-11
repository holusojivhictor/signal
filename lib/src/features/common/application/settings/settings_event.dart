part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class SettingsInit extends SettingsEvent {
  @override
  List<Object?> get props => <Object?>[];
}

class SettingsThemeChanged extends SettingsEvent {
  SettingsThemeChanged({required this.newValue});

  final AppThemeType newValue;

  @override
  List<Object?> get props => <Object?>[newValue];
}

class SettingsLanguageChanged extends SettingsEvent {
  SettingsLanguageChanged({required this.newValue});

  final AppLanguageType newValue;

  @override
  List<Object?> get props => <Object?>[newValue];
}

class SettingsThemeModeChanged extends SettingsEvent {
  SettingsThemeModeChanged({required this.newValue});

  final AutoThemeModeType newValue;

  @override
  List<Object?> get props => <Object?>[newValue];
}

class SettingsBackToCloseChanged extends SettingsEvent {
  SettingsBackToCloseChanged({required this.newValue});

  final bool newValue;

  @override
  List<Object?> get props => <Object?>[newValue];
}
