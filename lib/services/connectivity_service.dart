// Service for checking internet connection.
// When the connection changes the Stream Provider
// would capture it and make relevant changes to ui

import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dog_ceo/components/connectivity_status.dart';

class ConnectivityService {
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      //Parse to enum
      var connectionStatus = _getStatusFromResult(result);

      connectionStatusController.add(connectionStatus);
    });
  }
}

ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
  switch (result) {
    case ConnectivityResult.mobile:
      return ConnectivityStatus.Cellular;
    case ConnectivityResult.wifi:
      return ConnectivityStatus.WiFi;
    case ConnectivityResult.none:
      return ConnectivityStatus.Offline;
    default:
      return ConnectivityStatus.Offline;
  }
}
