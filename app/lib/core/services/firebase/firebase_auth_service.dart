import 'dart:async';
import 'dart:io';

import 'package:beautybook/core/constants/storage.dart';
import 'package:beautybook/core/models/user/login_provider_enum.dart';
import 'package:beautybook/core/models/user/user_model.dart';
import 'package:beautybook/core/repositories/user_repository.dart';
import 'package:beautybook/core/services/auth/auth_service.dart';
import 'package:beautybook/core/services/utils/utils.services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' show Response, get;
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<UserCredential> _signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: <String>[
        'email',
      ],
    );

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential resultLogin =
        await FirebaseAuth.instance.signInWithCredential(credential);

    await googleSignIn.signOut();

    return resultLogin;
  }

  Future<bool> _pictureExists(String ref) async {
    try {
      final String url =
          await FirebaseStorage.instance.ref().child(ref).getDownloadURL();
      return Future.value(url != null ? true : false);
    } catch (e) {
      print('ERRO pictureExists ${e.toString()}');
      return Future.value(false);
    }
  }

  Future<UploadTask> _transferImageUserToStorage(
      String origin, String dest, String refName) async {
    try {
      final Response response = await get(origin);
      final Directory documentDirectory =
          await getApplicationDocumentsDirectory();
      final String path = documentDirectory.path + "/images";
      final String fileName = documentDirectory.path + '/images/$refName';
      await Directory(path).create(recursive: true);
      File file = new File(fileName);
      file.writeAsBytesSync(response.bodyBytes);
      return Future.value(UtilsServices.uploadFile(dest, file));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String> socialLogin({LoginProvider provider}) async {
    UserCredential result;

    if (provider == LoginProvider.google) {
      result = await _signInWithGoogle();
    } else {
      // result = await _auth.signInWithFacebook();
    }

    final String storageUserPicRef =
        '${Storage.firebaseStorageUsers}/${result.user.uid}.jpg';

    final bool userPicture = await _pictureExists(storageUserPicRef);

    UploadTask _task;
    if (result.user.photoURL != null && !userPicture) {
      _task = await _transferImageUserToStorage(
          result.user.photoURL, storageUserPicRef, '${result.user.uid}.jpg');
    }

    if (_task == null) return result.user.uid;
    await _task.whenComplete(() => Future.value(result.user.uid));
    return result.user.uid;
  }
}
