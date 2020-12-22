import 'dart:convert';

import 'package:beautybook/core/models/post/post_model.dart';
import 'package:beautybook/core/repositories/api/api_timeline_repository.dart';
import 'package:beautybook/core/services/http/http_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../mocks/timeline.mock.dart';

class MockCommonHttp extends Mock implements CommonHttp {}

void main() {
  MockCommonHttp commonHttp;
  ApiTimelineRepository repository;

  setUp(() {
    commonHttp = MockCommonHttp();
    repository = ApiTimelineRepository(commonHttp);
  });

  test('get timeline posts repository', () async {
    when(
      commonHttp.apiGet(any, injectToken: true, public: true),
    ).thenAnswer((_) async => http.Response(postsMock, 200));

    final _data = await repository.list(0);
    expect(_data['pageInfo'].totalRows, 1);
  });

  test('insert post repository', () async {
    final _post = PostModel(
      body: 'body test',
      title: 'title test',
      pictures: [],
      uid: 'uid-test',
    );

    when(
      commonHttp.apiPost(any, jsonEncode(_post), public: false),
    ).thenAnswer((_) async => http.Response('''{"success": true}''', 200));

    await repository.create(_post);
  });
}
