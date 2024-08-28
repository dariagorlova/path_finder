import 'package:path_finder/features/home/domain/models/coordinate_model.dart';
import 'package:path_finder/features/home/domain/models/grid_model.dart';
import 'package:path_finder/features/process/domain/model/direction.dart';

class Pathfinder {
  final GridData gridData;

  Pathfinder(this.gridData);

  final List<Direction> _dirs = [
    Direction.north,
    Direction.south,
    Direction.east,
    Direction.west,
    Direction.northWest,
    Direction.northEast,
    Direction.southWest,
    Direction.southEast,
  ];

  // isolate function. case it's a little bit ... wrong) to do calculations in main thread
  static Future<List<Coordinate>> findShortestPath(
      Pathfinder pathFinder) async {
    //todo: remove delay and all future features from function for production
    await Future.delayed(const Duration(seconds: 2));

    final List<Coordinate> queue = [pathFinder.gridData.start];
    final Map<Coordinate, Coordinate?> cameFrom = {};
    final Map<Coordinate, double> costSoFar = {pathFinder.gridData.start: 0};

    while (queue.isNotEmpty) {
      queue.sort(
        (a, b) => b
            .distance(pathFinder.gridData.end)
            .compareTo(a.distance(pathFinder.gridData.end)),
      ); // desc distance sorting to the end point
      final current = queue.removeLast();

      if (current == pathFinder.gridData.end) {
        break;
      }

      for (final neighbor in pathFinder._neighbors(current)) {
        final newCost =
            current.x - neighbor.x == 0 || current.y - neighbor.y == 0
                ? costSoFar[current]! + 1.0 // Straight line
                : costSoFar[current]! + 1.4; // Diagonal
        if (costSoFar[neighbor] == null || newCost < costSoFar[neighbor]!) {
          if (queue.contains(neighbor)) {
            continue;
          }
          costSoFar[neighbor] = newCost;
          cameFrom[neighbor] = current;
          queue.add(neighbor);
        }
      }
    }

    if (costSoFar[pathFinder.gridData.end] == null) {
      return []; // No path found
    }

    return pathFinder._reconstructPath(cameFrom, pathFinder.gridData.end);
  }

  List<Coordinate> _reconstructPath(
      Map<Coordinate, Coordinate?> cameFrom, Coordinate current) {
    final path = <Coordinate>[];
    while (cameFrom.containsKey(current)) {
      path.add(current);
      current = cameFrom[current]!;
    }
    path.add(gridData.start);
    return path.reversed.toList();
  }

  List<Coordinate> _neighbors(Coordinate coordinate) {
    return _dirs
        .map((dir) {
          final neighbor = coordinate + dir;
          if (_isInside(neighbor) && !_isWall(neighbor)) {
            return neighbor;
          }
          return null;
        })
        .whereType<Coordinate>()
        .toList();
  }

  bool _isInside(Coordinate pos) =>
      pos.x >= 0 &&
      pos.x < gridData.field.length &&
      pos.y >= 0 &&
      pos.y < gridData.field[0].length;

  bool _isWall(Coordinate pos) => gridData.field[pos.x][pos.y] == 'X';
}
