import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:rock_weather/shared/adapters/connection/connection_adapter.dart';

class ConnectionAdapterImpl implements ConnectionAdapter {
  @override
  Future<bool> hasConnection() async {
    return await InternetConnection().hasInternetAccess;
  }
}
