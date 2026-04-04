import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/ai_entities.dart';
import '../../domain/usecases/send_message_usecase.dart';
import 'ai_assistant_state.dart';

class AiAssistantCubit extends Cubit<AiAssistantState> {
  final SendMessageUseCase _sendMessageUseCase;

  AiAssistantCubit({required SendMessageUseCase sendMessageUseCase})
      : _sendMessageUseCase = sendMessageUseCase,
        super(const AiAssistantInitial()) {
    _initDashboard();
  }

  void _initDashboard() {
    emit(AiAssistantInitial(
      chatHistory: const [],
      suggestions: [
        QuickSuggestion(
          iconName: "auto_awesome",
          text: '"Remind me to buy flowers when I\'m near the market"',
          colorHex: "#E9C349",
        ),
        QuickSuggestion(
          iconName: "schedule",
          text: '"Plan my deep focus session for tomorrow at 9 AM"',
          colorHex: "#4EDEA3",
        ),
      ],
      contexts: [
        SmartContext(
          iconName: "directions_run",
          title: "Evening Walk",
          description: "Predicted for 6:30 PM based on habits",
        ),
      ],
    ));
  }

  /// Builds a serialized representation of the user's dashboard state
  /// to inject as system-prompt context so Gemini has local awareness.
  String _buildDashboardContext() {
    // In production this would serialize real Isar/local DB data.
    // For now we provide a representative mock snapshot.
    return '''
{
  "user": "Alex",
  "mode": "general",
  "today": "${DateTime.now().toIso8601String().split('T').first}",
  "tasks": [
    {"title": "Submit project report", "status": "pending", "priority": "high"},
    {"title": "Morning meditation", "status": "completed"},
    {"title": "Buy groceries", "status": "pending"}
  ],
  "habits": [
    {"name": "Drink water", "current": 5, "goal": 8},
    {"name": "Read 30 min", "current": 1, "goal": 1}
  ],
  "medications": [
    {"name": "Vitamin D", "time": "08:00 AM", "taken": true},
    {"name": "Iron supplement", "time": "02:00 PM", "taken": false}
  ],
  "upcoming_events": [
    {"title": "Team meeting", "time": "3:00 PM"},
    {"title": "Evening walk", "time": "6:30 PM"}
  ]
}
''';
  }

  void sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMessage = ChatMessage(text: text, isUser: true, timestamp: DateTime.now());
    final List<ChatMessage> history = List.from(state.chatHistory)..add(userMessage);

    emit(AiAssistantProcessing(
      chatHistory: history,
      suggestions: state.suggestions,
      contexts: state.contexts,
    ));

    try {
      // Build conversation history for the API
      final conversationHistory = history.map((msg) => {
        'role': msg.isUser ? 'user' : 'model',
        'text': msg.text,
      }).toList();

      final aiResponseText = await _sendMessageUseCase(
        message: text,
        conversationHistory: conversationHistory,
        dashboardContext: _buildDashboardContext(),
      );

      final aiMessage = ChatMessage(
        text: aiResponseText,
        isUser: false,
        timestamp: DateTime.now(),
      );

      emit(AiAssistantInitial(
        chatHistory: List.from(history)..add(aiMessage),
        suggestions: state.suggestions,
        contexts: state.contexts,
      ));
    } catch (e) {
      // On error, emit an error message as an AI bubble so the user sees feedback
      final errorMessage = ChatMessage(
        text: "I'm having trouble connecting right now. Please check your API key and internet connection and try again.",
        isUser: false,
        timestamp: DateTime.now(),
      );

      emit(AiAssistantError(
        chatHistory: List.from(history)..add(errorMessage),
        suggestions: state.suggestions,
        contexts: state.contexts,
        errorMessage: e.toString(),
      ));
    }
  }

  void applySuggestion(String text) {
    final cleanText = text.replaceAll('"', '');
    sendMessage(cleanText);
  }
}
