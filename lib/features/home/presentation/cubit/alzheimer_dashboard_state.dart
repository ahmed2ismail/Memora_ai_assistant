import 'package:equatable/equatable.dart';
import '../../domain/entities/alzheimer_models.dart';

abstract class AlzheimerDashboardState extends Equatable {
  const AlzheimerDashboardState();
  @override
  List<Object> get props => [];
}

class AlzheimerDashboardLoading extends AlzheimerDashboardState {}

class AlzheimerDashboardLoaded extends AlzheimerDashboardState {
  final String patientName;
  final String dateAndWeather;
  final AlzheimerMedicationItem nextMedication;
  final AlzheimerAiPrompt aiPrompt;

  const AlzheimerDashboardLoaded({
    required this.patientName,
    required this.dateAndWeather,
    required this.nextMedication,
    required this.aiPrompt,
  });

  @override
  List<Object> get props => [patientName, dateAndWeather, nextMedication, aiPrompt];
}
