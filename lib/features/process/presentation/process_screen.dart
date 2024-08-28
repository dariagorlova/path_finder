import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_finder/features/process/presentation/bloc/process_cubit.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({super.key});

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProcessCubit>().findShortestPath();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProcessCubit, ProcessState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is ProcessError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is ProcessUploadDone) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (_) => const ProcessScreen().createWithCubit(
          //       (context) =>
          //           ProcessCubit(state.homeModel, ProcessRepositoryImpl()),
          //     ),
          //   ),
          // );
        }
      },
      builder: (context, state) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('Process screen')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: state is ProcessDone,
                      child: const Text(
                        'All calculations are finished, you can send your results to server',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text('${(state is ProcessLoading ? state.percent : 100)}%')
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: Visibility(
                  visible: state is ProcessUploading,
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Visibility(
                  // button is visible only when calculations are done or while uploading results
                  visible: state is ProcessDone ||
                      state is ProcessUploading ||
                      state is ProcessError,
                  child: ElevatedButton(
                    // but while upploading it must be disabled
                    onPressed: state is ProcessDone || state is ProcessError
                        ? () {
                            context.read<ProcessCubit>().pushResultsToServer();
                          }
                        : null,
                    child: const Text('Send results to server'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
