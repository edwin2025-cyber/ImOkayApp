import 'package:firebase_auth/firebase_auth.dart';

Future<void> emailSignUp(String email, String password) async {
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
}
