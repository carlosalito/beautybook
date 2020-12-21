import 'package:beautybook/core/models/post/post_model.dart';
import 'package:beautybook/core/repositories/base_repository.dart';

abstract class TimelineRepository extends BaseRepository<PostModel> {
  Future<void> updateGalery({String postId, List<String> pictures});
  Future<Map<String, dynamic>> list(int page);
  Future<void> delete(String postId);
}
