part of 'network_bloc.dart';

abstract class NetworkEvent extends Equatable {
  const NetworkEvent();

  @override
  List<Object> get props => [];
}

class NetworkCheck extends NetworkEvent {
  const NetworkCheck();
}

class NetworkObserve extends NetworkEvent {
  const NetworkObserve();
}

class NetworkNotify extends NetworkEvent {
  const NetworkNotify({this.isConnected = false});

  final bool isConnected;
}
