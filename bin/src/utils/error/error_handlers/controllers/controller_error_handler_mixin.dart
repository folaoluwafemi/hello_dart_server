import 'dart:async';

import 'package:shelf/shelf.dart';

import '../../../utils_barrel.dart';

mixin ControllerErrorHandlerMixin implements ErrorHandler {
  @override
  Future<T> handleError<T>(
    Future<T> computation, {
    ErrorFallback<T>? catcher,
  }) async {
    try {
      return await computation;
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

  Future<Response> handleErrorWithResponse(
    FutureOr<Response> computation,
  ) async {
    try {
      return await computation;
    } catch (e, stackTrace) {
      late Failure failure;
      if (e is Failure) {
        failure = e;
      } else {
        failure = Failure(message: e.toString(), stackTrace: stackTrace);
      }
      return Response.internalServerError(body: failure.message);
    }
  }
}
