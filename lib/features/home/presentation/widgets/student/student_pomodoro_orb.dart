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
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Focus Timer", style: AppStyles.body24(context)),
              const Icon(Icons.settings, color: AppColors.onSurfaceVariant),
            ],
          ),
          const SizedBox(height: 48),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 240,
                height: 240,
                child: CircularProgressIndicator(
                  value: 0.75,
                  strokeWidth: 12,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                  strokeCap: StrokeCap.round,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("25:00", style: AppStyles.headline(context, fontSize: 64)),
                  const SizedBox(height: 8),
                  Text("POMODORO",
                      style: AppStyles.custom(context,
                          color: AppColors.primary,
                          fontSize: 12,
                          weight: FontWeight.bold,
                          letterSpacing: 2)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 48),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {},
                  child: const Text("RESET"),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    context.read<StudentDetailCubit>().triggerAction("STARTING POMODORO...");
                  },
                  child: const Text("START"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
