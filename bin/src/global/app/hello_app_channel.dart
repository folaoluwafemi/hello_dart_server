import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../features/hello/controller/hello_controller.dart';
import '../../utils/utils_barrel.dart';

class HelloApplicationChannel {
  Handler get handler {
    final Router router = Router();
    final Pipeline pipeline = Pipeline().addMiddleware(logRequests());

    router.mount('/', HelloController().router);

    router.all(Paths.invalidRoute, invalidRouteHandler);

    return pipeline.addHandler(router);
  }

  Response invalidRouteHandler(Request request) {
    return Response.notFound('Invalid router');
  }
}
