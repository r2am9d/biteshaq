import 'package:biteshaq/src/common/bloc/fab/fab_bloc.dart';

class FabRepository {
  factory FabRepository() => _instance;

  FabRepository._internal();

  static final FabRepository _instance = FabRepository._internal();

  void toggle({bool isHidden = false}) {
    if (!FabBloc().isClosed) {
      FabBloc().add(FabToggle(isHidden: isHidden));
    }
  }
}
