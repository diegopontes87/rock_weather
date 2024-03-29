import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rock_weather/shared/adapters/connection/connection_adapter.dart';
import 'package:rock_weather/shared/errors/app_error.dart';
import 'package:rock_weather/shared/http/app_request.dart';

class HttpClient {
  final Dio dio;
  final int successResultCode = 200;
  final ConnectionAdapter connectionAdapter;

  HttpClient({
    required this.dio,
    required this.connectionAdapter,
  });

  Future<Map<String, dynamic>> request(AppRequest request) async {
    try {
      await checkAppConnection();
      final response = await dio.request(
        request.path,
        queryParameters: request.queryParameters,
        options: Options(
          method: request.method.type,
        ),
      );
      if (response.statusCode == successResultCode) {
        return response.data;
      }
      throw AppError(errorType: AppErrorType.serviceError);
    } catch (e) {
      log('Error trying to make a request to the ${request.path} path: $e');
      throw AppError(errorType: AppErrorType.untrackedError);
    }
  }

  Future<void> checkAppConnection() async {
    final hasConnection = await connectionAdapter.hasConnection();
    if (!hasConnection) {
      throw AppError(errorType: AppErrorType.noConnectionError);
    }
  }
}
