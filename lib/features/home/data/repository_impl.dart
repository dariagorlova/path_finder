import 'package:path_finder/features/home/data/api_service.dart';
import 'package:path_finder/features/home/domain/models/grid_model.dart';
import 'package:path_finder/features/home/domain/repository.dart';

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
