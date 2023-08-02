import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wordle_clone/core/networking/errors.dart';
import 'package:wordle_clone/core/networking/exceptions.dart';
import 'package:wordle_clone/core/networking/repo_loggy.dart';
import 'package:wordle_clone/data/data_source/auth_data_source.dart';
import 'package:wordle_clone/data/data_source/box_manager.dart';
import 'package:wordle_clone/data/entity/requests/auth/login_email_request.dart';
import 'package:wordle_clone/domain/model/wordle_user.dart';

class AuthRepository with RepoLoggy {
  final AuthDataSource _source = AuthDataSource();
  final BoxManager _boxManager = BoxManager();

  Future<Either<ServerFailure, UserCredential>> emailPasswordLogin(
      {required EmailPasswordRequestEntity request}) async {
    try {
      final result = await _source.emailPasswordLogin(request: request);
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on CustomException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'An unknown error occurred'));
    }
  }

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

  Future<Either<ServerFailure, void>> saveUser({required WordleUser user}) async {
    try {
      final result = await _boxManager.saveUser(user);
      return Right(result);
    } on CustomException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'An unknown error occurred'));
    }
  }

  Future<Either<ServerFailure, void>> deleteUser() async {
    try {
      final result = await _boxManager.deleteCurrentUser();
      return Right(result);
    } on CustomException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'An unknown error occurred'));
    }
  }

  Future<Either<ServerFailure, void>> logOut() async{
    try {
      final result = await _source.logOut();
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on CustomException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'An unknown error occurred'));
    }
  }
}
