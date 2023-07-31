import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/domain/use_cases/settings_use_case/settings_use_case.dart';
import 'package:wordle_clone/presentation/view/widgets/snackbars.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  final SettingsUseCase _useCase = SettingsUseCase();

  Locale get selectedWordLanguage => _useCase.wordLocale;

  List<Locale> get availableWordLanguage => _useCase.availableWordLocales;

  Future<void> setWordsLanguage(Locale selected) async {
    emit(SettingsInProgress());
    SettingsState resultState = await _useCase.setWordsLanguage(selected);
    if (resultState is SettingsFailed) {
      OrdinarySnackbar().showSnackBar(label: resultState.error ?? 'Error');
      resultState = SettingsCompleted();
    }
    emit(resultState);
  }

}
