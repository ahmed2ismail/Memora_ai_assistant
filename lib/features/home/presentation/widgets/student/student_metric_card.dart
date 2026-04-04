import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/widgets/glass_card.dart';

class StudentMetricCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const StudentMetricCard({
    super.key,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(value, style: AppStyles.custom(context, fontSize: 36, color: color)),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(label.toUpperCase(),
                style: AppStyles.custom(context,
                    fontSize: 10,
                    weight: FontWeight.bold,
                    color: AppColors.onSurfaceVariant)),
          ),
        ],
      ),
    );
  }
}
