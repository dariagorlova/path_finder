import 'package:path_finder/features/home/domain/models/coordinate_model.dart';
import 'package:path_finder/features/home/domain/models/grid_model.dart';
import 'package:path_finder/features/process/domain/model/send_result.dart';

abstract class ProcessRepository {
  Future<List<Coordinate>> findShortestPath(GridData model);
  Future<List<SendResult>> pushResults({
    required List<String> ids,
    required List<List<Coordinate>> paths,
  });
}
