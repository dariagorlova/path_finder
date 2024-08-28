import '../../index.dart';

class GridData {
  final String id;
  final List<String> field;
  final Coordinate start;
  final Coordinate end;

  GridData({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory GridData.fromJson(Map<String, dynamic> json) {
    return GridData(
      id: json['id'],
      field: List<String>.from(json['field']),
      start: Coordinate.fromJson(json['start']),
      end: Coordinate.fromJson(json['end']),
    );
  }
}
