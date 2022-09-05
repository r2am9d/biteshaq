class AppRouter {
  AppRouter._internal();

  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() => _instance;

  // Named Routes
  String get homeRoute => '/';

  String get recipeRoute => '/recipe';
  String get recipeViewRoute => '/recipe/:id';

  String get cookRoute => '/cook';
  String get cookViewRoute => '/cook/:id';

  String get gameRoute => '/game';
}
