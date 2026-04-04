import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/widgets/glass_card.dart';
import '../../../domain/entities/general_models.dart';

class GeneralDetailTaskCard extends StatelessWidget {
  final DetailTaskItem task;

  const GeneralDetailTaskCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GlassCard(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: task.isCompleted
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : AppColors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                task.isCompleted ? Icons.check : Icons.circle_outlined,
                size: 20,
                color:
                    task.isCompleted ? AppColors.primary : AppColors.outlineVariant,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      task.title,
                      style: AppStyles.body16(context).copyWith(
                        decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                        color: task.isCompleted
                            ? AppColors.onSurfaceVariant
                            : AppColors.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      task.timeText,
                      style: AppStyles.body12(context, color: AppColors.onSurfaceVariant),
                    ),
                  ),
                ],
              ),
            ),
            if (task.isHighPriority)
              const Icon(Icons.star, color: AppColors.secondary, size: 24),
          ],
        ),
      ),
    );
  }
}
