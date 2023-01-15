import 'package:mongo_dart/mongo_dart.dart';

import '../../error_barrel.dart';

mixin MongoDbErrorHandlerMixin implements ErrorHandler {
  @override
  Future<T> handleError<T>(
    Future<T> computation, {
    ErrorFallback<T>? catcher,
  }) async {
    try {
      return await computation;
    } on MongoDartError catch (e, stackTrace) {
      String errorMessageFromMongoCode = e.mongoCode == null
          ? ''
          : _mongoCodeErrorMessageSwitcher(e.mongoCode!);
      errorMessageFromMongoCode += ' | ${e.message}';
      final Failure failure = Failure(
        message: errorMessageFromMongoCode.trim(),
        exception: Exception(e),
        stackTrace: stackTrace,
      );
      return catcher == null ? Future.error(failure) : catcher.call(failure);
    } catch (e, stackTrace) {
      late Failure failure;
      if (e is Failure) {
        failure = e;
      } else {
        failure = Failure(message: e.toString(), stackTrace: stackTrace);
      }
      return catcher == null ? Future.error(failure) : catcher.call(failure);
    }
  }

  String _mongoCodeErrorMessageSwitcher(int mongoCode) {
    switch (mongoCode) {
      case 4:
        return 'Database version error';
      case 5:
        return 'Initialization error';
      case 48:
        return 'Mongod could not start listening for incoming connections, due to an error';
      case 14:
        return 'Fatal error';
      case 61:
        return 'File system unresponsive';
      case 100:
        return 'Mongo uncaught exception';
      default:
        return '';
    }
  }
}
