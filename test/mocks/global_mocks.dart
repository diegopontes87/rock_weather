import 'package:mocktail/mocktail.dart';
import 'package:rock_weather/shared/adapters/local_storage/local_storage_adapter_impl.dart';
import 'package:rock_weather/shared/http/http_client.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockLocalStorageAdapterImpl extends Mock implements LocalStorageAdapterImpl {}
