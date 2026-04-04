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
