import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/adaptive_layout_widget.dart';
import '../../../../di/injection_container.dart';
import '../cubit/general/dashboard/general_dashboard_cubit.dart';
import '../cubit/general/dashboard/general_dashboard_state.dart';
import '../widgets/general/general_header.dart';
import '../widgets/general/general_task_card.dart';
import '../widgets/general/general_habit_card.dart';
import '../widgets/general/general_reflection_card.dart';

class GeneralDashboardPage extends StatelessWidget {
  const GeneralDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GeneralDashboardCubit>()..loadDashboard(),
      child: const GeneralDashboardView(),
    );
  }
}

class GeneralDashboardView extends StatelessWidget {
  const GeneralDashboardView({super.key});

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
              child: BlocBuilder<GeneralDashboardCubit, GeneralDashboardState>(
                builder: (context, state) {
                  if (state is GeneralDashboardLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GeneralDashboardLoaded) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const GeneralHeader(),
                        const SizedBox(height: 32),
                        _buildPriorityTasks(context, state),
                        const SizedBox(height: 24),
                        _buildHabitTracker(context, state),
                        const SizedBox(height: 24),
                        const GeneralReflectionCard(),
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

  Widget _buildPriorityTasks(BuildContext context, GeneralDashboardLoaded state) {
    return GlassCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Priority Tasks", style: AppStyles.body24(context)),
              Text("View All",
                  style: AppStyles.body14(context,
                      color: AppColors.primary, weight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 24),
          ...state.tasks.map((task) => GeneralTaskCard(task: task)),
        ],
      ),
    );
  }

  Widget _buildHabitTracker(BuildContext context, GeneralDashboardLoaded state) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Habit Tracker", style: AppStyles.body24(context)),
          const SizedBox(height: 20),
          ...state.habits.map((habit) => GeneralHabitCard(habit: habit)),
        ],
      ),
    );
  }
}
