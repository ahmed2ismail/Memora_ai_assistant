class TaskItem {
  final String title;
  final String subtitle;
  final bool isCompleted;
  final String tagColor;

  TaskItem({
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
    required this.tagColor,
  });
}

class HabitItem {
  final String title;
  final String progressText;
  final double percentage;
  final String colorHex;

  HabitItem({
    required this.title,
    required this.progressText,
    required this.percentage,
    required this.colorHex,
  });
}

class LocationReminder {
  final String title;
  final String locationDescription;

  LocationReminder({
    required this.title,
    required this.locationDescription,
  });
}

class DetailTaskItem extends TaskItem {
  final String timeText;
  final bool isHighPriority;

  DetailTaskItem({
    required super.title,
    required super.subtitle,
    required super.isCompleted,
    required super.tagColor,
    required this.timeText,
    required this.isHighPriority,
  });
}
