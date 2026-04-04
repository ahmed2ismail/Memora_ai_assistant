import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/adaptive_layout_widget.dart';
import '../../../../di/injection_container.dart';
import '../cubit/student/dashboard/student_dashboard_cubit.dart';
import '../cubit/student/dashboard/student_dashboard_state.dart';
import '../widgets/student/student_header.dart';
import '../widgets/student/student_timeline_card.dart';
import '../widgets/student/student_insight_card.dart';

class StudentDashboardPage extends StatelessWidget {
  const StudentDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<StudentDashboardCubit>()..loadDashboard(),
      child: const StudentDashboardView(),
    );
  }
}

class StudentDashboardView extends StatelessWidget {
  const StudentDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayoutWidget(
      mobile: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: SafeArea(
            top: true,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 120, left: 24, right: 24),
              child: BlocBuilder<StudentDashboardCubit, StudentDashboardState>(
                builder: (context, state) {
                  if (state is StudentDashboardLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is StudentDashboardLoaded) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StudentHeader(hoursFocused: state.hoursFocused),
                        const SizedBox(height: 32),
                        _buildTimelineSection(context, state),
                        const SizedBox(height: 32),
                        StudentInsightCard(metrics: state.metrics),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineSection(BuildContext context, StudentDashboardLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Timeline",
                style: AppStyles.custom(context, fontSize: 18, weight: FontWeight.bold)),
            Text("October 24", style: AppStyles.body14(context)),
          ],
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Stack(
            children: [
              Positioned(
                left: -1,
                top: 0,
                bottom: 0,
                width: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary, Colors.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Column(
                children:
                    state.timelineItems.map((item) => StudentTimelineCard(item: item)).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
