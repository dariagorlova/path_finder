import 'package:path_finder/features/home/domain/models/grid_model.dart';

abstract class HomeRepository {
  Future<List<GridData>> fetchData(String url);
}
