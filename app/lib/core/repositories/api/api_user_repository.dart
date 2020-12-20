import 'dart:convert';

import 'package:beautybook/core/constants/endpoint.dart';
import 'package:beautybook/core/models/user/user_model.dart';
import 'package:beautybook/core/models/user/user_response_enum.dart';
import 'package:beautybook/core/repositories/api/api_base_repository.dart';
import 'package:beautybook/core/repositories/user_repository.dart';
import 'package:beautybook/core/services/http/http_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserRepository)
class ApiUserRepository extends ApiBaseRepository<UserModel>
    implements UserRepository {
  @override
  String get collectionPath => 'user';

  @override
  UserModel map(Map<String, dynamic> model) {
    return UserModel.fromJson(model);
  }

  @override
  Future<UserModel> findById({String id}) async {
    try {
      final _url =
          Endpoints.me.replaceAll('#id', id).replaceAll('#provider', 'email');
      final result = await CommonHttp.apiGet(_url, public: false);
      if (result.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(result.body));
      } else {
        throw Exception(result.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserResponseEnum> create(UserModel user) async {
    try {
      final result = await CommonHttp.apiPost(Endpoints.user, jsonEncode(user),
          public: true);

      if (result.statusCode == 200) {
        return Future.value(UserResponseEnum.success);
      } else {
        if (result.statusCode == 401) {
          return Future.value(UserResponseEnum.userExist);
        }

        return Future.value(UserResponseEnum.error);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}