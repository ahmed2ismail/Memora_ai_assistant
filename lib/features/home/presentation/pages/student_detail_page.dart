import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../di/injection_container.dart';
import '../../domain/entities/student_models.dart';
import '../cubit/student_detail_cubit.dart';
import '../cubit/student_detail_state.dart';

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
      backgroundColor: Colors.transparent, // transparent for shell background
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100, bottom: 120, left: 24, right: 24),
        child: BlocBuilder<StudentDetailCubit, StudentDetailState>(
          builder: (context, state) {
            if (state is StudentDetailLoading) {
              return const SizedBox(
                height: 500,
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (state is StudentDetailLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSmartAlarmHero(context, state),
                  const SizedBox(height: 24),
                  _buildFocusGrid(context, state),
                  const SizedBox(height: 24),
                  _buildQuickActions(context, state.quickActions),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildSmartAlarmHero(BuildContext context, StudentDetailLoaded state) {
    return GlassCard(
      padding: const EdgeInsets.all(32),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "NEXT AWAKENING",
                      style: AppStyles.custom(
                        context,
                        color: AppColors.secondary,
                        weight: FontWeight.bold,
                        fontSize: 10,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          state.nextAwakeningTime,
                          style: AppStyles.custom(context, weight: FontWeight.w800, fontSize: 48, letterSpacing: -1),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          state.nextAwakeningPeriod,
                          style: AppStyles.custom(context, weight: FontWeight.bold, fontSize: 20, color: AppColors.onSurfaceVariant),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Memora has calculated your optimal REM cycle. Rise with the light.",
                      style: AppStyles.body12(context).copyWith(height: 1.5),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.primary, Color(0xFF00A471)]),
                      boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 5))],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          child: Row(
                            children: [
                              const Icon(Icons.alarm_on, color: AppColors.onPrimary, size: 20),
                              const SizedBox(width: 8),
                              Text("Active", style: AppStyles.body14(context, color: AppColors.onPrimary, weight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text("Dismiss Anti-Snooze", style: AppStyles.body12(context, color: AppColors.primary, weight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Positioned(
            top: -50,
            right: -50,
            child: Icon(Icons.star, size: 100, color: AppColors.primary.withValues(alpha: 0.05)),
          )
        ],
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
              Expanded(flex: 7, child: _buildPomodoroOrb(context)),
              const SizedBox(width: 24),
              Expanded(flex: 5, child: _buildTimelineAndAI(context, state.timelineEvents)),
            ],
          );
        }
        return Column(
          children: [
            _buildPomodoroOrb(context),
            const SizedBox(height: 24),
            _buildTimelineAndAI(context, state.timelineEvents),
          ],
        );
      },
    );
  }

  Widget _buildPomodoroOrb(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 2, style: BorderStyle.none),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [AppColors.primary.withValues(alpha: 0.2), Colors.transparent],
                      stops: const [0.3, 1.0],
                    ),
                  ),
                ),
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [AppColors.primary, Color(0xFF00A471)]),
                    boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.4), blurRadius: 30, spreadRadius: -5)],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("25:00", style: AppStyles.custom(context, fontSize: 48, weight: FontWeight.w900, color: AppColors.onPrimary)),
                      Text("FOCUS FLOW", style: AppStyles.custom(context, fontSize: 10, weight: FontWeight.bold, color: AppColors.onPrimary, letterSpacing: 2)),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerHighest.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  alignment: Alignment.center,
                  child: Text("Settings", style: AppStyles.body16(context)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(color: AppColors.onSurface, borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  child: Text("Start Session", style: AppStyles.body16(context, color: AppColors.surfaceDim)),
                ),
              )
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.auto_awesome, size: 16, color: AppColors.onSurfaceVariant),
              const SizedBox(width: 8),
              Text("Daily Goal: 4 of 8 sessions", style: AppStyles.body12(context)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTimelineAndAI(BuildContext context, List<TimelineEventItem> events) {
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
                    decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                    child: Text("3 Left", style: AppStyles.body12(context, color: AppColors.primary, weight: FontWeight.bold)),
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
                    children: events.map((e) => _buildTimelineItem(context, e)).toList(),
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: AppColors.surfaceContainerHigh, borderRadius: BorderRadius.circular(32)),
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
                  Text("AI INSIGHT", style: AppStyles.custom(context, color: AppColors.primary, fontSize: 10, weight: FontWeight.bold, letterSpacing: 1.5)),
                  const SizedBox(height: 8),
                  Text(
                    "\"You tend to be 15% more productive after short walks. Consider a 5-min break before your next lecture.\"",
                    style: AppStyles.body14(context, color: AppColors.onSurface).copyWith(fontStyle: FontStyle.italic, height: 1.5),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTimelineItem(BuildContext context, TimelineEventItem event) {
    Color dotColor;
    switch (event.dotColorMode) {
      case "primary": dotColor = AppColors.primary; break;
      case "secondary": dotColor = AppColors.secondary; break;
      default: dotColor = AppColors.outlineVariant; break;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            alignment: Alignment.center,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surfaceDim, width: 3),
                boxShadow: event.dotColorMode == 'secondary' ? [BoxShadow(color: AppColors.secondary.withValues(alpha: 0.4), blurRadius: 10)] : null,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${event.timeLabel} • ${event.category}", style: AppStyles.custom(context, color: dotColor, fontSize: 10, weight: FontWeight.bold, letterSpacing: 1.0)),
                const SizedBox(height: 4),
                Text(event.title, style: AppStyles.body14(context, color: event.dotColorMode == 'outline' ? AppColors.onSurface.withValues(alpha: 0.7) : AppColors.onSurface, weight: FontWeight.bold)),
                if (event.subtitle.isNotEmpty || event.isHighPriority) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      if (event.subtitle.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: AppColors.surfaceContainerHighest, borderRadius: BorderRadius.circular(4)),
                          child: Text(event.subtitle, style: AppStyles.body12(context)),
                        ),
                      if (event.subtitle.isNotEmpty && event.isHighPriority) const SizedBox(width: 6),
                      if (event.isHighPriority)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: AppColors.errorContainer.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4)),
                          child: Text("High Priority", style: AppStyles.body12(context, color: AppColors.error)),
                        )
                    ],
                  )
                ]
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, List<QuickActionItem> actions) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.5,
      children: actions.map((item) {
        Color iconColor;
        Color bgColor;
        switch (item.colorMode) {
          case 'primary': iconColor = AppColors.primary; bgColor = AppColors.primary.withValues(alpha: 0.1); break;
          case 'secondary': iconColor = AppColors.secondary; bgColor = AppColors.secondary.withValues(alpha: 0.1); break;
          default: iconColor = AppColors.onSurfaceVariant; bgColor = AppColors.onSurface.withValues(alpha: 0.05); break;
        }

        return GlassCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12)),
                child: Icon(_getIcon(item.iconName), color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(item.label, style: AppStyles.body14(context, weight: FontWeight.bold)),
            ],
          ),
        );
      }).toList(),
    );
  }

  IconData _getIcon(String name) {
    switch (name) {
      case 'auto_stories': return Icons.auto_stories;
      case 'groups': return Icons.groups;
      case 'leaderboard': return Icons.leaderboard;
      case 'rocket_launch': return Icons.rocket_launch;
      default: return Icons.home;
    }
  }
}
