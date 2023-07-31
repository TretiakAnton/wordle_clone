import 'package:flutter/material.dart';
import 'package:wordle_clone/data/repository/settings_repository.dart';
import 'package:wordle_clone/presentation/state_management/seetings_bloc/settings_cubit.dart';

class SettingsUseCase {
  final SettingsRepository _repository = SettingsRepository();

  // final AuthTranslator _translator = AuthTranslator();
  Locale? _wordLocale;
  List<Locale>? _availableWordLocales;

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

}
