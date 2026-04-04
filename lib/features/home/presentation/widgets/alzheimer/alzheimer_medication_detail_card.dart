import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/widgets/glass_card.dart';
import '../../../domain/entities/alzheimer_models.dart';

class AlzheimerMedicationDetailCard extends StatelessWidget {
  final List<DetailMedicineItem> medicines;

  const AlzheimerMedicationDetailCard({
    super.key,
    required this.medicines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Medication Schedule",
          style: AppStyles.custom(context, fontSize: 18, weight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...medicines.map((med) => _buildMedicationItem(context, med)),
      ],
    );
  }

  Widget _buildMedicationItem(BuildContext context, DetailMedicineItem med) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: med.isTaken
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : AppColors.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                med.isTaken ? Icons.check_circle : Icons.medication,
                color: med.isTaken ? AppColors.primary : AppColors.secondary,
              ),
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
                      med.name,
                      style: AppStyles.body16(context).copyWith(
                        decoration: med.isTaken ? TextDecoration.lineThrough : null,
                        color: med.isTaken ? AppColors.onSurfaceVariant : AppColors.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${med.timeLabel} • ${med.dosageDescription}",
                      style: AppStyles.body12(context, color: AppColors.onSurfaceVariant),
                    ),
                  ),
                ],
              ),
            ),
            if (!med.isTaken)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "TAKE",
                  style: AppStyles.body12(context,
                      color: Colors.white, weight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
