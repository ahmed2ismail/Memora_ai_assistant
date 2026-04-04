import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

// ─── Base Failure ──────────────────────────────────────────────────────────────

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

// ─── Server Failure (Dio + HTTP) ───────────────────────────────────────────────

class ServerFailure extends Failure {
  const ServerFailure({required super.message});

  /// Factory that maps every [DioException] type to a user-friendly message.
  ///
  /// Inspired by production patterns from the Bookly app architecture.
  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure(
          message: 'Connection timed out. Please check your internet and try again.',
        );
      case DioExceptionType.sendTimeout:
        return const ServerFailure(
          message: 'Request timed out while sending data. Please try again.',
        );
      case DioExceptionType.receiveTimeout:
        return const ServerFailure(
          message: 'Server took too long to respond. Please try again later.',
        );
      case DioExceptionType.badCertificate:
        return const ServerFailure(
          message: 'Secure connection failed. Please check your network.',
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromBadResponse(
          dioException.response?.statusCode ?? 0,
          dioException.response?.data,
        );
      case DioExceptionType.cancel:
        return const ServerFailure(
          message: 'Request was cancelled. Please try again.',
        );
      case DioExceptionType.connectionError:
        return const ServerFailure(
          message: 'No internet connection. Please check your network settings.',
        );
      case DioExceptionType.unknown:
        if (dioException.message?.contains('SocketException') ?? false) {
          return const ServerFailure(
            message: 'No internet connection. Please check your network settings.',
          );
        }
        return const ServerFailure(
          message: 'An unexpected error occurred. Please try again.',
        );
    }
  }

  /// Extracts a user-friendly message from an HTTP error response.
  ///
  /// Attempts to read the error message from the JSON body first,
  /// then falls back to standard HTTP status descriptions.
  factory ServerFailure.fromBadResponse(int statusCode, dynamic data) {
    // Try to extract a message from the JSON body
    final String? bodyMessage = _extractBodyMessage(data);

    switch (statusCode) {
      case 400:
        return ServerFailure(
          message: bodyMessage ?? 'Bad request. Please verify your input and try again.',
        );
      case 401:
        return ServerFailure(
          message: bodyMessage ?? 'Authentication failed. Please check your API key.',
        );
      case 403:
        return ServerFailure(
          message: bodyMessage ?? 'Access denied. You do not have permission for this resource.',
        );
      case 404:
        return ServerFailure(
          message: bodyMessage ?? 'The requested resource was not found.',
        );
      case 409:
        return ServerFailure(
          message: bodyMessage ?? 'Conflict detected. The resource may have been modified.',
        );
      case 422:
        return ServerFailure(
          message: bodyMessage ?? 'The server could not process your request. Please check your data.',
        );
      case 429:
        return ServerFailure(
          message: bodyMessage ?? 'Too many requests. Please wait a moment and try again.',
        );
      case 500:
        return ServerFailure(
          message: bodyMessage ?? 'Internal server error. Please try again later.',
        );
      case 502:
        return const ServerFailure(
          message: 'Bad gateway. The server is temporarily unavailable.',
        );
      case 503:
        return const ServerFailure(
          message: 'Service unavailable. Please try again later.',
        );
      default:
        return ServerFailure(
          message: bodyMessage ?? 'Something went wrong (HTTP $statusCode). Please try again.',
        );
    }
  }

  /// Attempts to extract an error message from the response body.
  ///
  /// Supports common JSON error structures:
  /// - `{ "error": { "message": "..." } }`
  /// - `{ "message": "..." }`
  /// - `{ "error": "..." }`
  static String? _extractBodyMessage(dynamic data) {
    if (data == null) return null;

    if (data is Map<String, dynamic>) {
      // Nested:  { "error": { "message": "..." } }
      if (data['error'] is Map<String, dynamic>) {
        final errorMap = data['error'] as Map<String, dynamic>;
        if (errorMap['message'] is String) return errorMap['message'] as String;
      }
      // Flat:  { "message": "..." }
      if (data['message'] is String) return data['message'] as String;
      // Flat:  { "error": "..." }
      if (data['error'] is String) return data['error'] as String;
    }

    return null;
  }
}

// ─── Gemini / AI Failure ───────────────────────────────────────────────────────

class GeminiFailure extends Failure {
  final GeminiErrorType errorType;

  const GeminiFailure({
    required super.message,
    this.errorType = GeminiErrorType.unknown,
  });

  /// Factory for Gemini SDK [GenerativeAIException] and related errors.
  ///
  /// Detects safety blocks, quota limits, invalid API keys, and model errors
  /// by inspecting the exception message string.
  factory GeminiFailure.fromGeminiException(Object exception) {
    final msg = exception.toString().toLowerCase();

    if (msg.contains('safety') || msg.contains('blocked')) {
      return const GeminiFailure(
        message: 'The AI response was blocked by safety filters. Please rephrase your message.',
        errorType: GeminiErrorType.safetyBlock,
      );
    }

    if (msg.contains('quota') || msg.contains('rate limit') || msg.contains('resource_exhausted')) {
      return const GeminiFailure(
        message: 'AI quota limit reached. Please wait a moment and try again.',
        errorType: GeminiErrorType.quotaExceeded,
      );
    }

    if (msg.contains('api key') || msg.contains('api_key') || msg.contains('invalid key') || msg.contains('permission_denied')) {
      return const GeminiFailure(
        message: 'Invalid API key. Please verify your Gemini API key in the .env file.',
        errorType: GeminiErrorType.invalidApiKey,
      );
    }

    if (msg.contains('model') && msg.contains('not found')) {
      return const GeminiFailure(
        message: 'The AI model is unavailable. Please check your model configuration.',
        errorType: GeminiErrorType.modelNotFound,
      );
    }

    if (msg.contains('timeout') || msg.contains('deadline')) {
      return const GeminiFailure(
        message: 'The AI took too long to respond. Please try again.',
        errorType: GeminiErrorType.timeout,
      );
    }

    if (msg.contains('network') || msg.contains('socket') || msg.contains('connection')) {
      return const GeminiFailure(
        message: 'Could not reach the AI service. Please check your internet connection.',
        errorType: GeminiErrorType.networkError,
      );
    }

    return GeminiFailure(
      message: 'An AI error occurred: ${exception.toString().length > 100 ? '${exception.toString().substring(0, 100)}...' : exception.toString()}',
      errorType: GeminiErrorType.unknown,
    );
  }

  @override
  List<Object> get props => [message, errorType];
}

/// Categorizes Gemini-specific error types for downstream handling.
enum GeminiErrorType {
  safetyBlock,
  quotaExceeded,
  invalidApiKey,
  modelNotFound,
  timeout,
  networkError,
  unknown,
}

// ─── Cache Failure ─────────────────────────────────────────────────────────────

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

// ─── Network Failure ───────────────────────────────────────────────────────────

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});
}
