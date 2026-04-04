import '../../domain/repositories/ai_repository.dart';
import '../datasources/gemini_remote_datasource.dart';

/// Concrete implementation of [AiRepository] backed by [GeminiRemoteDataSource].
class AiRepositoryImpl implements AiRepository {
  final GeminiRemoteDataSource remoteDataSource;

  AiRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> sendMessage({
    required String message,
    required List<Map<String, String>> conversationHistory,
    String? dashboardContext,
  }) async {
    return remoteDataSource.sendMessage(
      message: message,
      conversationHistory: conversationHistory,
    );
  }
}
