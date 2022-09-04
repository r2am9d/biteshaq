part of 'network_bloc.dart';

abstract class NetworkState extends Equatable {
  const NetworkState();

  @override
  List<Object> get props => [];
}

class NetworkInitial extends NetworkState {
  const NetworkInitial();
}

class NetworkLoading extends NetworkState {
  const NetworkLoading();
}

class NetworkSuccess extends NetworkState {
  const NetworkSuccess();
}

class NetworkFailure extends NetworkState {
  const NetworkFailure();
}
