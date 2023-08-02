import 'package:dartz/dartz.dart';
import 'package:wordle_clone/core/networking/errors.dart';
import 'package:wordle_clone/core/networking/exceptions.dart';
import 'package:wordle_clone/core/networking/repo_loggy.dart';
import 'package:wordle_clone/data/data_source/box_manager.dart';
import 'package:wordle_clone/domain/model/wordle_user.dart';

class SplashRepository with RepoLoggy {
  final BoxManager _boxManager = BoxManager();

  Either<ServerFailure, WordleUser?> getUser() {
    try {
      final result = _boxManager.getCurrentUser();
      return Right(result);
    } on CustomException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'An unknown error occurred'));
    }
  }
}
