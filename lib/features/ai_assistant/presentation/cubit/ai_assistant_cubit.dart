import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/ai_entities.dart';
import 'ai_assistant_state.dart';

class AiAssistantCubit extends Cubit<AiAssistantState> {
  AiAssistantCubit() : super(const AiAssistantInitial()) {
    _initDashboard();
  }

  void _initDashboard() {
    emit(AiAssistantInitial(
      chatHistory: const [],
      suggestions: [
        QuickSuggestion(
          iconName: "auto_awesome",
          text: '"Remind me to buy flowers when I\'m near the market"',
          colorHex: "#E9C349", // secondary
        ),
        QuickSuggestion(
          iconName: "schedule",
          text: '"Plan my deep focus session for tomorrow at 9 AM"',
          colorHex: "#4EDEA3", // primary
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

  void sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMessage = ChatMessage(text: text, isUser: true, timestamp: DateTime.now());
    final List<ChatMessage> history = List.from(state.chatHistory)..add(userMessage);

    emit(AiAssistantProcessing(
      chatHistory: history,
      suggestions: state.suggestions,
      contexts: state.contexts,
    ));

    // Simulate AI processing latency
    await Future.delayed(const Duration(milliseconds: 1500));

    String aiResponseText = _getSimulatedResponse(text);
    final aiMessage = ChatMessage(text: aiResponseText, isUser: false, timestamp: DateTime.now());
    
    emit(AiAssistantInitial(
      chatHistory: List.from(history)..add(aiMessage),
      suggestions: state.suggestions,
      contexts: state.contexts,
    ));
  }

  String _getSimulatedResponse(String input) {
    input = input.toLowerCase();
    if (input.contains("remind") || input.contains("remember")) {
      return "Got it! I've securely stored that reminder for you. I'll notify you effectively when the time comes.";
    } else if (input.contains("plan") || input.contains("schedule")) {
      return "I've analyzed your schedule. You have a gap at 3 PM. Shall I set a dedicated reminder block?";
    } else if (input.contains("yes") || input.contains("please")) {
      return "Done. It's added to your daily ritual.";
    } else {
      return "I'm processing that context locally to ensure your privacy. Anything else you need me to remember?";
    }
  }

  void applySuggestion(String text) {
    // Trim the outer quotes from the suggestion text
    final cleanText = text.replaceAll('"', '');
    sendMessage(cleanText);
  }
}
