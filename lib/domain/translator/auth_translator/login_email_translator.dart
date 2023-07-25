import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:wordle_clone/data/entity/requests/auth/login_email_request.dart';
import 'package:wordle_clone/domain/model/login_email_request.dart';
import 'package:wordle_clone/domain/model/user.dart';

class LoginEmailTranslator {
  EmailPasswordRequestEntity emailPasswordRequestModelToEntity({required EmailPasswordRequestModel model}) {
    return EmailPasswordRequestEntity(
      email: model.email,
      password: model.password,
    );
  }

  User userCredentialToUser({required firebase.UserCredential credential}) {
    return User(
      email: credential.user!.email!,
      name: credential.user!.displayName ?? credential.user!.email!,
      photo: credential.user!.photoURL,
    );
  }
}
