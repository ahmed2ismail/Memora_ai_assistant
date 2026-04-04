import 'package:equatable/equatable.dart';
import '../../domain/entities/ai_entities.dart';

abstract class AiAssistantState extends Equatable {
  final List<ChatMessage> chatHistory;
  final List<QuickSuggestion> suggestions;
  final List<SmartContext> contexts;

  const AiAssistantState({
    this.chatHistory = const [],
    this.suggestions = const [],
    this.contexts = const [],
  });

  @override
  List<Object> get props => [chatHistory, suggestions, contexts];
}

class AiAssistantInitial extends AiAssistantState {
  const AiAssistantInitial({
    super.chatHistory,
    super.suggestions,
    super.contexts,
  });
}

class AiAssistantProcessing extends AiAssistantState {
  const AiAssistantProcessing({
    super.chatHistory,
    super.suggestions,
    super.contexts,
  });
}

class AiAssistantError extends AiAssistantState {
  final String errorMessage;
  const AiAssistantError({
    super.chatHistory,
    super.suggestions,
    super.contexts,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [...super.props, errorMessage];
}
