import 'package:mongo_dart/mongo_dart.dart';

import '../../../global/services/database_service/database_service.dart';
import '../../../utils/utils_barrel.dart';

part 'hello_db_repo_interface.dart';

class HelloDbRepository
    with MongoDbErrorHandlerMixin
    implements HelloDbRepoInterface {
  final DbCollection _collection;

  HelloDbRepository._({
    DbCollection? db,
  }) : _collection = db ??
            DatabaseService().db.collection(
                  Keys.helloCollection,
                );

  static final HelloDbRepository instance = HelloDbRepository._();

  factory HelloDbRepository() => instance;

  @override
  Future<String?> fetchHello() => handleError(_fetchHello());

  Future<String?> _fetchHello() async {
    final Map<String, dynamic>? data = await _collection.findOne(
      where.exists(Keys.hello),
    );

    if (data == null) return null;

    return data[Keys.hello] as String?;
  }

  @override
  Future<void> storeHello(String hello) => handleError(_storeHello(hello));

  Future<void> _storeHello(String hello) async {
    await _collection.deleteOne(where.exists(Keys.hello));
    await _collection.insertOne({Keys.hello: hello});
  }
}
