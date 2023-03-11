import 'package:biteshaq/src/common/bloc/appbar/appbar_bloc.dart';

class AppbarRepository {
  factory AppbarRepository() => _instance;

  AppbarRepository._internal();

  static final AppbarRepository _instance = AppbarRepository._internal();

  void toggle({bool isHidden = false}) {
    if (!AppbarBloc().isClosed) {
      AppbarBloc().add(AppbarToggle(isHidden: isHidden));
    }
  }
}
