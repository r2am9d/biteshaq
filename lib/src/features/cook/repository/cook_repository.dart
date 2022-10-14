class CookRepository {
  CookRepository._internal();

  static final CookRepository _instance = CookRepository._internal();

  factory CookRepository() => _instance;

  // TODO: Fetch from firebase or local sql db
  Future<String?> get fetchCook {
    return Future.delayed(
      const Duration(seconds: 1),
      () => 'COOK_REPOSITORY',
    );
  }
}
