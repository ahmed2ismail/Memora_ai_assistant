/// Thrown when an API or server call fails (HTTP / gRPC).
class ServerException implements Exception {
  final String? message;
  const ServerException([this.message]);

  @override
  String toString() => message ?? 'ServerException';
}

/// Thrown when a local cache read/write operation fails.
class CacheException implements Exception {
  final String? message;
  const CacheException([this.message]);

  @override
  String toString() => message ?? 'CacheException';
}

/// Thrown when a network connectivity issue is detected.
class NetworkException implements Exception {
  final String? message;
  const NetworkException([this.message]);

  @override
  String toString() => message ?? 'NetworkException';
}

/// Thrown when the Gemini SDK returns an error
/// (safety block, quota, invalid key, etc.)
class GeminiException implements Exception {
  final String? message;
  const GeminiException([this.message]);

  @override
  String toString() => message ?? 'GeminiException';
}
