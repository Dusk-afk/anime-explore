import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions, err);
          case 401:
          case 403:
            throw UnauthorizedException(err.requestOptions, err);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 412:
            throw ValidationFailedException(err, err.requestOptions);
          case 429:
            throw RateLimitedException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions, err: err);
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.badCertificate:
        throw BadCertificateException(err.requestOptions);
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        throw NoInternetConnectionException(err.requestOptions);
    }

    return handler.next(err);
  }
}

class BadRequestException extends DioException {
  DioException? err;
  BadRequestException(RequestOptions r, [this.err])
      : super(requestOptions: r, response: err?.response);

  @override
  String toString() {
    try {
      return err!.response!.data['message'];
    } catch (e) {
      return 'Invalid request';
    }
  }
}

class InternalServerErrorException extends DioException {
  DioException? err;
  InternalServerErrorException(RequestOptions r, {this.err})
      : super(requestOptions: r, response: err?.response);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioException {
  DioException? err;
  UnauthorizedException(RequestOptions r, [this.err])
      : super(requestOptions: r);

  @override
  String toString() {
    if (requestOptions.uri.path.contains('/login')) {
      return err!.response!.data['message'];
    }

    return 'Access denied';
  }
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}

class AccessDeniedException extends DioException {
  final DioException err;
  AccessDeniedException(this.err, RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    String errorMessage = "Access Denied";
    try {
      errorMessage = err.response!.data['message'];
    } catch (e) {
      // pass
    }

    return errorMessage;
  }
}

class ValidationFailedException extends DioException {
  final DioException err;
  ValidationFailedException(this.err, RequestOptions r)
      : super(requestOptions: r);

  @override
  String toString() {
    String errorMessage = "Invalid input passed";
    try {
      errorMessage = err.response!.data['message'];
    } catch (e) {
      // pass
    }

    return errorMessage;
  }
}

class TokenExpiredException extends DioException {
  TokenExpiredException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Token expired, please login again.';
  }
}

class BadCertificateException extends DioException {
  BadCertificateException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Bad certificate, please try again.';
  }
}

class RateLimitedException extends DioException {
  RateLimitedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Rate limited, please try again later.';
  }
}
