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
