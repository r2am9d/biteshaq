import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:biteshaq/src/features/recipe/repository/recipe_repository.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

// ? Singleton pattern avoided due to navigation
// ? Bloc gets recreated always upon triggering new beam location
class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(const RecipeInitial()) {
    on<RecipeFetch>(_fetch);
  }

  static final RecipeRepository _repository = RecipeRepository();

  void _fetch(RecipeFetch event, emit) async {
    try {
      if (event.request is Future) {
        emit(const RecipeLoading());
        final data = await (event.request as Future<dynamic>);
        if (data != null && data.isNotEmpty) {
          emit(RecipeSuccess(data));
        }
      }
    } catch (e) {
      emit(const RecipeFailure('Failed to fetch data. Is your device online?'));
    }
  }
}
