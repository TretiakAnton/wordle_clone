part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsInProgress extends SettingsState {}

class SettingsColorThemeChanged extends SettingsState {
  final ThemeMode themeMode;

  SettingsColorThemeChanged({required this.themeMode});
}

class SettingsCompleted extends SettingsState {}

class SettingsFailed extends SettingsState {
  final String? error;

  SettingsFailed(this.error);
}
