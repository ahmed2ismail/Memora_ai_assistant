import 'package:equatable/equatable.dart';
import '../../../../domain/entities/alzheimer_models.dart';

abstract class AlzheimerDashboardState extends Equatable {
  const AlzheimerDashboardState();
  @override
  List<Object?> get props => [];
}

class AlzheimerDashboardLoading extends AlzheimerDashboardState {}

class AlzheimerDashboardLoaded extends AlzheimerDashboardState {
  final String patientName;
  final String dateAndWeather;
  final AlzheimerMedicationItem nextMedication;
  final AlzheimerAiPrompt aiPrompt;
  final String? alertMessage;
  // Unique timestamp ensures every emit() is treated as a new state
  // by Equatable, so BlocConsumer listeners always fire correctly.
  final DateTime _ts;

  AlzheimerDashboardLoaded({
    required this.patientName,
    required this.dateAndWeather,
    required this.nextMedication,
    required this.aiPrompt,
    this.alertMessage,
  }) : _ts = DateTime.now();

  AlzheimerDashboardLoaded copyWith({
    String? patientName,
    String? dateAndWeather,
    AlzheimerMedicationItem? nextMedication,
    AlzheimerAiPrompt? aiPrompt,
    String? alertMessage,
    bool clearAlert = false,
  }) {
    return AlzheimerDashboardLoaded(
      patientName: patientName ?? this.patientName,
      dateAndWeather: dateAndWeather ?? this.dateAndWeather,
      nextMedication: nextMedication ?? this.nextMedication,
      aiPrompt: aiPrompt ?? this.aiPrompt,
      alertMessage: clearAlert ? null : (alertMessage ?? this.alertMessage),
    );
  }

  @override
  List<Object?> get props => [patientName, dateAndWeather, nextMedication, aiPrompt, alertMessage, _ts];
}
