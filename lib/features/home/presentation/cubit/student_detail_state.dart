import 'package:equatable/equatable.dart';
import '../../domain/entities/student_models.dart';

abstract class StudentDetailState extends Equatable {
  const StudentDetailState();
  @override
  List<Object> get props => [];
}

class StudentDetailLoading extends StudentDetailState {}

class StudentDetailLoaded extends StudentDetailState {
  final String nextAwakeningTime;
  final String nextAwakeningPeriod;
  final List<TimelineEventItem> timelineEvents;
  final List<QuickActionItem> quickActions;

  const StudentDetailLoaded({
    required this.nextAwakeningTime,
    required this.nextAwakeningPeriod,
    required this.timelineEvents,
    required this.quickActions,
  });

  @override
  List<Object> get props => [nextAwakeningTime, nextAwakeningPeriod, timelineEvents, quickActions];
}
