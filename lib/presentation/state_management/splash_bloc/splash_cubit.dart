import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/domain/use_cases/splash_use_case/splash_use_case.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  final SplashUseCase _useCase = SplashUseCase();

  Future<void> initApp() async {
    emit(SplashInProgress());
    final isUserSaved = _useCase.checkSavedUser();
    SplashState resultState = SplashCompleted(canSkipLogin: isUserSaved);
    emit(resultState);
  }
}
