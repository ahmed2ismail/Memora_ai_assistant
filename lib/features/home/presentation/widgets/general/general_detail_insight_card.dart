import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';

class GeneralDetailInsightCard extends StatelessWidget {
  const GeneralDetailInsightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb, color: AppColors.primary, size: 24),
              const SizedBox(width: 12),
              Text("Logic Hub Insight",
                  style: AppStyles.body16(context).copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "\"You've completed 85% of your tasks before 2 PM this week. Your focus is sharpest in the morning.\"",
            style: AppStyles.body14(context, color: AppColors.onSurface)
                .copyWith(fontStyle: FontStyle.italic, height: 1.5),
          ),
        ],
      ),
    );
  }
}
