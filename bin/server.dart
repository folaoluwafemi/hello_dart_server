import 'dart:io';

import 'package:shelf/shelf_io.dart';

import 'src/global/global_barrel.dart';
import 'src/utils/utils_barrel.dart';

void main(List<String> args) async {
  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  await DatabaseService().start(uri: Paths.dbPath());

  final HttpServer server = await serve(
    HelloApplicationChannel().handler,
    InternetAddress.anyIPv4,
    port,
  );

  print('Server listening on port ${server.port}');
}
