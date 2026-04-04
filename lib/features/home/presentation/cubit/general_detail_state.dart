import 'package:equatable/equatable.dart';
import '../../domain/entities/general_models.dart';

abstract class GeneralDetailState extends Equatable {
  const GeneralDetailState();
  @override
  List<Object> get props => [];
}

class GeneralDetailLoading extends GeneralDetailState {}

class GeneralDetailLoaded extends GeneralDetailState {
  final String detailId;
  final LocationReminder locationReminder;
  final List<DetailTaskItem> tasks;
  final List<HabitItem> habits;
  final int pendingTasks;

  const GeneralDetailLoaded({
    required this.detailId,
    required this.locationReminder,
    required this.tasks,
    required this.habits,
    required this.pendingTasks,
  });

  @override
  List<Object> get props => [detailId, locationReminder, tasks, habits, pendingTasks];
}
