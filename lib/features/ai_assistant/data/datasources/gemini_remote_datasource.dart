import 'package:google_generative_ai/google_generative_ai.dart';

/// Direct integration point with the Google Generative AI (Gemini) SDK.
///
/// Wraps [GenerativeModel] and manages multi-turn chat sessions including
/// a hidden system instruction that carries serialized dashboard context
/// so responses are personalised.
class GeminiRemoteDataSource {
  final GenerativeModel _model;

  GeminiRemoteDataSource({required GenerativeModel model}) : _model = model;

  /// Sends a single-turn prompt to Gemini, providing the full conversation
  /// history as context.  The [systemInstruction] is baked into the model
  /// at construction time via DI, so callers don't need to re-send it.
  Future<String> sendMessage({
    required String message,
    required List<Map<String, String>> conversationHistory,
  }) async {
    // Build content history for multi-turn conversation
    final List<Content> history = conversationHistory.map((entry) {
      final role = entry['role'] == 'user' ? 'user' : 'model';
      return Content(role, [TextPart(entry['text'] ?? '')]);
    }).toList();

    // Start a chat session with existing history
    final chat = _model.startChat(history: history);

    // Send the latest user message
    final response = await chat.sendMessage(Content.text(message));

    return response.text ?? 'I wasn\'t able to formulate a response. Please try again.';
  }
}
