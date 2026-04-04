import '../repositories/ai_repository.dart';

/// Application-level use case for sending a message to the AI assistant.
///
/// Encapsulates the call to [AiRepository] so the presentation layer
/// stays ignorant of data-layer details.
class SendMessageUseCase {
  final AiRepository repository;

  SendMessageUseCase(this.repository);

  /// Executes the use case with the given [message], [conversationHistory],
  /// and optional serialized [dashboardContext].
  Future<String> call({
    required String message,
    required List<Map<String, String>> conversationHistory,
    String? dashboardContext,
  }) {
    return repository.sendMessage(
      message: message,
      conversationHistory: conversationHistory,
      dashboardContext: dashboardContext,
    );
  }
}
