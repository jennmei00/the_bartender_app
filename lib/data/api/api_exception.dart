import 'package:localization/localization.dart';

class AipException implements Exception {
  final String message;
  final String prefix;

  AipException({required this.message, required this.prefix});

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends AipException {
  FetchDataException([message])
      : super(message: message, prefix: "${'error_during_communication'.i18n()}: ");
}

class BadRequestException extends AipException {
  BadRequestException([message])
      : super(message: message, prefix: "${'invalid_request'.i18n()}: ");
}

class UnauthorizedException extends AipException {
  UnauthorizedException([message])
      : super(message: message, prefix: "${'unauthorized_request'.i18n()}: ");
}

class InvalidInputException extends AipException {
  InvalidInputException([message])
      : super(message: message, prefix: "${'invalid_input'.i18n()}: ");
}
