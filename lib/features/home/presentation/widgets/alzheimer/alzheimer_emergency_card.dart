import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/widgets/glass_card.dart';
import '../../cubit/alzheimer/dashboard/alzheimer_dashboard_cubit.dart';

class AlzheimerEmergencyCard extends StatelessWidget {
  const AlzheimerEmergencyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.emergency_share, color: AppColors.error),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "EMERGENCY",
                  style: AppStyles.custom(
                    context,
                    fontSize: 14,
                    color: AppColors.error,
                    weight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error.withValues(alpha: 0.2),
                foregroundColor: AppColors.error,
                side: BorderSide(color: AppColors.error.withValues(alpha: 0.4)),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                context.read<AlzheimerDashboardCubit>().triggerEmergency();
              },
              child: Text(
                "HELP NOW",
                style: AppStyles.body14(context,
                    color: AppColors.error, weight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
