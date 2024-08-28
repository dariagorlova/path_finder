import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/index.dart';
import '../../index.dart';

part 'process_state.dart';

class ProcessCubit extends Cubit<ProcessState> {
  ProcessCubit(
    this.data,
    ProcessRepository repository,
  )   : _repository = repository,
        super(
          ProcessInitial(),
        );

  final List<GridData> data;
  final ProcessRepository _repository;

  Future<void> findShortestPath() async {
    emit(ProcessLoading(percent: 0));

    var step = (1 / data.length * 100).toInt();
    try {
      var i = 1;
      final List<List<Coordinate>> result = [];
      for (final e in data) {
        final res = await _repository.findShortestPath(e);
        result.add(res);
        emit(ProcessLoading(percent: step * i++));
      }
      emit(ProcessDone(data: result));
    } catch (e) {
      emit(ProcessError('error text'));
    }
  }

  Future<void> pushResultsToServer() async {
    final paths = state is ProcessDone ? (state as ProcessDone).data : null;
    if (paths == null) {
      emit(ProcessError('Get back to previous screen and try again'));
    }
    emit(ProcessUploading());
    try {
      final response = await _repository.pushResults(
        ids: data.map((e) => e.id).toList(),
        paths: paths!,
      );

      if (response.indexWhere((e) => e.correct == false) == -1) {
        final fields = data.map((e) => e.field).toList();
        final dataOutput = <ResultModel>[];
        for (var i = 0; i < paths.length; i++) {
          dataOutput.add(ResultModel(field: fields[i], steps: paths[i]));
        }

        emit(ProcessUploadDone(dataOutput));
      } else {
        emit(ProcessError('Some tasks are incorrect'));
      }
    } catch (e) {
      emit(ProcessError('Something went wrong'));
    }
  }
}
