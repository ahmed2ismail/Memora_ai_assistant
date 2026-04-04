import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../cubit/student/detail/student_detail_cubit.dart';
import '../../cubit/student/detail/student_detail_state.dart';

class StudentAlarmHero extends StatelessWidget {
  final StudentDetailLoaded state;

  const StudentAlarmHero({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("NEXT FOCUS SESSION",
                      style: AppStyles.custom(context,
                          color: AppColors.primary,
                          fontSize: 12,
                          weight: FontWeight.bold,
                          letterSpacing: 1.5)),
                  const SizedBox(height: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text("${state.nextAwakeningTime} ${state.nextAwakeningPeriod}",
                        style: AppStyles.headline(context, fontSize: 56)),
                  ),
                ],
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.alarm, color: AppColors.primary, size: 40),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Session Task",
                        style: AppStyles.body14(context, color: AppColors.onSurfaceVariant)),
                    const SizedBox(height: 4),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text("Advanced AI Lecture",
                          style: AppStyles.body24(context, weight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {
                  context.read<StudentDetailCubit>().triggerAction("STARTING SESSION...");
                },
                child: const Icon(Icons.play_arrow_rounded, size: 32),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
