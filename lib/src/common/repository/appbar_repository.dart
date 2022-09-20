import 'package:biteshaq/src/common/bloc/appbar/appbar_bloc.dart';

class AppbarRepository {
  AppbarRepository._internal();

  static final AppbarRepository _instance = AppbarRepository._internal();

  factory AppbarRepository() => _instance;

  void toggle({bool isHidden = false}) {
    if (!AppbarBloc().isClosed) {
      AppbarBloc().add(AppbarToggle(isHidden: isHidden));
    }
  }
}
