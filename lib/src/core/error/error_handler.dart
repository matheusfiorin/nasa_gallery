import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nasa_gallery/src/core/error/exceptions.dart';
import 'package:nasa_gallery/src/core/error/failures.dart';

class ErrorHandler {
  static Failure handleError(Exception exception) {
    if (exception is ServerException) {
      return ServerFailure(exception.message);
    } else if (exception is CacheException) {
      return CacheFailure(exception.message);
    } else if (exception is NetworkException) {
      return NetworkFailure(exception.message);
    } else if (exception is InvalidDataException) {
      return InvalidDataFailure(exception.message);
    }
    return const ServerFailure('An unexpected error occurred');
  }

  static AppException handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return NetworkException(
          message: 'Connection timeout',
          originalException: error,
        );
      case DioErrorType.badResponse:
        return ServerException(
          message: getServerErrorMessage(error.response?.statusCode),
          code: error.response?.statusCode?.toString(),
          originalException: error,
        );
      case DioErrorType.unknown:
        if (error.error is SocketException) {
          return NetworkException(
            message: 'No internet connection',
            originalException: error,
          );
        }
        return ServerException(
          message: 'Unexpected error occurred',
          originalException: error,
        );
      default:
        return ServerException(
          message: 'Something went wrong',
          originalException: error,
        );
    }
  }

  static String getServerErrorMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Resource not found';
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      case 503:
        return 'Service unavailable';
      default:
        return 'Server error occurred';
    }
  }
}
