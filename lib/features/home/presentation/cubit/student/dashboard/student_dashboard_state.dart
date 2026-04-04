import 'package:equatable/equatable.dart';
import '../../../../domain/entities/student_models.dart';

abstract class StudentDashboardState extends Equatable {
  const StudentDashboardState();
  @override
  List<Object> get props => [];
}

class StudentDashboardLoading extends StudentDashboardState {}

class StudentDashboardLoaded extends StudentDashboardState {
  final List<StudentTimelineItem> timelineItems;
  final StudentInsightMetrics metrics;
  final double hoursFocused;

  const StudentDashboardLoaded({
    required this.timelineItems,
    required this.metrics,
    required this.hoursFocused,
  });

  @override
  List<Object> get props => [timelineItems, metrics, hoursFocused];
}
