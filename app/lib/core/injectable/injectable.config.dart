// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../services/account/accounts_service.dart';
import '../repositories/api/api_user_repository.dart';
import '../../app_controller.dart';
import '../services/auth/auth_service.dart';
import '../services/firebase/firebase_auth_service.dart';
import '../../screens/navigator/navigator.controller.dart';
import '../../screens/sign/signin.controller.dart';
import '../../screens/sign/signup.controller.dart';
import '../repositories/user_repository.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<NavigatorController>(() => NavigatorController());
  gh.factory<UserRepository>(() => ApiUserRepository());
  gh.factory<AuthService>(() =>
      FirebaseAuthenticationService(userRepository: get<UserRepository>()));
  gh.factory<AccountService>(() => AccountService(
      authService: get<AuthService>(), userRepository: get<UserRepository>()));
  gh.factory<SignInController>(() => SignInController(
        appController: get<AppController>(),
        accountService: get<AccountService>(),
        repository: get<UserRepository>(),
      ));
  gh.factory<SignUpController>(() => SignUpController(
        appController: get<AppController>(),
        accountService: get<AccountService>(),
        repository: get<UserRepository>(),
        authService: get<AuthService>(),
      ));

  // Eager singletons must be registered in the right order
  gh.singleton<AppController>(AppController(
      authService: get<AuthService>(), userRepository: get<UserRepository>()));
  return get;
}