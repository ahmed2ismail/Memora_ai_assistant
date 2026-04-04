import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/student_models.dart';
import 'student_detail_state.dart';

class StudentDetailCubit extends Cubit<StudentDetailState> {
  StudentDetailCubit() : super(StudentDetailLoading());

  void loadDetails(String id) async {
    await Future.delayed(const Duration(milliseconds: 700));

    emit(StudentDetailLoaded(
      nextAwakeningTime: "07:30",
      nextAwakeningPeriod: "AM",
      timelineEvents: [
        TimelineEventItem(
          timeLabel: "09:00 AM",
          category: "Lecture",
          title: "Advanced Thermodynamics",
          subtitle: "Room 402 • Hall A",
          dotColorMode: "secondary",
        ),
        TimelineEventItem(
          timeLabel: "11:30 AM",
          category: "Assignment",
          title: "Submit Lab Report #4",
          subtitle: "Chemistry", // Using subtitle mapped differently in UI, we'll format it.
          isHighPriority: true,
          dotColorMode: "primary",
        ),
        TimelineEventItem(
          timeLabel: "02:00 PM",
          category: "Self Study",
          title: "Quantum Mechanics Intro",
          subtitle: "",
          dotColorMode: "outline",
        ),
      ],
      quickActions: [
        QuickActionItem(iconName: "auto_stories", label: "Library", colorMode: "primary"),
        QuickActionItem(iconName: "groups", label: "Groups", colorMode: "secondary"),
        QuickActionItem(iconName: "leaderboard", label: "Grades", colorMode: "onSurface"),
        QuickActionItem(iconName: "rocket_launch", label: "Explore", colorMode: "primary"),
      ],
    ));
  }

  void triggerAction(String actionName) async {
    if (state is StudentDetailLoaded) {
      final currentState = state as StudentDetailLoaded;
      emit(currentState.copyWith(alertMessage: "Processing $actionName..."));
      await Future.delayed(const Duration(seconds: 1));
      emit(currentState.copyWith(alertMessage: "$actionName successfully completed."));
      await Future.delayed(const Duration(seconds: 2));
      emit(currentState.copyWith(clearAlert: true));
    }
  }
}
