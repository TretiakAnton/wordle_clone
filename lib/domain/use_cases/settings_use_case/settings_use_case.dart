import 'package:flutter/material.dart';
import 'package:wordle_clone/data/repository/settings_repository.dart';
import 'package:wordle_clone/presentation/state_management/settings_bloc/settings_cubit.dart';

class SettingsUseCase {
  final SettingsRepository _repository = SettingsRepository();

  // final AuthTranslator _translator = AuthTranslator();
  Locale? _wordLocale;
  List<Locale>? _availableWordLocales;
  ThemeMode? _theme;

  Locale get wordLocale {
    if (_wordLocale == null) {
      _loadSelectedWordsLanguage();
    }
    return _wordLocale!;
  }

  List<Locale> get availableWordLocales {
    if (_availableWordLocales == null) {
      _loadAvailableWordLocales();
    }
    return _availableWordLocales!;
  }

  ThemeMode get theme {
    if (_theme == null) {
      _loadTheme();
    }
    return _theme!;
  }

  SettingsState _loadSelectedWordsLanguage() {
    SettingsState result = SettingsInitial();
    final response = _repository.getSelectedWordsLanguage();
    response.fold((failure) async {
      return result = SettingsFailed(failure.errorMessage);
    }, (locale) async {
      _wordLocale = locale;
      result = SettingsCompleted();
    });
    return result;
  }

  SettingsState _loadAvailableWordLocales() {
    SettingsState result = SettingsInitial();
    final response = _repository.getAvailableWordsLanguage();
    response.fold((failure) {
      return result = SettingsFailed(failure.errorMessage);
    }, (locale) async {
      _availableWordLocales = locale;
      result = SettingsCompleted();
    });
    return result;
  }

  Future<SettingsState> setWordsLanguage(Locale selected) async {
    SettingsState result = SettingsInitial();
    final response = await _repository.setWordsLanguage(selected);
    response.fold((failure) {
      return result = SettingsFailed(failure.errorMessage);
    }, (_) async {
      _wordLocale = selected;
      result = SettingsCompleted();
    });
    return result;
  }

  SettingsState _loadTheme() {
    SettingsState result = SettingsInitial();
    final response = _repository.getTheme();
    response.fold((failure) async {
      return result = SettingsFailed(failure.errorMessage);
    }, (theme) async {
      _theme = theme;
      result = SettingsCompleted();
    });
    return result;
  }

  Future<SettingsState> setTheme(ThemeMode theme) async {
    SettingsState result = SettingsInitial();
    final response = await _repository.setTheme(theme);
    response.fold((failure) {
      return result = SettingsFailed(failure.errorMessage);
    }, (_) async {
      _theme = theme;
      result = SettingsColorThemeChanged(themeMode: theme);
    });
    return result;
  }
}
