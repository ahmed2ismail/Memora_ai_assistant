class AlzheimerMedicationItem {
  final String medicineName;
  final String instructions;

  AlzheimerMedicationItem({
    required this.medicineName,
    required this.instructions,
  });
}

class AlzheimerAiPrompt {
  final String message;
  final List<String> suggestions;

  AlzheimerAiPrompt({
    required this.message,
    required this.suggestions,
  });
}
