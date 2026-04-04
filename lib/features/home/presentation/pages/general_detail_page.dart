import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/glass_card.dart';
import '../cubit/general/detail/general_detail_cubit.dart';
import '../cubit/general/detail/general_detail_state.dart';
import '../widgets/general/general_detail_hero_map.dart';
import '../widgets/general/general_detail_task_card.dart';
import '../widgets/general/general_detail_habit_card.dart';
import '../widgets/general/general_detail_insight_card.dart';

class GeneralDetailPage extends StatelessWidget {
  final String id;
  const GeneralDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GeneralDetailCubit>()..loadDetails(id),
      child: const GeneralDetailView(),
    );
  }
}

class GeneralDetailView extends StatelessWidget {
  const GeneralDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120),
        child: BlocBuilder<GeneralDetailCubit, GeneralDetailState>(
          builder: (context, state) {
            if (state is GeneralDetailLoading) {
              return const SizedBox(
                  height: 500, child: Center(child: CircularProgressIndicator()));
            } else if (state is GeneralDetailLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GeneralDetailHeroMap(reminder: state.locationReminder.title),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTasksSection(context, state),
                        const SizedBox(height: 32),
                        _buildHabitsPanel(context, state),
                        const SizedBox(height: 32),
                        const GeneralDetailInsightCard(),
                      ],
                    ),
                  )
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildTasksSection(BuildContext context, GeneralDetailLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Today's Focus",
                style: AppStyles.headline(context, fontSize: 32).copyWith(letterSpacing: -0.5)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh, borderRadius: BorderRadius.circular(20)),
              child: Text("${state.pendingTasks} Pending",
                  style: AppStyles.body12(context, weight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ...state.tasks.map((task) => GeneralDetailTaskCard(task: task)),
      ],
    );
  }

  Widget _buildHabitsPanel(BuildContext context, GeneralDetailLoaded state) {
    return Stack(
      children: [
        GlassCard(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Habit Momentum", style: AppStyles.body24(context)),
              const SizedBox(height: 24),
              ...state.habits.map((habit) => GeneralDetailHabitCard(habit: habit)),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.emoji_events, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text("You're 15% more productive than last week!",
                          style: AppStyles.body14(context, weight: FontWeight.bold)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: -20,
          right: -20,
          child:
              Icon(Icons.star, size: 150, color: AppColors.primary.withValues(alpha: 0.05)),
        )
      ],
    );
  }
}
