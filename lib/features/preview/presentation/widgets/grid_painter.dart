import 'package:flutter/material.dart';
import 'package:path_finder/features/home/domain/models/coordinate_model.dart';
import 'package:path_finder/features/process/domain/model/result_model.dart';

class GridPainter extends CustomPainter {
  final ResultModel model;

  GridPainter(this.model);

  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = size.width / model.field.length;
    final paint = Paint();
    final border = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    for (int i = 0; i < model.field.length; i++) {
      for (int j = 0; j < model.field[i].length; j++) {
        final coord = Coordinate(x: j, y: i);
        var color = model.field[i][j] == '.' ? Colors.white : Colors.black;
        if (model.steps.contains(coord)) {
          if (coord == model.steps.last) {
            color = const Color(0xFF009688);
          } else if (coord == model.steps.first) {
            color = const Color(0xFF64FFDA);
          } else {
            color = const Color(0xFF4CAF50);
          }
        }

        canvas.drawRect(
          Rect.fromLTWH(j * cellSize, i * cellSize, cellSize, cellSize),
          paint..color = color,
        );
        canvas.drawRect(
          Rect.fromLTWH(j * cellSize, i * cellSize, cellSize, cellSize),
          border,
        );

        final center =
            Offset(j * cellSize + cellSize / 2, i * cellSize + cellSize / 2);

        final textPainter = TextPainter(
          text: TextSpan(
            text: coord.toString(),
            style: TextStyle(
              color: color == Colors.black ? Colors.white : Colors.black,
              fontSize: cellSize / coord.toString().length,
            ),
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(
          minWidth: 0,
          maxWidth: size.width,
        );
        // Calculate the position to center the text
        final offset = Offset(
          center.dx - textPainter.width / 2,
          center.dy - textPainter.height / 2,
        );

        // Draw the text on the canvas
        textPainter.paint(canvas, offset);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
