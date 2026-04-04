import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/alzheimer_models.dart';
import 'alzheimer_dashboard_state.dart';

class AlzheimerDashboardCubit extends Cubit<AlzheimerDashboardState> {
  AlzheimerDashboardCubit() : super(AlzheimerDashboardLoading());

  void loadDashboard() async {
    await Future.delayed(const Duration(milliseconds: 500));

    emit(AlzheimerDashboardLoaded(
      patientName: "Thomas",
      dateAndWeather: "Today is Tuesday, October 24th. The weather is sunny and warm.",
      nextMedication: AlzheimerMedicationItem(
        medicineName: "Donepezil",
        instructions: "Take with water at 10:00 AM",
      ),
      aiPrompt: AlzheimerAiPrompt(
        message: '"Thomas, your daughter Sarah called. She\'s coming over for lunch at 12:30."',
        suggestions: ["Who is Sarah?", "Where am I?"],
      ),
    ));
  }
  void triggerEmergency() async {
    if (state is AlzheimerDashboardLoaded) {
      final currentState = state as AlzheimerDashboardLoaded;
      emit(currentState.copyWith(alertMessage: "Calling 911 and Alerting Caregiver..."));
      await Future.delayed(const Duration(seconds: 1));
      emit(currentState.copyWith(alertMessage: "Emergency contacts notified successfully."));
      await Future.delayed(const Duration(seconds: 2));
      emit(currentState.copyWith(clearAlert: true));
    }
  }
}
