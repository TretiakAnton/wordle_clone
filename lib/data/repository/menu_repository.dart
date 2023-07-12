import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wordle_clone/core/networking/errors.dart';
import 'package:wordle_clone/core/networking/exceptions.dart';
import 'package:wordle_clone/core/networking/repo_loggy.dart';
import 'package:wordle_clone/data/data_source/auth_data_source.dart';
import 'package:wordle_clone/data/data_source/box_manager.dart';
import 'package:wordle_clone/data/entity/requests/auth/login_email_request.dart';

class MenuRepository with RepoLoggy {
  final AuthDataSource _source = AuthDataSource();
  final BoxManager _boxManager = BoxManager();

  Future<Either<ServerFailure, bool>> checkWords() async {
    try {
      _boxManager.init();
      final bool is4LettersWordsEmpty = await _boxManager.is4LettersEmpty();
      if (is4LettersWordsEmpty) {

      }
    } on CustomException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    }
  }
}
