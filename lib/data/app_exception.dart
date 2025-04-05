class AppException implements Exception {
  final String _message;
  final String _prefix;
  AppException(this._message, this._prefix);
  @override
  String toString() {
    return '$_message, $_prefix';
  }
}

class FetchDataException extends AppException {
  FetchDataException(String? message)
      : super(message!, 'Exception during Data Fetching!');
}

class BadRequestException extends AppException {
  BadRequestException(String? message)
      : super(message!, 'Bad request Exception!');
}

class UnauthorizedRequestException extends AppException {
  UnauthorizedRequestException(String? message)
      : super(message!, 'Unauthorized request Exception!');
}

class TimeOutRequestException extends AppException {
  TimeOutRequestException(String? message)
      : super(message!, 'Sever Request TimeOut Exception');
}
