class Direction {
  const Direction(int rowDelta, int columnDelta)
      : _row = rowDelta,
        _col = columnDelta;
  final int _row;
  final int _col;

  int get xDelta => _row;
  int get yDelta => _col;

  static const Direction north = Direction(0, -1);
  static const Direction south = Direction(0, 1);
  static const Direction east = Direction(-1, 0);
  static const Direction west = Direction(1, 0);
  static const Direction northEast = Direction(-1, -1);
  static const Direction northWest = Direction(1, -1);
  static const Direction southEast = Direction(-1, 1);
  static const Direction southWest = Direction(1, 1);

  Direction operator +(Direction other) =>
      Direction(_row + other._row, _col + other._col);
}
