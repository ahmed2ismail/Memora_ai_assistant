import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';

class StudentDetailAiInsightBanner extends StatelessWidget {
  const StudentDetailAiInsightBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh, borderRadius: BorderRadius.circular(32)),
      child: Stack(
        children: [
          Positioned(
            top: -10,
            right: -10,
            child: Icon(Icons.psychology, size: 64, color: AppColors.primary.withValues(alpha: 0.1)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("AI INSIGHT",
                  style: AppStyles.custom(context,
                      color: AppColors.primary,
                      fontSize: 10,
                      weight: FontWeight.bold,
                      letterSpacing: 1.5)),
              const SizedBox(height: 8),
              Text(
                "\"You tend to be 15% more productive after short walks. Consider a 5-min break before your next lecture.\"",
                style: AppStyles.body14(context, color: AppColors.onSurface)
                    .copyWith(fontStyle: FontStyle.italic, height: 1.5),
              )
            ],
          )
        ],
      ),
    );
  }
}
