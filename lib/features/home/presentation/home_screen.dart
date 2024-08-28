import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_finder/core/extensions/bloc_extension.dart';
import 'package:path_finder/features/home/presentation/bloc/home_cubit.dart';
import 'package:path_finder/features/process/data/api_service.dart';
import 'package:path_finder/features/process/data/repository_impl.dart';
import 'package:path_finder/features/process/presentation/bloc/process_cubit.dart';
import 'package:path_finder/features/process/presentation/process_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = 'https://flutter.webspark.dev/flutter/api';
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is HomeError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is HomeSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ProcessScreen().createWithCubit(
                (context) => ProcessCubit(state.homeModel,
                    ProcessRepositoryImpl(ProcessApiServiceImpl())),
              ),
            ),
          );
        }
      },
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('Home screen')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Set valid API base URL in order to continue'),
              Row(
                children: [
                  const Icon(Icons.swap_horiz),
                  const SizedBox(width: 16),
                  Expanded(child: TextField(controller: _controller)),
                ],
              ),
              Expanded(
                child: Visibility(
                  visible: state is HomeLoading,
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state is HomeLoading
                      ? null
                      : () =>
                          context.read<HomeCubit>().fetchData(_controller.text),
                  child: const Text('Start counting process'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
