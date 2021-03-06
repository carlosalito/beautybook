import 'package:beautybook/core/models/user/user_model.dart';
import 'package:beautybook/core/repositories/base_repository.dart';

abstract class UserRepository extends BaseRepository<UserModel> {
  Future<void> updateUserPicture(String action);
  Future<void> updateUser(UserModel user);
}
