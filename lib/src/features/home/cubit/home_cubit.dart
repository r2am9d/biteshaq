import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:biteshaq/src/features/home/models/home_model.dart';
import 'package:biteshaq/src/features/home/repositories/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repository) : super(const HomeInitial());

  final HomeRepository repository;

  Future<void> load() async {
    emit(const HomeLoading());
    try {
      final home = await repository.getHome();
      emit(HomeLoaded(home));
    } catch (e) {
      emit(const HomeFailure());
    }
  }
}
