enum AppErrorType {
  serviceError,
  untrackedError,
  noConnectionError,
}

class AppError implements Exception {
  final AppErrorType errorType;

  AppError({
    required this.errorType,
  });
}
