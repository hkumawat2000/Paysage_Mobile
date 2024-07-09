import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectionInfo {
  Future<bool> get isConnected;
}

class ConnectionInfoImpl implements ConnectionInfo {
  ConnectionInfoImpl(this.connectivity);
  final Connectivity connectivity;


  @override
  Future<bool> get isConnected async {
    var result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
