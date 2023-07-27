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

  Future<Either<ServerFailure, List<CheckWordsResponse>>> checkWords() async {
    List<CheckWordsResponse> result = [];
    try {
      result.add(CheckWordsResponse(isEn: true, wordLength: 4, isEmpty: await _boxManager.is4LettersEnEmpty()));
      result.add(CheckWordsResponse(isEn: true, wordLength: 5, isEmpty: await _boxManager.is5LettersEnEmpty()));
      result.add(CheckWordsResponse(isEn: true, wordLength: 6, isEmpty: await _boxManager.is6LettersEnEmpty()));
      result.add(CheckWordsResponse(isEn: false, wordLength: 4, isEmpty: await _boxManager.is4LettersUaEmpty()));
      result.add(CheckWordsResponse(isEn: false, wordLength: 5, isEmpty: await _boxManager.is5LettersUaEmpty()));
      result.add(CheckWordsResponse(isEn: false, wordLength: 6, isEmpty: await _boxManager.is6LettersUaEmpty()));
      return Right(result);
    } on CustomException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    }
  }

  Future<Either<ServerFailure, GetWordsResponse>> refillWords({required List<WordRefillRequest> refillRequests}) async {
    try {
      final GetWordsResponse result = await _source.refillWords(requests: refillRequests);
      return Right(result);
    } on CustomException catch (e) {
      return Left(
        ServerFailure(errorMessage: e.message),
      );
    }
  }

  Future<void> setWordsList({
    required bool isEn,
    required int wordLength,
    required WordList words,
  }) async {
    if (isEn) {
      switch (wordLength) {
        case 4:
          await _boxManager.fill4LettersEnWords(words: words);
          break;
        case 5:
          await _boxManager.fill5LettersEnWords(words: words);
          break;
        case 6:
          await _boxManager.fill6LettersEnWords(words: words);
          break;
        default:
          break;
      }
    } else {
      switch (wordLength) {
        case 4:
          await _boxManager.fill4LettersUaWords(words: words);
          break;
        case 5:
          await _boxManager.fill5LettersUaWords(words: words);
          break;
        case 6:
          await _boxManager.fill6LettersUaWords(words: words);
          break;
        default:
          break;
      }
    }
  }
}
