import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/widgets/glass_card.dart';
import '../../cubit/student/detail/student_detail_state.dart';
import 'student_timeline_detail_card.dart';
import 'student_detail_ai_insight_banner.dart';

class StudentDetailTimelinePanel extends StatelessWidget {
  final StudentDetailLoaded state;

  const StudentDetailTimelinePanel({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlassCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Daily Timeline", style: AppStyles.body16(context)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Text("${state.timelineEvents.length} Left",
                        style: AppStyles.body12(context,
                            color: AppColors.primary, weight: FontWeight.bold)),
                  )
                ],
              ),
              const SizedBox(height: 24),
              Stack(
                children: [
                  Positioned(
                    left: 17,
                    top: 8,
                    bottom: 8,
                    child: Container(
                        width: 1,
                        color: AppColors.outlineVariant.withValues(alpha: 0.3)),
                  ),
                  Column(
                    children: state.timelineEvents
                        .map((e) => StudentTimelineDetailCard(event: e))
                        .toList(),
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 24),
        const StudentDetailAiInsightBanner(),
      ],
    );
  }
}
