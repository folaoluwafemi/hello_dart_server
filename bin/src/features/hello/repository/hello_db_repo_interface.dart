part of 'hello_db_repository.dart';

abstract class HelloDbRepoInterface {
  Future<String?> fetchHello();

  Future<void> storeHello(String hello);
}
