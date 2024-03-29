enum HttpMethod {
  get('GET'),
  post('POST'),
  put('PUT'),
  delete('DELETE');

  final String type;

  const HttpMethod(this.type);
}

abstract class AppRequest {
  String get path;
  HttpMethod get method;
  Map<String, dynamic> get queryParameters;
}
