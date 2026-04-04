import 'package:equatable/equatable.dart';
import '../../../../domain/entities/student_models.dart';

abstract class StudentDetailState extends Equatable {
  const StudentDetailState();
  @override
  List<Object?> get props => [];
}

class StudentDetailLoading extends StudentDetailState {}

class StudentDetailLoaded extends StudentDetailState {
  final String nextAwakeningTime;
  final String nextAwakeningPeriod;
  final List<TimelineEventItem> timelineEvents;
  final List<QuickActionItem> quickActions;
  final String? alertMessage;

  const StudentDetailLoaded({
    required this.nextAwakeningTime,
    required this.nextAwakeningPeriod,
    required this.timelineEvents,
    required this.quickActions,
    this.alertMessage,
  });

  StudentDetailLoaded copyWith({
    String? nextAwakeningTime,
    String? nextAwakeningPeriod,
    List<TimelineEventItem>? timelineEvents,
    List<QuickActionItem>? quickActions,
    String? alertMessage,
    bool clearAlert = false,
  }) {
    return StudentDetailLoaded(
      nextAwakeningTime: nextAwakeningTime ?? this.nextAwakeningTime,
      nextAwakeningPeriod: nextAwakeningPeriod ?? this.nextAwakeningPeriod,
      timelineEvents: timelineEvents ?? this.timelineEvents,
      quickActions: quickActions ?? this.quickActions,
      alertMessage: clearAlert ? null : (alertMessage ?? this.alertMessage),
    );
  }

  @override
  List<Object?> get props => [nextAwakeningTime, nextAwakeningPeriod, timelineEvents, quickActions, alertMessage];
}
