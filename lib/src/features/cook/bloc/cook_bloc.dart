import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:biteshaq/src/features/cook/repository/cook_repository.dart';

part 'cook_event.dart';
part 'cook_state.dart';

// ? Singleton pattern avoided due to navigation
// ? Bloc gets recreated always upon triggering new beam location
class CookBloc extends Bloc<CookEvent, CookState> {
  CookBloc() : super(const CookInitial()) {
    on<CookFetch>(_fetch);
  }

  static final CookRepository _repository = CookRepository();

  void _fetch(CookFetch event, emit) async {
    try {
      if (event.request is Future) {
        emit(const CookLoading());
        final data = await (event.request as Future<dynamic>);
        if (data != null && data.isNotEmpty) {
          emit(CookSuccess(data));
        }
      }
    } catch (e) {
      emit(const CookFailure('Failed to fetch data. Is your device online?'));
    }
  }
}
