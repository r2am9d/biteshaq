import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navbar_event.dart';
part 'bottom_navbar_state.dart';

class BottomNavbarBloc extends Bloc<BottomNavbarEvent, BottomNavbarState> {
  BottomNavbarBloc._internal() : super(const BottomNavbarInitial()) {
    on<BottomNavbarToggle>(_toggle);
  }

  static final BottomNavbarBloc _instance = BottomNavbarBloc._internal();

  factory BottomNavbarBloc() => _instance;

  void _toggle(BottomNavbarToggle event, emit) {
    event.isHidden
        ? emit(const BottomNavbarHidden())
        : emit(const BottomNavbarShown());
  }
}
