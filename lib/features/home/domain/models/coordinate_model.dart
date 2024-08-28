import 'dart:math';

import '../../../process/index.dart';

class Coordinate {
  final int x;
  final int y;

  Coordinate({required this.x, required this.y});

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(
      x: json['x'],
      y: json['y'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
    };
  }

  // better to use operator overloading than write more code
  Coordinate operator +(Direction direction) =>
      Coordinate(x: x + direction.xDelta, y: y + direction.yDelta);

  // is necessary for "=="
  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  // must have a possibility to compare coordinates by simple "==".
  // also is used at List.compare()
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Coordinate &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  String toString() => '($x, $y)';

  // distance between current coordinate and "other"
  double distance(Coordinate other) =>
      sqrt(pow(x - other.x, 2) + pow(y - other.y, 2));
}
