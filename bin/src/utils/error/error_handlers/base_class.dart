import 'dart:async';

import '../../utils_barrel.dart';

typedef ErrorFallback<Error> = FutureOr<Error> Function(Failure failure);

abstract class ErrorHandler {
  Future<T> handleError<T>(
    Future<T> computation, {
    ErrorFallback<T>? catcher,
  });
}
