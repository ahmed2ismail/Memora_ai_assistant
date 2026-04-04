import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/student_models.dart';
import 'student_dashboard_state.dart';

class StudentDashboardCubit extends Cubit<StudentDashboardState> {
  StudentDashboardCubit() : super(StudentDashboardLoading());

  void loadDashboard() async {
    await Future.delayed(const Duration(milliseconds: 600));

    emit(StudentDashboardLoaded(
      hoursFocused: 4.0,
      timelineItems: [
        StudentTimelineItem(
          timeRange: "09:00 - 11:30",
          title: "Advanced Neural Networks Study",
          description: "Library Room 402 • 3 Chapters Remaining",
          dotColorHex: "#4EDEA3", // primary
          isActive: true,
        ),
        StudentTimelineItem(
          timeRange: "13:00 - 14:00",
          title: "AI Smart Alarm Concepts",
          description: "Collaborative Workshop",
          dotColorHex: "#E9C349", // secondary
        ),
      ],
      metrics: StudentInsightMetrics(
        smartInsightMessage: '"Your retention is 20% higher when you study between 9 AM and 11 AM. Ready for another session?"',
        memoryRecallPercentage: 85,
        habitStreak: 12,
      ),
    ));
  }
}
