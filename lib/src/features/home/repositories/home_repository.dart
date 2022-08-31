import 'package:biteshaq/src/features/home/models/home_model.dart';

class HomeRepository {
  Future<Home> getHome() async {
    await Future.delayed(const Duration(seconds: 5));
    return const Home(myString: 'HELLO');
  }
}
