part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

class RecipeFetch extends RecipeEvent {
  const RecipeFetch({this.request = ''});

  final dynamic request;
}
