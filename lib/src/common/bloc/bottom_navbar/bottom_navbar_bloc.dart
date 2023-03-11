import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navbar_event.dart';
part 'bottom_navbar_state.dart';

class BottomNavbarBloc extends Bloc<BottomNavbarEvent, BottomNavbarState> {
  factory BottomNavbarBloc() => _instance;

  BottomNavbarBloc._internal() : super(const BottomNavbarInitial()) {
    on<BottomNavbarToggle>(_toggle);
  }

  static final BottomNavbarBloc _instance = BottomNavbarBloc._internal();

  void _toggle(BottomNavbarToggle event, Emitter<BottomNavbarState> emit) {
    event.isHidden
        ? emit(const BottomNavbarHidden())
        : emit(const BottomNavbarShown());
  }
}
