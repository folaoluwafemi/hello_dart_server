abstract class Paths {
  static String dbPath([String host = 'localhost', String port = '27017']) {
    return 'mongodb://$host:$port/hello_dart';
  }

  static const String hello = '/hello';

  static const String invalidRoute = '/<ignored|.*>';
}
