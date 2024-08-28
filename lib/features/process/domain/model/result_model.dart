import 'package:path_finder/features/home/domain/models/coordinate_model.dart';

class ResultModel {
  final List<String> field;
  final List<Coordinate> steps;

  ResultModel({
    required this.field,
    required this.steps,
  });
}
