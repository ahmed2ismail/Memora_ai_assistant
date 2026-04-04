import 'package:flutter/material.dart';
import 'package:memora_ai_assistant/features/home/domain/entities/alzheimer_models.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/widgets/glass_card.dart';

class AlzheimerMedicationCard extends StatelessWidget {
  final AlzheimerMedicationItem med;

  const AlzheimerMedicationCard({
    super.key,
    required this.med,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.medication, color: AppColors.secondary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Next Medication",
                  style: AppStyles.body14(
                    context,
                    color: AppColors.secondary,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(med.medicineName, style: AppStyles.body16(context)),
                ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(med.instructions, style: AppStyles.body12(context)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
