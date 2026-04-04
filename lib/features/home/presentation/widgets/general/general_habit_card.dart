import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../domain/entities/general_models.dart';

class GeneralHabitCard extends StatelessWidget {
  final HabitItem habit;

  const GeneralHabitCard({
    super.key,
    required this.habit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(habit.title, style: AppStyles.body16(context)),
              Text(habit.progressText,
                  style: AppStyles.body14(context,
                      color: AppColors.primary, weight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: habit.percentage,
              minHeight: 8,
              backgroundColor: AppColors.surfaceContainerHighest,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
