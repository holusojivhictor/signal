part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class AppInit extends AppEvent {
  @override
  List<Object?> get props => <Object?>[];
}

class AppThemeChanged extends AppEvent {
  AppThemeChanged({required this.newValue});

  final AppThemeType newValue;

  @override
  List<Object?> get props => <Object?>[newValue];
}

class AppThemeModeChanged extends AppEvent {
  AppThemeModeChanged({required this.newValue});

  final AutoThemeModeType newValue;

  @override
  List<Object?> get props => <Object?>[newValue];
}

class AppLanguageChanged extends AppEvent {
  AppLanguageChanged({required this.newValue});

  final AppLanguageType newValue;

  @override
  List<Object?> get props => <Object?>[newValue];
}
