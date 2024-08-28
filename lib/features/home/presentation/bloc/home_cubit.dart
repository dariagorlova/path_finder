import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../index.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(HomeRepository homeRepository)
      : _homeRepository = homeRepository,
        super(HomeInitial());

  final HomeRepository _homeRepository;

  Future<void> fetchData(String url) async {
    emit(HomeLoading());
    try {
      final res = await _homeRepository.fetchData(url);
      emit(HomeSuccess(res));
    } catch (e) {
      emit(HomeError('Incorrect API base URL'));
    }
  }
}
