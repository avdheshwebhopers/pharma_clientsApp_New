class AppException implements Exception {
  final dynamic _message;
  final dynamic _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class ValidationException extends AppException {
  ValidationException([message]) : super(message, "Validation error: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class ForbiddenException extends AppException {
  ForbiddenException([String? message]) : super(message, "Forbidden: ");
}

class NotFoundException extends AppException {
  NotFoundException([String? message]) : super(message, "Not Found: ");
}

class ServerErrorException extends AppException {
  ServerErrorException([String? message]) : super(message, "Server Error: ");
}

class UnProcessableException extends AppException {
  UnProcessableException([String? message]) : super(message, "UnProcessable Exception: ");
}
