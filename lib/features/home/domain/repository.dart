import '../index.dart';

abstract class HomeRepository {
  Future<List<GridData>> fetchData(String url);
}
