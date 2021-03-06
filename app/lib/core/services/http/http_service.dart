import 'package:beautybook/core/constants/storage.dart';
import 'package:beautybook/core/helpers/hive/hive_helper.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:beautybook/core/models/user/user_model.dart';
import 'package:beautybook/core/services/auth/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@injectable
class CommonHttp {
  final http.Client clientHttp = http.Client();

  Future<bool> _storedTokenIsValid() async {
    final lastTokenTime = await HiveHelper.getValueInBox(Storage.lastTokenTime);

    if (lastTokenTime != null) {
      final Duration durationToken = DateTime.now().difference(lastTokenTime);

      if (durationToken.inMinutes <= 45) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } else {
      return Future.value(false);
    }
  }

  Future<String> _refreshToken(String token) async {
    final tokenIsValid = await _storedTokenIsValid();

    if (tokenIsValid && token != null && token.isNotEmpty) return token;

    final authService = getIt<AuthService>();
    token = await authService.refreshToken();
    HiveHelper.saveValueInBox(Storage.lastTokenTime, DateTime.now());
    HiveHelper.saveValueInBox(Storage.token, token);

    return token;
  }

  Future<String> _getToken(bool public) async {
    String _token = Storage.publicToken;
    if (!public) {
      _token = HiveHelper.getValueInBox(Storage.token);
      _token = await _refreshToken(HiveHelper.getValueInBox(Storage.token));
    }

    return _token;
  }

  Future<http.Response> apiPost(
    String url,
    param, {
    bool public,
  }) async {
    final token = await _getToken(public);

    final UserModel user = HiveHelper.getValueInBox(Storage.user);
    final Map<String, String> _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $token",
      "UserUid": user?.uid ?? '',
    };

    final http.Response response =
        await http.post(url, headers: _headers, body: param);
    return response;
  }

  Future<http.Response> apiPut(
    String url,
    dynamic param, {
    bool public,
  }) async {
    final token = await _getToken(public);

    final UserModel user = HiveHelper.getValueInBox(Storage.user);
    final Map<String, String> _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $token",
      "UserUid": user?.uid ?? '',
    };

    final http.Response response =
        await http.put(url, headers: _headers, body: param);
    return response;
  }

  Future<http.Response> apiDelete(
    String url, {
    bool public,
  }) async {
    final token = await _getToken(public);

    final UserModel user = HiveHelper.getValueInBox(Storage.user);
    final Map<String, String> _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $token",
      "UserUid": user?.uid ?? '',
    };

    final http.Response response = await http.delete(url, headers: _headers);
    return response;
  }

  Future<http.Response> apiGet(
    String url, {
    bool public,
    bool injectToken = true,
  }) async {
    final token = await _getToken(public);

    final UserModel user = HiveHelper.getValueInBox(Storage.user);
    final Map<String, String> _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $token",
      "UserUid": user?.uid ?? '',
    };

    if (!injectToken)
      _headers.removeWhere(
          (key, value) => key == "Authorization" || key == "UserUid");

    final http.Response response = await clientHttp.get(url, headers: _headers);
    return response;
  }
}
