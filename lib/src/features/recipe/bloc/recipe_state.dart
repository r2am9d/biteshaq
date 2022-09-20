part of 'recipe_bloc.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object> get props => [];
}

class RecipeInitial extends RecipeState {
  const RecipeInitial();
}

class RecipeLoading extends RecipeState {
  const RecipeLoading();
}

class RecipeSuccess extends RecipeState {
  const RecipeSuccess(this.data);

  final String data;
}

class RecipeFailure extends RecipeState {
  const RecipeFailure(this.message);

  final String? message;
}
