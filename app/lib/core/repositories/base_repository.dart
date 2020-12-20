import 'package:beautybook/core/models/base_model.dart';

abstract class BaseRepository<Model extends BaseModel<String>> {
  String collectionPath;

  Future<Model> findById({String id});

  Future<dynamic> create(Model object);
}
