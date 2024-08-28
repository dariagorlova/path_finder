import 'package:dio/dio.dart';
import 'package:path_finder/features/home/domain/models/grid_model.dart';

abstract class HomeApiService {
  Future<List<GridData>> fetchData(String url);
}

class HomeApiServiceImpl implements HomeApiService {
  @override
  Future<List<GridData>> fetchData(String url) async {
    try {
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((i) => GridData.fromJson(i))
            .toList();
      }
      throw 'error';
    } catch (_) {
      throw 'error';
    }
  }
}
