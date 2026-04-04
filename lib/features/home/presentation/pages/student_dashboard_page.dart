import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../di/injection_container.dart';
import '../../domain/entities/student_models.dart';
import '../cubit/student_dashboard_cubit.dart';
import '../cubit/student_dashboard_state.dart';

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
      child: BlocBuilder<StudentDashboardCubit, StudentDashboardState>(
        builder: (context, state) {
          if (state is StudentDashboardLoading) {
            return const Center(child: Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: CircularProgressIndicator(),
            ));
          } else if (state is StudentDashboardLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, state.hoursFocused),
                const SizedBox(height: 32),
                _buildTimeline(context, state.timelineItems),
                const SizedBox(height: 32),
                _buildInsightsAndMetrics(context, state.metrics),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double hoursFocused) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.onSurfaceVariant.withValues(alpha: 0.1))),
      ),
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "DEEP WORK",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 4),
              Text("Cognitive Flow", style: Theme.of(context).textTheme.headlineLarge),
            ],
          ),
          Text(
            "${hoursFocused.toInt()} Hours Focused Today",
            style: const TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context, List<StudentTimelineItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Timeline", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text("October 24", style: Theme.of(context).textTheme.bodyMedium),
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
                children: items.map((item) => _buildTimelineItem(context, item)).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItem(BuildContext context, StudentTimelineItem item) {
    final dotColor = _fromHex(item.dotColorHex);
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            transform: Matrix4.translationValues(-6, 4, 0),
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
              border: item.isActive ? Border.all(color: dotColor.withValues(alpha: 0.3), width: 4) : null,
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: GlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.timeRange, style: TextStyle(fontWeight: FontWeight.bold, color: dotColor, fontSize: 12)),
                      if (item.isActive) const Icon(Icons.more_horiz, size: 16, color: AppColors.onSurfaceVariant),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(item.description, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsAndMetrics(BuildContext context, StudentInsightMetrics metrics) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.surfaceContainerHighest, AppColors.surfaceContainerLow],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.auto_awesome, color: AppColors.secondary, size: 20),
                  const SizedBox(width: 12),
                  const Text("Smart Insight", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                metrics.smartInsightMessage,
                style: const TextStyle(fontSize: 16, height: 1.5, color: AppColors.onSurface),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, Color(0xFF00A471)],
                  ),
                  boxShadow: [
                    BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 10)),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Start Focus Timer",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF003824), fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildMetricCard(context, "${metrics.memoryRecallPercentage}%", "Memory Recall", AppColors.primary)),
            const SizedBox(width: 16),
            Expanded(child: _buildMetricCard(context, "${metrics.habitStreak}", "Habit Streak", AppColors.secondary)),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(BuildContext context, String value, String label, Color color) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        children: [
          Text(value, style: Theme.of(context).textTheme.displayMedium?.copyWith(color: color, fontSize: 36)),
          const SizedBox(height: 4),
          Text(label.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
        ],
      ),
    );
  }
}
