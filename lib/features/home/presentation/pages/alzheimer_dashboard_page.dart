import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../di/injection_container.dart';
import '../../../../core/widgets/adaptive_layout_widget.dart';
import '../cubit/alzheimer/dashboard/alzheimer_dashboard_cubit.dart';
import '../cubit/alzheimer/dashboard/alzheimer_dashboard_state.dart';
import '../widgets/alzheimer/alzheimer_header.dart';
import '../widgets/alzheimer/scan_person_card.dart';
import '../widgets/alzheimer/alzheimer_medication_card.dart';
import '../widgets/alzheimer/alzheimer_emergency_card.dart';
import '../widgets/alzheimer/alzheimer_ai_card.dart';

class AlzheimerDashboardPage extends StatelessWidget {
  const AlzheimerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AlzheimerDashboardCubit>()..loadDashboard(),
      child: const AlzheimerDashboardView(),
    );
  }
}

class AlzheimerDashboardView extends StatelessWidget {
  const AlzheimerDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocListener wraps the entire view so ScaffoldMessenger
    // is always available in the correct context regardless of
    // how deep the triggering widget is in the tree.
    return BlocListener<AlzheimerDashboardCubit, AlzheimerDashboardState>(
      listener: (context, state) {
        if (state is AlzheimerDashboardLoaded && state.alertMessage != null) {
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
      child: AdaptiveLayoutWidget(
        mobile: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: SafeArea(
              top: true,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 120, left: 24, right: 24),
                child: BlocBuilder<AlzheimerDashboardCubit, AlzheimerDashboardState>(
                  builder: (context, state) {
                    if (state is AlzheimerDashboardLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is AlzheimerDashboardLoaded) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AlzheimerHeader(state: state),
                          const SizedBox(height: 32),
                          const ScanPersonCard(),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: AlzheimerMedicationCard(med: state.nextMedication)),
                              const SizedBox(width: 16),
                              const Expanded(child: AlzheimerEmergencyCard()),
                            ],
                          ),
                          const SizedBox(height: 24),
                          AlzheimerAiCard(aiPrompt: state.aiPrompt),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
