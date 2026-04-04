import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';

class StudentHeader extends StatelessWidget {
  final double hoursFocused;

  const StudentHeader({
    super.key,
    required this.hoursFocused,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: AppColors.onSurfaceVariant.withValues(alpha: 0.1))),
      ),
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "DEEP WORK",
                  style: AppStyles.custom(
                    context,
                    color: AppColors.primary,
                    fontSize: 10,
                    weight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Cognitive Flow",
                      style: AppStyles.headline(context, fontSize: 36),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () =>
                GoRouter.of(context).push('/dashboard/student-details/today'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text("Explore",
                  style: AppStyles.body12(context,
                      color: AppColors.primary, weight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}
