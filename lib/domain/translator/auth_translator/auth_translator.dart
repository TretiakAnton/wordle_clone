import 'package:firebase_auth/firebase_auth.dart';
import 'package:wordle_clone/data/entity/requests/auth/login_email_request.dart';
import 'package:wordle_clone/domain/model/login_email_request.dart';
import 'package:wordle_clone/domain/model/wordle_user.dart';

class AuthTranslator {
  EmailPasswordRequestEntity emailPasswordRequestModelToEntity({required EmailPasswordRequestModel model}) {
    return EmailPasswordRequestEntity(
      email: model.email,
      password: model.password,
    );
  }

  WordleUser userCredentialToUser({required UserCredential credential}) {
    return WordleUser(
      email: credential.user!.email!,
      name: credential.user!.displayName ?? credential.user!.email!,
      id: credential.user!.uid,
      photo: credential.user!.photoURL,
    );
  }
}
