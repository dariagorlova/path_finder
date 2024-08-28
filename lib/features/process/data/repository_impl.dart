import 'package:flutter/foundation.dart';
import 'package:path_finder/features/home/domain/models/coordinate_model.dart';
import 'package:path_finder/features/home/domain/models/grid_model.dart';
import 'package:path_finder/features/process/data/api_service.dart';
import 'package:path_finder/features/process/data/path_finder.dart';
import 'package:path_finder/features/process/domain/model/send_result.dart';
import 'package:path_finder/features/process/domain/repository.dart';

class ProcessRepositoryImpl implements ProcessRepository {
  final ProcessApiService _apiService;

  ProcessRepositoryImpl(ProcessApiService apiService)
      : _apiService = apiService;

  @override
  Future<List<Coordinate>> findShortestPath(GridData model) async {
    final pathFinder = Pathfinder(model);

    // lets run this code in separate thread for better performance
    final res = await compute(Pathfinder.findShortestPath, pathFinder);
    return res;
  }

  @override
  Future<List<SendResult>> pushResults(
      {required List<String> ids,
      required List<List<Coordinate>> paths}) async {
    final List<Map<String, dynamic>> totalList = [];
    for (final id in ids) {
      final map = <String, dynamic>{};
      map['id'] = id;
      map['result'] = {
        'steps': paths[ids.indexOf(id)].map((e) => e.toJson()).toList(),
        'path':
            paths[ids.indexOf(id)].map((e) => e.toString()).toList().join('->'),
      };
      totalList.add(map);
    }
    try {
      final response = await _apiService.sendData(totalList);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
