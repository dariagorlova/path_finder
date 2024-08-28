import 'dart:math';

import 'package:flutter/material.dart';

import '../../process/index.dart';
import '../index.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({
    required this.data,
    super.key,
  });

  final ResultModel data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final sideSize = min(size.width, size.height);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Preview screen'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: CustomPaint(
                  painter: GridPainter(data),
                  size: Size(sideSize, sideSize),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  data.steps.map((e) => e.toString()).toList().join('->'),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }
}
