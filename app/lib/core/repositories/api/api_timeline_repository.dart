import 'dart:convert';

import 'package:beautybook/core/constants/collections.dart';
import 'package:beautybook/core/constants/endpoint.dart';
import 'package:beautybook/core/models/post/post_model.dart';
import 'package:beautybook/core/models/response/page_info_model.dart';
import 'package:beautybook/core/repositories/api/api_base_repository.dart';
import 'package:beautybook/core/repositories/timeline_repository.dart';
import 'package:beautybook/core/services/http/http_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TimelineRepository)
class ApiTimelineRepository extends ApiBaseRepository<PostModel>
    implements TimelineRepository {
  CommonHttp clientHttp;

  ApiTimelineRepository([CommonHttp http]) {
    if (http != null)
      clientHttp = http;
    else
      clientHttp = CommonHttp();
  }

  @override
  String get collectionPath => Collections.timeline;

  @override
  PostModel map(Map<String, dynamic> model) {
    return PostModel.fromJson(model);
  }

  @override
  Future<void> create(PostModel post) async {
    try {
      final _result = await clientHttp.apiPost(Endpoints.post, jsonEncode(post),
          public: false);

      if (_result.statusCode != 200) throw Exception(_result.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateGalery({String postId, List<String> pictures}) async {
    try {
      final _result = await clientHttp.apiPut(
          Endpoints.updateGalery + postId, jsonEncode(pictures),
          public: false);
      if (_result.statusCode != 200) throw Exception(_result.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  List<PostModel> _parseList(List data) {
    return data.map((e) => PostModel.fromJson(e)).toList();
  }

  @override
  Future<Map<String, dynamic>> list(int page) async {
    try {
      final _result = await clientHttp
          .apiGet('${Endpoints.listPosts}${page.toString()}', public: true);

      if (_result.statusCode == 200) {
        final _data = jsonDecode(_result.body);
        return {
          'data': _parseList(_data['data']),
          'pageInfo': PageInfoModel.fromJson(_data['pageInfo'])
        };
      } else
        throw Exception(_result.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> delete(String postId) async {
    try {
      final _result = await clientHttp.apiDelete('${Endpoints.post}/$postId',
          public: false);

      if (_result.statusCode != 200) throw Exception(_result.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<PostModel> findById({String id}) {
    throw UnimplementedError();
  }
}
