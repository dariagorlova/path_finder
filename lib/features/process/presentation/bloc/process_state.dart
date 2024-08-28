part of 'process_cubit.dart';

sealed class ProcessState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProcessInitial extends ProcessState {
  @override
  List<Object> get props => [];
}

class ProcessLoading extends ProcessState {
  final int percent;
  ProcessLoading({required this.percent});
  @override
  List<Object> get props => [percent];
}

class ProcessDone extends ProcessState {
  final List<List<Coordinate>> data;
  ProcessDone({required this.data});

  @override
  List<Object?> get props => [data];
}

class ProcessError extends ProcessState {
  final String message;
  ProcessError(this.message);
  @override
  List<Object?> get props => [message];
}

class ProcessUploading extends ProcessState {
  @override
  List<Object> get props => [];
}

class ProcessUploadDone extends ProcessState {
  final List<ResultModel> data;

  ProcessUploadDone(this.data);

  @override
  List<Object> get props => [data];
}
