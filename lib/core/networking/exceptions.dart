class CustomException implements Exception {
  final String? code;
  final String? message;
  final String? prefix;

  CustomException({this.message, this.code, this.prefix});

  @override
  String toString() {
    return "$code$prefix$message";
  }
}

class ServerException extends CustomException {
  ServerException({message, code})
      : super(code: code.toString(), message: message.toString(), prefix: "Server Exception: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message: message, prefix: "Invalid Request: ");
}

class FetchDataException extends CustomException {
  FetchDataException([String? code, String? message])
      : super(code: code, message: message, prefix: "Error During Communication: ");
}

class UnauthorizedException extends CustomException {
  UnauthorizedException([message]) : super(message: message, prefix: "Unauthorized: ");
}
