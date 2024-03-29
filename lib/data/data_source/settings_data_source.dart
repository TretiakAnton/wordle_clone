import 'package:firebase_auth/firebase_auth.dart';
import 'package:wordle_clone/data/entity/requests/auth/login_email_request.dart';

class SettingsDataSource {
  
  Future<UserCredential> emailPasswordLogin({required EmailPasswordRequestEntity request}) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );
  }

  Future<UserCredential> emailPasswordRegister({required EmailPasswordRequestEntity request}) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );
  }

  void getSelectedInterfaceLanguage() {

  }
}
