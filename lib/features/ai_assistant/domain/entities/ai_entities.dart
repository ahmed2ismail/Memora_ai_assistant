class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class QuickSuggestion {
  final String iconName;
  final String text;
  final String colorHex;

  QuickSuggestion({
    required this.iconName,
    required this.text,
    required this.colorHex,
  });
}

class SmartContext {
  final String iconName;
  final String title;
  final String description;

  SmartContext({
    required this.iconName,
    required this.title,
    required this.description,
  });
}
