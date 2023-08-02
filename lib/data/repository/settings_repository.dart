import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wordle_clone/core/networking/errors.dart';
import 'package:wordle_clone/core/networking/exceptions.dart';
import 'package:wordle_clone/core/networking/repo_loggy.dart';
import 'package:wordle_clone/data/data_source/box_manager.dart';
import 'package:wordle_clone/data/data_source/settings_data_source.dart';
import 'package:wordle_clone/data/entity/requests/auth/login_email_request.dart';

class SettingsRepository with RepoLoggy {
  final SettingsDataSource _source = SettingsDataSource();
  final BoxManager _boxManager = BoxManager();

  Future<Either<ServerFailure, UserCredential>> emailPasswordRegistration(
      {required EmailPasswordRequestEntity request}) async {
    try {
      final result = await _source.emailPasswordRegister(request: request);
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on CustomException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'An unknown error occurred'));
    }
  }

  Either<ServerFailure, Locale> getSelectedWordsLanguage() {
    try {
      final Locale selectedLocale = _boxManager.getSelectedWordsLanguage();
      return Right(selectedLocale);
    } on Exception catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  Either<ServerFailure, List<Locale>> getAvailableWordsLanguage() {
    try {
      final List<Locale> selectedLocale = _boxManager.getAvailableWordsLanguage();
      return Right(selectedLocale);
    } on Exception catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  Future<Either<ServerFailure, void>> setWordsLanguage(Locale selected) async {
    try {
      await _boxManager.setWordsLanguage(selected);
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  Future<Either<ServerFailure, void>> setTheme(ThemeMode brightness) async {
    try {
      await _boxManager.setTheme(brightness);
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
  Either<ServerFailure, ThemeMode> getTheme() {
    try {
      final ThemeMode selectedLocale = _boxManager.getTheme();
      return Right(selectedLocale);
    } on Exception catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
