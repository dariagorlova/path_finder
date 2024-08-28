import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_finder/features/home/domain/models/grid_model.dart';
import 'package:path_finder/features/home/domain/repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(HomeRepository homeRepository)
      : _homeRepository = homeRepository,
        super(HomeInitial());

  final HomeRepository _homeRepository;

  Future<void> fetchData(String url) async {
    emit(HomeLoading());
    try {
      //todo: remove delay for production
      await Future.delayed(const Duration(seconds: 2));

      final res = await _homeRepository.fetchData(url);
      emit(HomeSuccess(res));
    } catch (e) {
      emit(HomeError('Incorrect API base URL'));
    }
  }
}
