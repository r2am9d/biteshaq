import 'package:biteshaq/src/common/bloc/bottom_navbar/bottom_navbar_bloc.dart';

class BottomNavbarRepository {
  factory BottomNavbarRepository() => _instance;

  BottomNavbarRepository._internal();

  static final BottomNavbarRepository _instance =
      BottomNavbarRepository._internal();

  void toggle({bool isHidden = false}) {
    if (!BottomNavbarBloc().isClosed) {
      BottomNavbarBloc().add(BottomNavbarToggle(isHidden: isHidden));
    }
  }
}
