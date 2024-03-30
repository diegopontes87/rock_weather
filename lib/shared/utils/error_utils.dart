import 'package:rock_weather/shared/errors/app_error.dart';

abstract class ErrorUtils {
  static String handleError({required AppErrorType errorType}) {
    switch (errorType) {
      case AppErrorType.serviceError:
        return 'Service error. Unable to get data!';
      case AppErrorType.noConnectionError:
        return 'No internet available.\nPlease turn your network on and try again.';
      case AppErrorType.untrackedError:
        return 'An unexpected error occurred!';
    }
  }
}
