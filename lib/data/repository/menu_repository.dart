import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:wordle_clone/core/networking/errors.dart';
import 'package:wordle_clone/core/networking/exceptions.dart';
import 'package:wordle_clone/core/networking/repo_loggy.dart';
import 'package:wordle_clone/data/data_source/box_manager.dart';
import 'package:wordle_clone/data/data_source/menu_data_source.dart';
import 'package:wordle_clone/data/entity/requests/menu/word_refill_request.dart';
import 'package:wordle_clone/data/entity/responses/check_words_response.dart';
import 'package:wordle_clone/data/entity/responses/get_words_response.dart';
import 'package:wordle_clone/data/entity/word_list.dart';

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

  Future<Either<ServerFailure, Map<int, GetWordsResponse>>> refillWords(
      {required WordRefillRequest refillRequest}) async {
    try {
      final Map<int, GetWordsResponse> result =
          await _source.refillWords(request: refillRequest);
      return Right(result);
    } on CustomException catch (e) {
      return Left(
        ServerFailure(errorMessage: e.message),
      );
    }
  }

  Future<void> setWordsList({
    required int wordLength,
    required WordList words,
  }) async {
    switch (wordLength) {
      case 4:
        await _boxManager.fill4LettersWords(words: words);
        break;
      case 5:
        await _boxManager.fill5LettersWords(words: words);
        break;
      case 6:
        await _boxManager.fill6LettersWords(words: words);
        break;
      default:
        break;
    }
  }
}
