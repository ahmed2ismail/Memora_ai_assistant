import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/student/detail/student_detail_cubit.dart';
import '../cubit/student/detail/student_detail_state.dart';
import '../widgets/student/student_alarm_hero.dart';
import '../widgets/student/student_pomodoro_orb.dart';
import '../widgets/student/student_detail_timeline_panel.dart';
import '../widgets/student/student_detail_quick_actions_grid.dart';

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
    return BlocListener<StudentDetailCubit, StudentDetailState>(
      listener: (context, state) {
        if (state is StudentDetailLoaded && state.alertMessage != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.alertMessage!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: const Color(0xFF1B2538),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                duration: const Duration(seconds: 2),
              ),
            );
        }
      },
      child: Scaffold(
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
              BlocBuilder<StudentDetailCubit, StudentDetailState>(
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
                        StudentDetailQuickActionsGrid(state: state),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
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
              Expanded(flex: 5, child: StudentDetailTimelinePanel(state: state)),
            ],
          );
        }
        return Column(
          children: [
            const StudentPomodoroOrb(),
            const SizedBox(height: 24),
            StudentDetailTimelinePanel(state: state),
          ],
        );
      },
    );
  }
}
