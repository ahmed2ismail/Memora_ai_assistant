import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../di/injection_container.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/general_models.dart';
import '../cubit/general_dashboard_cubit.dart';
import '../cubit/general_dashboard_state.dart';

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

  Color _fromHex(String hexString) {
    var buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 100, bottom: 120, left: 24, right: 24),
      child: BlocBuilder<GeneralDashboardCubit, GeneralDashboardState>(
        builder: (context, state) {
          if (state is GeneralDashboardLoading) {
            return const Center(child: Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: CircularProgressIndicator(),
            ));
          } else if (state is GeneralDashboardLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 32),
                _buildPriorityTasks(context, state.tasks),
                const SizedBox(height: 24),
                _buildHabitTracker(context, state.habits),
                const SizedBox(height: 24),
                _buildReflection(context),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Daily Logistics", style: Theme.of(context).textTheme.headlineLarge),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text("Today", style: TextStyle(color: AppColors.onSurfaceVariant)),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => {
                // Must import go_router to jump to details over the shell
                GoRouter.of(context).push('/dashboard/details/today')
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text("Overview", style: TextStyle(color: AppColors.primary)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriorityTasks(BuildContext context, List<TaskItem> tasks) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Priority Tasks", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
              const Text("View All", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 24),
          ...tasks.map((task) => _buildTaskItem(context, task)),
        ],
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, TaskItem task) {
    final color = _fromHex(task.tagColor);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: task.isCompleted ? Colors.transparent : color, width: 4)),
      ),
      child: Row(
        children: [
          Icon(
            task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: task.isCompleted ? AppColors.primary : AppColors.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                    color: task.isCompleted ? AppColors.onSurfaceVariant : AppColors.onSurface,
                  ),
                ),
                if (!task.isCompleted)
                  Text(task.subtitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          if (!task.isCompleted)
            const Icon(Icons.drag_indicator, color: AppColors.onSurfaceVariant),
        ],
      ),
    );
  }

  Widget _buildHabitTracker(BuildContext context, List<HabitItem> habits) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Habit Tracker", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 20),
          ...habits.map((habit) => _buildHabitItem(habit)),
        ],
      ),
    );
  }

  Widget _buildHabitItem(HabitItem habit) {
    final color = _fromHex(habit.colorHex);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(habit.title.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Text(habit.progressText, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 8,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: habit.percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReflection(BuildContext context) {
    return GlassCard(
      border: Border.all(color: AppColors.secondary.withValues(alpha: 0.2)),
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.history_edu, color: AppColors.secondary),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Reflection", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text("Last entry: 2 days ago", style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}
