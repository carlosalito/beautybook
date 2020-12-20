import 'dart:async';

import 'package:beautybook/core/models/user/user_model.dart';
import 'package:beautybook/core/repositories/user_repository.dart';
import 'package:beautybook/core/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

final _auth = FirebaseAuth.instance;

@Injectable(as: AuthService)
class FirebaseAuthenticationService extends AuthService {
  FirebaseAuthenticationService({UserRepository userRepository})
      : super(userRepository: userRepository);

  @override
  Future<String> signIn({String email, String password}) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential != null) {
        return userCredential.user.uid;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  @override
  Future<UserModel> currentUser() async {
    User firebaseUser = _auth.currentUser;
    firebaseUser ??= await _auth.authStateChanges().first;

    if (firebaseUser != null) {
      return await userRepository.findById(id: firebaseUser.uid);
    }
    return null;
  }

  @override
  Future<String> signUp({String email, String password}) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential != null) {
        return userCredential.user.uid;
      }

      return null;
    } on FirebaseAuthException catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<String> refreshToken() async {
    User firebaseUser = _auth.currentUser;
    firebaseUser ??= await _auth.authStateChanges().first;

    return firebaseUser.getIdToken(true);
  }
}
