import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/adaptive_layout_widget.dart';
import '../../../../di/injection_container.dart';
import 'package:go_router/go_router.dart';
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
    return AdaptiveLayoutWidget(
      mobile: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Padding(
            padding: const EdgeInsets.only(top: 100, bottom: 120, left: 24, right: 24),
            child: BlocBuilder<StudentDashboardCubit, StudentDashboardState>(
              builder: (context, state) {
                if (state is StudentDashboardLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is StudentDashboardLoaded) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
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
          ),
        ),
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
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "DEEP WORK",
                  style: AppStyles.custom(
                    context,
                    color: AppColors.primary,
                    fontSize: 10,
                    weight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Cognitive Flow", 
                  style: AppStyles.headline(context, fontSize: 36),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => GoRouter.of(context).push('/dashboard/student-details/today'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text("Explore", style: AppStyles.body12(context, color: AppColors.primary, weight: FontWeight.bold)),
            ),
          )
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
            Text("Timeline", style: AppStyles.custom(context, fontSize: 18, weight: FontWeight.bold)),
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
                      Text(item.timeRange, style: AppStyles.body12(context, color: dotColor, weight: FontWeight.bold)),
                      if (item.isActive) const Icon(Icons.more_horiz, size: 16, color: AppColors.onSurfaceVariant),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(item.title, style: AppStyles.body16(context)),
                  const SizedBox(height: 4),
                  Text(item.description, style: AppStyles.body14(context)),
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
            gradient: const LinearGradient(
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
                  Text("Smart Insight", style: AppStyles.body16(context)),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                metrics.smartInsightMessage,
                style: AppStyles.custom(context, fontSize: 16, color: AppColors.onSurface).copyWith(height: 1.5),
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
                child: Center(
                  child: Text(
                    "Start Focus Timer",
                    style: AppStyles.custom(context, fontSize: 16, color: const Color(0xFF003824), weight: FontWeight.bold),
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
          Text(value, style: AppStyles.custom(context, fontSize: 36, color: color)),
          const SizedBox(height: 4),
          Text(label.toUpperCase(), style: AppStyles.custom(context, fontSize: 10, weight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
        ],
      ),
    );
  }
}
