import '../index.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeApiService _apiService;

  const HomeRepositoryImpl(HomeApiService apiService)
      : _apiService = apiService;

  @override
  Future<List<GridData>> fetchData(String url) async {
    try {
      final res = await _apiService.fetchData(url);
      return res;
    } catch (_) {
      rethrow;
    }
  }
}
