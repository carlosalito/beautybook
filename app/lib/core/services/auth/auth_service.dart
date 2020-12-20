import 'package:beautybook/core/models/user/login_provider_enum.dart';
import 'package:beautybook/core/models/user/user_model.dart';
import 'package:beautybook/core/repositories/user_repository.dart';

abstract class AuthService {
  final UserRepository userRepository;

  AuthService({this.userRepository});

  Future<String> signIn({String email, String password});

  Future<String> socialLogin({LoginProvider provider});

  Future<void> signOut();

  Future<String> signUp({String email, String password});

  Future<UserModel> currentUser();

  Future<String> refreshToken();
}
