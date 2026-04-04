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

class IdentityRecognitionData {
  final String instruction;
  final String imagePath;

  IdentityRecognitionData({
    required this.instruction,
    required this.imagePath,
  });
}

class DetailMedicineItem {
  final String timeLabel;
  final String name;
  final String dosageDescription;
  final bool isTaken;
  final String type;

  DetailMedicineItem({
    required this.timeLabel,
    required this.name,
    required this.dosageDescription,
    this.isTaken = false,
    required this.type,
  });
}

class SafeZoneData {
  final String locationName;
  final String mapImagePath;

  SafeZoneData({
    required this.locationName,
    required this.mapImagePath,
  });
}
