import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'appbar_event.dart';
part 'appbar_state.dart';

class AppbarBloc extends Bloc<AppbarEvent, AppbarState> {
  AppbarBloc._internal() : super(const AppbarInitial()) {
    on<AppbarToggle>(_toggle);
  }

  static final AppbarBloc _instance = AppbarBloc._internal();

  factory AppbarBloc() => _instance;

  void _toggle(AppbarToggle event, emit) {
    event.isHidden ? emit(const AppbarHidden()) : emit(const AppbarShown());
  }
}
