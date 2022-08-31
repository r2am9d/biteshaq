class AppRouter {
  AppRouter._internal();

  // Named Routes
  static const homeRoute = '/';

  static const recipeRoute = '/recipe';
  static const recipeViewRoute = '/recipe/:id';

  static const cookRoute = '/cook';
  static const cookViewRoute = '/cook/:id';

  static const gameRoute = '/game';

  static final AppRouter _instance = AppRouter._internal();

  static AppRouter get instance => _instance;
}
