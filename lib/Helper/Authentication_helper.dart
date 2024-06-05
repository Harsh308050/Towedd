import 'package:firebase_auth/firebase_auth.dart';

class Authentication_helper {
  FirebaseAuth auth = FirebaseAuth.instance;

  Authentication_helper._();
  static final Authentication_helper firebase = Authentication_helper._();

  Future<User?> registerwithEmailandPassword(
    String email,
    String password,
  ) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print("sign up sucessful ${userCredential.user}");
    return userCredential.user;
  }

  Future<User?> loginwithEmailandPassword(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (PlatformException) {
      print("error $PlatformException");
    }
    return null;
  }
}
