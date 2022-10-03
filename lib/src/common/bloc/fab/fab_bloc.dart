import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fab_event.dart';
part 'fab_state.dart';

class FabBloc extends Bloc<FabEvent, FabState> {
  FabBloc._internal() : super(const FabInitial()) {
    on<FabToggle>(_toggle);
  }

  static final FabBloc _instance = FabBloc._internal();

  factory FabBloc() => _instance;

  void _toggle(FabToggle event, emit) {
    event.isHidden ? emit(const FabHidden()) : emit(const FabShown());
  }
}
