import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../../utils/utils_barrel.dart';
import '../repository/hello_db_repository.dart';

class HelloController with ControllerErrorHandlerMixin {
  final HelloDbRepoInterface _repo;

  HelloController._({
    HelloDbRepoInterface? repo,
  }) : _repo = repo ?? HelloDbRepository();

  static final HelloController instance = HelloController._();

  factory HelloController() => instance;

  Router get router {
    final Router router = Router();

    router.get(Paths.hello, getHelloHandler);

    router.post(Paths.hello, postHelloHandler);

    return router;
  }

  Future<Response> getHelloHandler(Request request) => handleErrorWithResponse(
        _getHelloHandler(request),
      );

  Future<Response> _getHelloHandler(Request request) async {
    final String? hello = await _repo.fetchHello();
    return Response.ok(
      hello,
      headers: SimpleHeaders.textPlain,
    );
  }

  Future<Response> postHelloHandler(Request request) => handleErrorWithResponse(
        _postHelloHandler(request),
      );

  Future<Response> _postHelloHandler(Request request) async {
    final String helloRequestBody = await request.readAsString();
    _repo.storeHello(helloRequestBody);
    return Response.ok('Hello stored!', headers: SimpleHeaders.textPlain);
  }
}
