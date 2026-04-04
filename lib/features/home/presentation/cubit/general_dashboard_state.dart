import 'package:equatable/equatable.dart';
import '../../domain/entities/general_models.dart';

abstract class GeneralDashboardState extends Equatable {
  const GeneralDashboardState();
  @override
  List<Object> get props => [];
}

class GeneralDashboardLoading extends GeneralDashboardState {}

class GeneralDashboardLoaded extends GeneralDashboardState {
  final List<TaskItem> tasks;
  final List<HabitItem> habits;

  const GeneralDashboardLoaded({required this.tasks, required this.habits});

  @override
  List<Object> get props => [tasks, habits];
}
