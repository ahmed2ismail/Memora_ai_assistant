import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/general_models.dart';
import 'general_detail_state.dart';

class GeneralDetailCubit extends Cubit<GeneralDetailState> {
  GeneralDetailCubit() : super(GeneralDetailLoading());

  void loadDetails(String id) async {
    // Artificial latency for deep dive
    await Future.delayed(const Duration(milliseconds: 700));

    emit(GeneralDetailLoaded(
      detailId: id,
      pendingTasks: 4,
      locationReminder: LocationReminder(
        title: "Pick up dry cleaning",
        locationDescription: "Near 5th Avenue • 0.2 miles away",
      ),
      tasks: [
        DetailTaskItem(
          title: "Finalize Q4 Strategy Presentation",
          subtitle: "High Priority",
          isCompleted: false,
          tagColor: "#4EDEA3", // Will use explicit high priority boolean for UI anyway
          timeText: "14:00",
          isHighPriority: true,
        ),
        DetailTaskItem(
          title: "Review design system implementation",
          subtitle: "",
          isCompleted: false,
          tagColor: "#E9C349",
          timeText: "16:30",
          isHighPriority: false,
        ),
        DetailTaskItem(
          title: "Morning meditation",
          subtitle: "Done",
          isCompleted: true,
          tagColor: "#80929C",
          timeText: "08:00",
          isHighPriority: false,
        ),
      ],
      habits: [
        HabitItem(
          title: "Deep Work",
          percentage: 0.85,
          progressText: "12 Day Streak",
          colorHex: "#4EDEA3",
        ),
        HabitItem(
          title: "Stay Hydrated",
          percentage: 0.62,
          progressText: "5/8 Glasses",
          colorHex: "#E9C349",
        ),
        HabitItem(
          title: "Daily Reading",
          percentage: 0.15,
          progressText: "Just started",
          colorHex: "#80929C",
        ),
      ],
    ));
  }
}
