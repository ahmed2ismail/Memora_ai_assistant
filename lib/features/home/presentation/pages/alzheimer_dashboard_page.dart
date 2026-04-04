import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/adaptive_layout_widget.dart';
import '../../../../di/injection_container.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/alzheimer_models.dart';
import '../cubit/alzheimer_dashboard_cubit.dart';
import '../cubit/alzheimer_dashboard_state.dart';

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
    return AdaptiveLayoutWidget(
      mobile: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Padding(
            padding: const EdgeInsets.only(top: 160, bottom: 120, left: 24, right: 24),
            child: BlocBuilder<AlzheimerDashboardCubit, AlzheimerDashboardState>(
              builder: (context, state) {
                if (state is AlzheimerDashboardLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AlzheimerDashboardLoaded) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context, state),
                      const SizedBox(height: 32),
                      _buildMassiveInteractionZone(context),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildMedicationBlock(context, state.nextMedication)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildEmergencyBlock(context)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildAiAssistantWidget(context, state.aiPrompt),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AlzheimerDashboardLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "SAFE SPACE",
          style: AppStyles.custom(
            context,
            color: AppColors.secondary,
            fontSize: 12,
            weight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Good morning, ${state.patientName}.", 
          style: AppStyles.headline(context, fontSize: 36),
          overflow: TextOverflow.visible,
        ),
        const SizedBox(height: 8),
        Text(
          state.dateAndWeather, 
          style: AppStyles.body16(context),
          overflow: TextOverflow.visible,
        ),
      ],
    );
  }

  Widget _buildMassiveInteractionZone(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push('/dashboard/alzheimer-details/today'),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person_search, color: AppColors.primary, size: 36),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Scan Person", 
                          style: AppStyles.body24(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Point camera to remember a face", 
                          style: AppStyles.body14(context),
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.arrow_forward_ios, color: AppColors.primary, size: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicationBlock(BuildContext context, AlzheimerMedicationItem med) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.medication, color: AppColors.secondary),
              const SizedBox(width: 8),
              Expanded(child: Text("Next Medication", style: AppStyles.body14(context, color: AppColors.secondary, weight: FontWeight.bold))),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(med.medicineName, style: AppStyles.body16(context)),
                const SizedBox(height: 4),
                Text(med.instructions, style: AppStyles.body12(context)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEmergencyBlock(BuildContext context) {
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
              Expanded(child: Text("EMERGENCY", style: AppStyles.custom(context, fontSize: 14, color: AppColors.error, weight: FontWeight.bold, letterSpacing: 1))),
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
              onPressed: () {},
              child: Text("HELP NOW", style: AppStyles.body14(context, color: AppColors.error, weight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAiAssistantWidget(BuildContext context, AlzheimerAiPrompt aiPrompt) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [AppColors.primary, Color(0xFF00A471)]),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.psychology, color: Color(0xFF003824)),
              ),
              const SizedBox(width: 16),
              Text("Memora AI", style: AppStyles.body24(context)),
            ],
          ),
          const SizedBox(height: 16),
          Text(aiPrompt.message, style: AppStyles.body16(context, color: AppColors.onSurfaceVariant).copyWith(fontStyle: FontStyle.italic, height: 1.5)),
          const SizedBox(height: 24),
          const Divider(color: AppColors.surfaceContainerHighest, thickness: 2),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: aiPrompt.suggestions.map((suggestion) => _buildSuggestionPill(context, suggestion)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionPill(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(text, style: AppStyles.body12(context, color: AppColors.primary)),
    );
  }
}
