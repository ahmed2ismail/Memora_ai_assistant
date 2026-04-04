import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/widgets/glass_card.dart';

class ScanPersonCard extends StatelessWidget {
  const ScanPersonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push('/dashboard/alzheimer-details/today'),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child:
                        const Icon(Icons.person_search, color: AppColors.primary, size: 36),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Scan Person",
                            style: AppStyles.body24(context),
                          ),
                        ),
                        const SizedBox(height: 4),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Point camera to remember a face",
                            style: AppStyles.body14(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.arrow_forward_ios, color: AppColors.primary, size: 32),
          ],
        ),
      ),
    );
  }
}
