import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../domain/entities/student_models.dart';

class StudentTimelineDetailCard extends StatelessWidget {
  final TimelineEventItem event;

  const StudentTimelineDetailCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(event.timeLabel,
                style: AppStyles.body12(context, weight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(event.title,
                      style: AppStyles.body14(context, weight: FontWeight.bold)),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(event.subtitle,
                      style:
                          AppStyles.body12(context, color: AppColors.onSurfaceVariant)),
                ),
              ],
            ),
          ),
          if (event.category == 'done')
            const Icon(Icons.check_circle, color: AppColors.primary, size: 20)
          else
            const Icon(Icons.radio_button_unchecked,
                color: AppColors.outlineVariant, size: 20),
        ],
      ),
    );
  }
}
