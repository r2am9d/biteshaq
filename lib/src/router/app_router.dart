class AppRouter {
  AppRouter._internal();

  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() => _instance;

  // Named Routes
  String get homeRoute => '/';

  String get recipeRoute => '/recipe';
  String get recipeViewRoute => '/recipe/view/:id';

  String get cookRoute => '/cook';
  String get cookViewRoute => '/cook/view/:id';

  String get gameRoute => '/game';

  String get cookLoadingRoute => '/cook/loading';
}
