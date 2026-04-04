import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../domain/entities/student_models.dart';
import 'student_metric_card.dart';

class StudentInsightCard extends StatelessWidget {
  final StudentInsightMetrics metrics;

  const StudentInsightCard({
    super.key,
    required this.metrics,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.surfaceContainerHighest,
                AppColors.surfaceContainerLow
              ],
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
                style: AppStyles.custom(context, fontSize: 16, color: AppColors.onSurface)
                    .copyWith(height: 1.5),
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
                    BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10)),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Start Focus Timer",
                    style: AppStyles.custom(context,
                        fontSize: 16,
                        color: const Color(0xFF003824),
                        weight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: StudentMetricCard(
                value: "${metrics.memoryRecallPercentage}%",
                label: "Memory Recall",
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: StudentMetricCard(
                value: "${metrics.habitStreak}",
                label: "Habit Streak",
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
