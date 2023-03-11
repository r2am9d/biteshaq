import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:biteshaq/src/common/bloc/network/network_bloc.dart';

class NetworkRepository {
  factory NetworkRepository() => _instance;

  NetworkRepository._internal();

  static final NetworkRepository _instance = NetworkRepository._internal();

  Future<void> checkNetwork() async {
    if (!NetworkBloc().isClosed) {
      final result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.none) {
        NetworkBloc().add(const NetworkNotify());
      } else {
        NetworkBloc().add(const NetworkNotify(isConnected: true));
      }
    }
  }

  void observeNetwork() {
    if (!NetworkBloc().isClosed) {
      Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          NetworkBloc().add(const NetworkNotify());
        } else {
          NetworkBloc().add(const NetworkNotify(isConnected: true));
        }
      });
    }
  }
}
