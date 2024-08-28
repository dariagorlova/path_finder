import '../../home/index.dart';
import '../index.dart';

abstract class ProcessRepository {
  Future<List<Coordinate>> findShortestPath(GridData model);
  Future<List<SendResult>> pushResults({
    required List<String> ids,
    required List<List<Coordinate>> paths,
  });
}
