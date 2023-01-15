import 'package:mongo_dart/mongo_dart.dart';

import '../../../utils/utils_barrel.dart';

class DatabaseService with MongoDbErrorHandlerMixin {
  late final Db db;

  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();

  factory DatabaseService() => instance;

  bool _started = false;

  bool get started => _started;

  Future<void> start({
    required String uri,
  }) =>
      handleError(_start(uri));

  Future<void> _start(String uri) async {
    db = Db(uri);
    await db.open();
    _started = true;
  }
}
