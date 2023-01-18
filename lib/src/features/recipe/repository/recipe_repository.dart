class RecipeRepository {
  RecipeRepository._internal();

  static final RecipeRepository _instance = RecipeRepository._internal();

  factory RecipeRepository() => _instance;

  // TODO: Fetch from firebase or local sql db
  Future<String?> get fetchRecipe {
    return Future.delayed(
      const Duration(seconds: 1),
      () => 'RECIPE_REPOSITORY',
    );
  }
}
