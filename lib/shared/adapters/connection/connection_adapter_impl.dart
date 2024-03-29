import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rock_weather/shared/adapters/connection/connection_adapter.dart';

class ConnectionAdapterImpl implements ConnectionAdapter {
  @override
  Future<bool> hasConnection() async {
    final hasConnection = await Connectivity().checkConnectivity();
    return hasConnection.any((connection) => connection != ConnectivityResult.none);
  }
}
