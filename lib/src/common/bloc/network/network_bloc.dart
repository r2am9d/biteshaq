import 'package:biteshaq/src/common/repository/network_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc._internal() : super(const NetworkInitial()) {
    on<NetworkCheck>(_check);
    on<NetworkObserve>(_observe);
    on<NetworkNotify>(_notify);
  }

  static final NetworkBloc _instance = NetworkBloc._internal();

  factory NetworkBloc() => _instance;

  void _check(event, emit) {
    NetworkRepository().checkNetwork();
  }

  void _observe(event, emit) {
    NetworkRepository().observeNetwork();
  }

  void _notify(NetworkNotify event, emit) {
    event.isConnected
        ? emit(const NetworkSuccess())
        : emit(const NetworkFailure());
  }
}
