import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'appbar_event.dart';
part 'appbar_state.dart';

class AppbarBloc extends Bloc<AppbarEvent, AppbarState> {
  factory AppbarBloc() => _instance;

  AppbarBloc._internal() : super(const AppbarInitial()) {
    on<AppbarToggle>(_toggle);
  }

  static final AppbarBloc _instance = AppbarBloc._internal();

  void _toggle(AppbarToggle event, Emitter<AppbarState> emit) {
    event.isHidden ? emit(const AppbarHidden()) : emit(const AppbarShown());
  }
}
