import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/glass_card.dart';
import '../cubit/student/detail/student_detail_cubit.dart';
import '../cubit/student/detail/student_detail_state.dart';
import '../widgets/student/student_alarm_hero.dart';
import '../widgets/student/student_pomodoro_orb.dart';
import '../widgets/student/student_timeline_detail_card.dart';
import '../widgets/student/student_quick_action_card.dart';

class StudentDetailPage extends StatelessWidget {
  final String id;
  const StudentDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<StudentDetailCubit>()..loadDetails(id),
      child: const StudentDetailView(),
    );
  }
}

class StudentDetailView extends StatelessWidget {
  const StudentDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: false,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, bottom: 120, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              child: const Icon(Icons.arrow_back_ios, color: AppColors.primary, size: 32),
            ),
            const SizedBox(height: 24),
            BlocConsumer<StudentDetailCubit, StudentDetailState>(
              listener: (context, state) {
                if (state is StudentDetailLoaded && state.alertMessage != null) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                        content: Text(state.alertMessage!),
                        duration: const Duration(seconds: 1)));
                }
              },
              builder: (context, state) {
                if (state is StudentDetailLoading) {
                  return const SizedBox(
                      height: 500, child: Center(child: CircularProgressIndicator()));
                } else if (state is StudentDetailLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StudentAlarmHero(state: state),
                      const SizedBox(height: 24),
                      _buildFocusGrid(context, state),
                      const SizedBox(height: 24),
                      _buildQuickActions(context, state),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFocusGrid(BuildContext context, StudentDetailLoaded state) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(flex: 7, child: StudentPomodoroOrb()),
              const SizedBox(width: 24),
              Expanded(flex: 5, child: _buildTimelineAndAI(context, state)),
            ],
          );
        }
        return Column(
          children: [
            const StudentPomodoroOrb(),
            const SizedBox(height: 24),
            _buildTimelineAndAI(context, state),
          ],
        );
      },
    );
  }

  Widget _buildTimelineAndAI(BuildContext context, StudentDetailLoaded state) {
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
                    child: Container(width: 1, color: AppColors.outlineVariant.withValues(alpha: 0.3)),
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
        _buildAiInsightBanner(context),
      ],
    );
  }

  Widget _buildAiInsightBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh, borderRadius: BorderRadius.circular(32)),
      child: Stack(
        children: [
          Positioned(
            top: -10,
            right: -10,
            child: Icon(Icons.psychology, size: 64, color: AppColors.primary.withValues(alpha: 0.1)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("AI INSIGHT",
                  style: AppStyles.custom(context,
                      color: AppColors.primary,
                      fontSize: 10,
                      weight: FontWeight.bold,
                      letterSpacing: 1.5)),
              const SizedBox(height: 8),
              Text(
                "\"You tend to be 15% more productive after short walks. Consider a 5-min break before your next lecture.\"",
                style: AppStyles.body14(context, color: AppColors.onSurface)
                    .copyWith(fontStyle: FontStyle.italic, height: 1.5),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, StudentDetailLoaded state) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.5,
      children: state.quickActions.map((item) => StudentQuickActionCard(item: item)).toList(),
    );
  }
}
