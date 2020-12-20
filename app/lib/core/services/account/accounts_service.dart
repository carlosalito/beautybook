import 'package:beautybook/core/models/user/login_provider_enum.dart';
import 'package:beautybook/core/models/user/user_model.dart';
import 'package:beautybook/core/repositories/user_repository.dart';
import 'package:beautybook/core/services/auth/auth_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class AccountService {
  final AuthService authService;
  final UserRepository userRepository;

  const AccountService({this.authService, this.userRepository});

  Future<UserModel> authenticate({String email, String password}) async {
    final uid = await authService.signIn(
      email: email,
      password: password,
    );

    return uid == null ? null : await userRepository.findById(id: uid);
  }

  Future<UserModel> socialLogin({LoginProvider provider}) async {
    final uid = await authService.socialLogin(provider: provider);

    return uid == null ? null : await userRepository.findById(id: uid);
  }

  Future<String> createUser({String email, String password}) async {
    final uid = await authService.signUp(
      email: email,
      password: password,
    );

    return uid;
  }
}
