import 'package:beautybook/core/models/base_model.dart';
import 'package:beautybook/core/repositories/base_repository.dart';

abstract class ApiBaseRepository<Model extends BaseModel<String>>
    extends BaseRepository<Model> {
  Model map(Map<String, dynamic> model);
}
