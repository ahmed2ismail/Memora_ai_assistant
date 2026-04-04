import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../di/injection_container.dart';
import '../../domain/entities/general_models.dart';
import '../cubit/general_detail_cubit.dart';
import '../cubit/general_detail_state.dart';

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

  Color _fromHex(String hexString) {
    if (hexString.isEmpty) return Colors.transparent;
    var buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // transparent to let shell background show
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
        padding: const EdgeInsets.only(bottom: 120), // Padding for the floating nav bar
        child: BlocBuilder<GeneralDetailCubit, GeneralDetailState>(
          builder: (context, state) {
            if (state is GeneralDetailLoading) {
              return const SizedBox(
                height: 500,
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (state is GeneralDetailLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeroMap(context, state.locationReminder),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTasksList(context, state),
                        const SizedBox(height: 32),
                        _buildHabitsPanel(context, state.habits),
                        const SizedBox(height: 32),
                        _buildAsymmetricInsights(context),
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

  Widget _buildHeroMap(BuildContext context, LocationReminder reminder) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 300,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
            image: DecorationImage(
              image: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuAWvq7SKhn4n6SbYJ0j1-rzjYqjJKDReiA3PqTTsxrXG1L7eG4kCC-gZ5vMRp1IIP6-ihZbIviNthYuVH8S6w3NJz7l8Lx7rZkT_GCrkndGGHkFJRogHjZo6g8Wf7fV9LQZwq3gatrZW5tbEJwYMFJhg0sqtYfpgpMhuAMwwjv_O-MPaIrnOiElGAl3a27V2YN0YpUGPtvdt3nBfWtUO1FBGmmlgW_zEEj-zc4y4_ffSmCc4bvF6btxSeTYphr0fj94Yl5h8Nh-aDNr"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
            ),
          ),
        ),
        Positioned(
          bottom: -2,
          left: 0,
          right: 0,
          height: 100,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [AppColors.surfaceDim, Colors.transparent],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 24,
          left: 24,
          right: 24,
          child: GlassCard(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.location_on, color: AppColors.primary),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("ACTIVE REMINDER", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.secondary, letterSpacing: 1.5)),
                      const SizedBox(height: 4),
                      Text(reminder.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 2),
                      Text(reminder.locationDescription, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTasksList(BuildContext context, GeneralDetailLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Today's Focus", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 32, letterSpacing: -0.5)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(color: AppColors.surfaceContainerHigh, borderRadius: BorderRadius.circular(20)),
              child: Text("${state.pendingTasks} Pending", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ...state.tasks.map((task) => _buildTaskItem(task)),
      ],
    );
  }

  Widget _buildTaskItem(DetailTaskItem task) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlassCard(
        border: task.isCompleted ? Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.1)) : null,
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: task.isCompleted ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: task.isCompleted ? null : Border.all(color: AppColors.primary.withValues(alpha: 0.4), width: 2),
              ),
              child: task.isCompleted ? const Icon(Icons.check, size: 16, color: AppColors.onPrimary) : null,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                      color: task.isCompleted ? AppColors.onSurfaceVariant : AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (!task.isCompleted) ...[
                        const Icon(Icons.schedule, size: 14, color: AppColors.onSurfaceVariant),
                        const SizedBox(width: 4),
                        Text(task.timeText, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
                        const SizedBox(width: 16),
                      ],
                      if (task.isHighPriority) ...[
                        const Icon(Icons.priority_high, size: 14, color: AppColors.secondary),
                        const SizedBox(width: 4),
                        const Text("High Priority", style: TextStyle(fontSize: 12, color: AppColors.secondary)),
                      ],
                      if (task.isCompleted) ...[
                        const Text("Done", style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
                      ]
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.more_vert, color: AppColors.onSurfaceVariant),
          ],
        ),
      ),
    );
  }

  Widget _buildHabitsPanel(BuildContext context, List<HabitItem> habits) {
    return Stack(
      children: [
        GlassCard(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Habit Momentum", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(height: 24),
              ...habits.map((habit) => _buildDetailHabitItem(habit)),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.emoji_events, color: AppColors.primary),
                    SizedBox(width: 12),
                    Text("You're 15% more productive than last week!", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: -20,
          right: -20,
          child: Icon(Icons.star, size: 150, color: AppColors.primary.withValues(alpha: 0.05)),
        )
      ],
    );
  }

  Widget _buildDetailHabitItem(HabitItem habit) {
    final color = _fromHex(habit.colorHex);
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(habit.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(habit.progressText, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: habit.percentage,
            backgroundColor: AppColors.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildAsymmetricInsights(BuildContext context) {
    return Column(
      children: [
        GlassCard(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.psychology, size: 48, color: AppColors.secondary),
              const SizedBox(height: 16),
              const Text("Mindful Planning,\nNot Just Listing.", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 32, height: 1.1)),
              const SizedBox(height: 16),
              Text("Memora analyzes your peak focus times to suggest optimal task scheduling.", style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5)),
            ],
          ),
        ),
      ],
    );
  }
}
