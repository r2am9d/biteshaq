import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:biteshaq/src/features/home/bloc/network_bloc.dart';

class NetworkRepository {
  NetworkRepository._internal();

  static final NetworkRepository _instance = NetworkRepository._internal();

  factory NetworkRepository() => _instance;

  void checkNetwork() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      NetworkBloc().add(const NetworkNotify());
    } else {
      NetworkBloc().add(const NetworkNotify(isConnected: true));
    }
  }

  void observeNetwork() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        NetworkBloc().add(const NetworkNotify());
      } else {
        NetworkBloc().add(const NetworkNotify(isConnected: true));
      }
    });
  }
}
