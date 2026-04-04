import 'package:flutter/material.dart';
import '../../cubit/student/detail/student_detail_state.dart';
import 'student_quick_action_card.dart';

class StudentDetailQuickActionsGrid extends StatelessWidget {
  final StudentDetailLoaded state;

  const StudentDetailQuickActionsGrid({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.5,
      children:
          state.quickActions.map((item) => StudentQuickActionCard(item: item)).toList(),
    );
  }
}
