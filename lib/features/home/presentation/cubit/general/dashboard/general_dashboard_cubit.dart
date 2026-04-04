import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/general_models.dart';
import 'general_dashboard_state.dart';

class GeneralDashboardCubit extends Cubit<GeneralDashboardState> {
  GeneralDashboardCubit() : super(GeneralDashboardLoading());

  void loadDashboard() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    emit(GeneralDashboardLoaded(
      tasks: [
        TaskItem(title: "Finalize Quarterly Report", subtitle: "Due at 5:00 PM", tagColor: "#4EDEA3"),
        TaskItem(title: "Buy Anniversary Flowers", subtitle: "Location: Bloom & Co.", tagColor: "#E9C349"),
        TaskItem(title: "Call Insurance Agency", subtitle: "Completed", isCompleted: true, tagColor: "#4EDEA3"),
      ],
      habits: [
        HabitItem(title: "Hydration", progressText: "1.8 / 2.5 L", percentage: 0.72, colorHex: "#4EDEA3"),
        HabitItem(title: "Meditation", progressText: "15 / 20 min", percentage: 0.60, colorHex: "#E9C349"),
      ],
    ));
  }
}
