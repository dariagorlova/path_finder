import 'package:flutter/material.dart';
import 'core/index.dart';
import 'features/home/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Path finder Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen().createWithCubit(
          (context) => HomeCubit(HomeRepositoryImpl(HomeApiServiceImpl()))),
    );
  }
}
