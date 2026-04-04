/// Abstract contract for AI communication.
/// The data layer implements this against the Gemini API.
abstract class AiRepository {
  /// Sends a user [message] to the AI model, along with a serialized
  /// [dashboardContext] that is injected as a hidden system-prompt so
  /// the model has awareness of the user's local state (tasks, meds, habits).
  ///
  /// Returns the AI-generated response string.
  Future<String> sendMessage({
    required String message,
    required List<Map<String, String>> conversationHistory,
    String? dashboardContext,
  });
}
