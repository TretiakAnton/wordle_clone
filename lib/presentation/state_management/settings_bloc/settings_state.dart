part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsInProgress extends SettingsState {}

class SettingsCompleted extends SettingsState {}

class SettingsFailed extends SettingsState {
  final String? error;

  SettingsFailed(this.error);
}
