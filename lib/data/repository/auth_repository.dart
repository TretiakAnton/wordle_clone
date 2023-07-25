import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wordle_clone/core/networking/errors.dart';
import 'package:wordle_clone/core/networking/exceptions.dart';
import 'package:wordle_clone/core/networking/repo_loggy.dart';
import 'package:wordle_clone/data/data_source/auth_data_source.dart';
import 'package:wordle_clone/data/entity/requests/auth/login_email_request.dart';

class AuthRepository with RepoLoggy {
  final AuthDataSource _source = AuthDataSource();

  Future<Either<ServerFailure, UserCredential>> emailPasswordLogin(
      {required EmailPasswordRequestEntity request}) async {
    try {
      final result = await _source.emailPasswordLogin(request: request);
      return Right(result);
    } on CustomException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    }
  }

  Future<Either<ServerFailure, UserCredential>> emailPasswordRegistration(
      {required EmailPasswordRequestEntity request}) async {
    try {
      final result = await _source.emailPasswordRegister(request: request);
      return Right(result);
    } on CustomException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    }
  }
}
