import 'package:wordle_clone/data/entity/language.dart';
import 'package:wordle_clone/data/repository/settings_repository.dart';
import 'package:wordle_clone/presentation/state_management/seetings_bloc/settings_cubit.dart';

class SettingsUseCase {
  final SettingsRepository _repository = SettingsRepository();

  // final AuthTranslator _translator = AuthTranslator();
  Language? _interfaceLocale;
  Language? _wordLocale;
  List<Language>? _availableWordLocales;
  List<Language>? _availableInterfaceLocales;

  Language get interfaceLocale {
    if (_interfaceLocale == null) {
      _getSelectedInterfaceLanguage();
    }
    return _interfaceLocale!;
  }

  Language get wordLocale {
    if (_wordLocale == null) {
      _getSelectedWordsLanguage();
    }
    return _wordLocale!;
  }

  List<Language> get availableWordLocales {
    if (_availableWordLocales == null) {
      _loadAvailableWordLocales();
    }
    return _availableWordLocales!;
  }

  List<Language> get availableInterfaceLocales {
    if (_availableInterfaceLocales == null) {
      _loadAvailableInterfacesLocales();
    }
    return _availableInterfaceLocales!;
  }

  SettingsState _getSelectedInterfaceLanguage() {
    SettingsState result = SettingsInitial();
    final response = _repository.getSelectedInterfaceLanguage();
    response.fold((failure) async {
      return result = SettingsFailed(failure.errorMessage);
    }, (locale) async {
      _interfaceLocale = locale;
      result = SettingsCompleted();
    });
    return result;
  }

  SettingsState _getSelectedWordsLanguage() {
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

  SettingsState _loadAvailableInterfacesLocales() {
    SettingsState result = SettingsInitial();
    final response = _repository.getAvailableInterfaceLanguage();
    response.fold((failure) {
      return result = SettingsFailed(failure.errorMessage);
    }, (locale) async {
      _availableInterfaceLocales = locale;
      result = SettingsCompleted();
    });
    return result;
  }

  Future<SettingsState> setWordsLanguage(Language selected) async {
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

  Future<SettingsState> setInterfaceLanguage(Language selected)async  {
    SettingsState result = SettingsInitial();
    final response = await _repository.setInterfaceLanguage(selected);
    response.fold((failure) {
      return result = SettingsFailed(failure.errorMessage);
    }, (_) async {
      _wordLocale = selected;
      result = SettingsCompleted();
    });
    return result;
  }
}
