import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../di/injection_container.dart';
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
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 120, bottom: 120, left: 24, right: 24),
      child: BlocBuilder<AlzheimerDashboardCubit, AlzheimerDashboardState>(
        builder: (context, state) {
          if (state is AlzheimerDashboardLoading) {
            return const Center(child: Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: CircularProgressIndicator(),
            ));
          } else if (state is AlzheimerDashboardLoaded) {
            return Column(
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
    );
  }

  Widget _buildHeader(BuildContext context, AlzheimerDashboardLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "SAFE SPACE",
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        Text("Good morning, ${state.patientName}.", style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 36)),
        const SizedBox(height: 8),
        Text(state.dateAndWeather, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }

  Widget _buildMassiveInteractionZone(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Scan Person", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  const SizedBox(height: 4),
                  Text("Point camera to remember a face", style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios, color: AppColors.primary, size: 32),
        ],
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
            children: const [
              Icon(Icons.medication, color: AppColors.secondary),
              SizedBox(width: 8),
              Expanded(child: Text("Next Medication", style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold))),
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
                Text(med.medicineName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(med.instructions, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant)),
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
            children: const [
              Icon(Icons.emergency_share, color: AppColors.error),
              SizedBox(width: 8),
              Expanded(child: Text("EMERGENCY", style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold, letterSpacing: 1))),
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
              child: const Text("HELP NOW", style: TextStyle(fontWeight: FontWeight.bold)),
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
              const Text("Memora AI", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            ],
          ),
          const SizedBox(height: 16),
          Text(aiPrompt.message, style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: AppColors.onSurfaceVariant, height: 1.5)),
          const SizedBox(height: 24),
          const Divider(color: AppColors.surfaceContainerHighest, thickness: 2),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: aiPrompt.suggestions.map((suggestion) => _buildSuggestionPill(suggestion)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(text, style: const TextStyle(color: AppColors.primary, fontSize: 12)),
    );
  }
}
