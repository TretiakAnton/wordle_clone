import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:wordle_clone/core/networking/errors.dart';
import 'package:wordle_clone/core/networking/exceptions.dart';
import 'package:wordle_clone/core/networking/repo_loggy.dart';
import 'package:wordle_clone/data/data_source/auth_data_source.dart';
import 'package:wordle_clone/data/data_source/box_manager.dart';
import 'package:wordle_clone/data/data_source/menu_data_source.dart';
import 'package:wordle_clone/data/entity/requests/auth/login_email_request.dart';
import 'package:wordle_clone/data/entity/requests/menu/word_refill_request.dart';
import 'package:wordle_clone/data/entity/responses/check_words_response.dart';

class MenuRepository with RepoLoggy {
  final MenuDataSource _source = MenuDataSource();
  final BoxManager _boxManager = BoxManager();

  Future<Either<ServerFailure, CheckWordsResponse>> checkWords() async {
    try {
      await _boxManager.init();
      final bool is4LettersWordsEmpty = await _boxManager.is4LettersEmpty();
      final bool is5LettersWordsEmpty = await _boxManager.is5LettersEmpty();
      final bool is6LettersWordsEmpty = await _boxManager.is6LettersEmpty();
      return Right(
        CheckWordsResponse(
          is4LettersWordsEmpty: is4LettersWordsEmpty,
          is5LettersWordsEmpty: is5LettersWordsEmpty,
          is6LettersWordsEmpty: is6LettersWordsEmpty,
        ),
      );
    } on CustomException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    }
  }

  Future<Either<ServerFailure, void>> refillWords(
      {required WordRefillRequest refillRequest}) async {
    try {
      final result = await _source.refillWords(request: refillRequest);
      return const Right(null);
    } on CustomException catch (e) {
      return Left(
        ServerFailure(errorMessage: e.message),
      );
    }
  }
}
