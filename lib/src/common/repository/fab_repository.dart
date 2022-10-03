import 'package:biteshaq/src/common/bloc/fab/fab_bloc.dart';

class FabRepository {
  FabRepository._internal();

  static final FabRepository _instance = FabRepository._internal();

  factory FabRepository() => _instance;

  void toggle({bool isHidden = false}) {
    if (!FabBloc().isClosed) {
      FabBloc().add(FabToggle(isHidden: isHidden));
    }
  }
}
