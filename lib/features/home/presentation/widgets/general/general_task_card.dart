import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../domain/entities/general_models.dart';

class GeneralTaskCard extends StatelessWidget {
  final TaskItem task;

  const GeneralTaskCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    task.isCompleted ? AppColors.primary : AppColors.outlineVariant,
                width: 2,
              ),
              color: task.isCompleted ? AppColors.primary : Colors.transparent,
            ),
            child: task.isCompleted
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 16),
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
                Text(
                  task.subtitle,
                  style:
                      AppStyles.body12(context, color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
          ),
          if (task.tagColor == 'priority')
            const Icon(Icons.star, color: AppColors.secondary, size: 20),
        ],
      ),
    );
  }
}
