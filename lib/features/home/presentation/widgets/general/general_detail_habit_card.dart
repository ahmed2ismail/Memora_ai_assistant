import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../domain/entities/general_models.dart';

class GeneralDetailHabitCard extends StatelessWidget {
  final HabitItem habit;

  const GeneralDetailHabitCard({
    super.key,
    required this.habit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(habit.title, style: AppStyles.body16(context).copyWith(letterSpacing: 0.2)),
              Text(habit.progressText,
                  style: AppStyles.custom(context,
                      fontSize: 16, color: AppColors.primary, weight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: habit.percentage,
              minHeight: 12,
              backgroundColor: AppColors.surfaceContainerHighest,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
