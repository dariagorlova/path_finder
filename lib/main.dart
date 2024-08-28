import 'package:flutter/material.dart';
import 'package:path_finder/core/extensions/bloc_extension.dart';
import 'package:path_finder/features/home/data/api_service.dart';
import 'package:path_finder/features/home/data/repository_impl.dart';
import 'package:path_finder/features/home/presentation/bloc/home_cubit.dart';
import 'package:path_finder/features/home/presentation/home_screen.dart';

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
