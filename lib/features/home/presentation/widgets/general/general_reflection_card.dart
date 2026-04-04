import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/widgets/glass_card.dart';

class GeneralReflectionCard extends StatelessWidget {
  const GeneralReflectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.psychology_alt, color: AppColors.secondary, size: 24),
              const SizedBox(width: 12),
              Text("Daily Reflection", style: AppStyles.body16(context)),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "\"Take a moment to reflect on your three biggest accomplishments today. What brought you the most joy?\"",
            style: AppStyles.body14(context, color: AppColors.onSurfaceVariant)
                .copyWith(fontStyle: FontStyle.italic, height: 1.5),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.surfaceContainerHighest,
            ),
            child: Center(
              child: Text(
                "Write Reflection",
                style: AppStyles.body14(context, weight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
