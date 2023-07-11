import 'package:firebase_auth/firebase_auth.dart';
import 'package:wordle_clone/data/entity/requests/auth/login_email_request.dart';

class AuthDataSource {
  Future<UserCredential> emailPasswordLogin(
      {required LoginEmailRequestEntity request}) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );
  }
}
