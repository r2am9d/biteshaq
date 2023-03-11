import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fab_event.dart';
part 'fab_state.dart';

class FabBloc extends Bloc<FabEvent, FabState> {
  factory FabBloc() => _instance;

  FabBloc._internal() : super(const FabInitial()) {
    on<FabToggle>(_toggle);
  }

  static final FabBloc _instance = FabBloc._internal();

  void _toggle(FabToggle event, Emitter<FabState> emit) {
    event.isHidden ? emit(const FabHidden()) : emit(const FabShown());
  }
}
