import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:biteshaq/src/common/repository/network_repository.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  factory NetworkBloc() => _instance;

  NetworkBloc._internal() : super(const NetworkInitial()) {
    on<NetworkCheck>(_check);
    on<NetworkObserve>(_observe);
    on<NetworkNotify>(_notify);
  }

  static final NetworkBloc _instance = NetworkBloc._internal();

  Future<void> _check(event, emit) async {
    await NetworkRepository().checkNetwork();
  }

  void _observe(event, emit) {
    NetworkRepository().observeNetwork();
  }

  void _notify(NetworkNotify event, Emitter<NetworkState> emit) {
    event.isConnected
        ? emit(const NetworkSuccess())
        : emit(const NetworkFailure());
  }
}
