import 'package:connectivity_plus/connectivity_plus.dart';

import '../error/failure.dart';

class NetworkInfo {
  static final connectionChecker = Connectivity();

  static Future<bool> get isConnected => connectionChecker
      .checkConnectivity()
      .then((value) => value != ConnectivityResult.none);

  static Future<void> checkConnection() async {
    final hasConnection = await connectionChecker.checkConnectivity();
    if (hasConnection == ConnectivityResult.none) {
      throw NoConnectionException();
    }
  }
}