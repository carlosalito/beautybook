import 'dart:convert';

import 'package:beautybook/core/constants/endpoint.dart';
import 'package:beautybook/core/models/boticario-news/boticario-news_model.dart';
import 'package:beautybook/core/services/http/http_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApiBoticarioNewsRepository {
  final CommonHttp clientHttp = CommonHttp();

  Future<List<BoticarioNewsModel>> list() async {
    try {
      final _result = await clientHttp.apiGet(Endpoints.boticarioNews,
          public: true, injectToken: false);

      final _data = jsonDecode(utf8.decode(_result.bodyBytes))['news'] as List;
      return _data.map((e) => BoticarioNewsModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
