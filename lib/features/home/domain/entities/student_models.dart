class StudentTimelineItem {
  final String timeRange;
  final String title;
  final String description;
  final String dotColorHex;
  final bool isActive;

  StudentTimelineItem({
    required this.timeRange,
    required this.title,
    required this.description,
    required this.dotColorHex,
    this.isActive = false,
  });
}

class StudentInsightMetrics {
  final String smartInsightMessage;
  final int memoryRecallPercentage;
  final int habitStreak;

  StudentInsightMetrics({
    required this.smartInsightMessage,
    required this.memoryRecallPercentage,
    required this.habitStreak,
  });
}

class TimelineEventItem {
  final String timeLabel;
  final String title;
  final String subtitle;
  final String category;
  final bool isHighPriority;
  final String dotColorMode;

  TimelineEventItem({
    required this.timeLabel,
    required this.title,
    required this.subtitle,
    required this.category,
    this.isHighPriority = false,
    required this.dotColorMode,
  });
}

class QuickActionItem {
  final String iconName;
  final String label;
  final String colorMode;

  QuickActionItem({
    required this.iconName,
    required this.label,
    required this.colorMode,
  });
}
