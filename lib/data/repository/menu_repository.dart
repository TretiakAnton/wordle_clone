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
    try {
      final List<CheckWordsResponse> result = [];
      final List<bool> isEmptyList = [];
      for (int length = 4; length <= 6; length++) {
        isEmptyList.add(await _boxManager.checkBoxEmpty(isEn: true, length: length));
        isEmptyList.add(await _boxManager.checkBoxEmpty(isEn: false, length: length));
      }
      for (int i = 0; i < 3; i++) {
        result.add(CheckWordsResponse(isEn: true, wordLength: i + 4, isEmpty: isEmptyList[i * 2]));
        result.add(CheckWordsResponse(isEn: false, wordLength: i + 4, isEmpty: isEmptyList[i * 2 + 1]));
      }
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
    return await _boxManager.fillWords(isEn: isEn, length: wordLength, words: words);
  }
}
