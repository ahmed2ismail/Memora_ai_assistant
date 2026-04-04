import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../cubit/student/detail/student_detail_cubit.dart';

class StudentPomodoroOrb extends StatelessWidget {
  const StudentPomodoroOrb({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  value: 0.75,
                  strokeWidth: 8,
                  backgroundColor: AppColors.surfaceContainerHighest,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
              Column(
                children: [
                  Text("25:00",
                      style: AppStyles.headline(context, fontSize: 48)
                          .copyWith(letterSpacing: -2)),
                  Text("FOCUSING",
                      style: AppStyles.body12(context,
                              color: AppColors.primary, weight: FontWeight.bold)
                          .copyWith(letterSpacing: 2)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildOrbButton(
                context,
                icon: Icons.refresh,
                label: "RESET",
                onPressed: () {
                  context
                      .read<StudentDetailCubit>()
                      .triggerAction("RESETTING TIMER...");
                },
              ),
              const SizedBox(width: 24),
              _buildOrbButton(
                context,
                icon: Icons.pause,
                label: "PAUSE",
                isPrimary: true,
                onPressed: () {
                  context
                      .read<StudentDetailCubit>()
                      .triggerAction("PAUSING SESSION...");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrbButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isPrimary = false,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isPrimary ? AppColors.primary : AppColors.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isPrimary ? const Color(0xFF003824) : AppColors.onSurface,
              size: 24,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: AppStyles.body12(context,
                color: AppColors.onSurfaceVariant, weight: FontWeight.bold)),
      ],
    );
  }
}
