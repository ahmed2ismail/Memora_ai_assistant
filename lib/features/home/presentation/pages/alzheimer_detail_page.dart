import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../di/injection_container.dart';
import '../../domain/entities/alzheimer_models.dart';
import '../cubit/alzheimer_detail_cubit.dart';
import '../cubit/alzheimer_detail_state.dart';

class AlzheimerDetailPage extends StatelessWidget {
  final String id;
  const AlzheimerDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AlzheimerDetailCubit>()..loadDetails(id),
      child: const AlzheimerDetailView(),
    );
  }
}

class AlzheimerDetailView extends StatelessWidget {
  const AlzheimerDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // transparent for shell
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary, size: 32),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100, bottom: 120, left: 24, right: 24),
        child: BlocBuilder<AlzheimerDetailCubit, AlzheimerDetailState>(
          builder: (context, state) {
            if (state is AlzheimerDetailLoading) {
              return const SizedBox(
                height: 500,
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (state is AlzheimerDetailLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeroIdentity(context, state.identityData),
                  const SizedBox(height: 32),
                  _buildMedicationsColumn(context, state.medicines),
                  const SizedBox(height: 32),
                  _buildSafeZoneMap(context, state.safeZoneData),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildHeroIdentity(BuildContext context, IdentityRecognitionData data) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeLayout = constraints.maxWidth > 768;
        final identityCard = GlassCard(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    const Text("FACE RECOGNITION ACTIVE", style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(text: "Who is ", style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: AppColors.onSurface, fontFamily: 'Plus Jakarta Sans')),
                    TextSpan(text: "Visiting?", style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: AppColors.secondary, fontFamily: 'Plus Jakarta Sans')),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(data.instruction, style: const TextStyle(fontSize: 20, color: AppColors.onSurfaceVariant)),
              const SizedBox(height: 32),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                  color: AppColors.surfaceContainerLowest,
                  image: DecorationImage(image: NetworkImage(data.imagePath), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.4), BlendMode.darken)),
                ),
                child: Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.5), width: 2, style: BorderStyle.solid), // Dashed mapping
                    ),
                    child: Icon(Icons.face, size: 64, color: AppColors.primary.withValues(alpha: 0.4)),
                  ),
                ),
              )
            ],
          ),
        );

        final voiceAndHelp = Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: const LinearGradient(colors: [AppColors.primary, Color(0xFF00A471)]),
                  boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 30, offset: const Offset(0, 10))],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.mic, size: 64, color: AppColors.onPrimary),
                    SizedBox(height: 16),
                    Text("\"Ask Me Anything\"", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.onPrimary)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.errorContainer, // Deep red
                borderRadius: BorderRadius.circular(32),
                boxShadow: [BoxShadow(color: AppColors.errorContainer.withValues(alpha: 0.2), blurRadius: 20, offset: const Offset(0, 10))],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.emergency, size: 48, color: AppColors.error),
                  SizedBox(width: 16),
                  Text("HELP", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.error, letterSpacing: 5)),
                ],
              ),
            )
          ],
        );

        if (isLargeLayout) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 6, child: identityCard),
              const SizedBox(width: 24),
              Expanded(flex: 4, child: voiceAndHelp),
            ],
          );
        } else {
          return Column(
            children: [
              identityCard,
              const SizedBox(height: 24),
              SizedBox(height: 350, child: voiceAndHelp),
            ],
          );
        }
      },
    );
  }

  Widget _buildMedicationsColumn(BuildContext context, List<DetailMedicineItem> medicines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.medication, size: 32, color: AppColors.secondary),
            SizedBox(width: 12),
            Text("Today's Medicines", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 24),
        ...medicines.map((med) => _buildMedicationCard(med)),
      ],
    );
  }

  Widget _buildMedicationCard(DetailMedicineItem med) {
    final bool isDone = med.isTaken;
    final Color stripColor = isDone ? AppColors.primary : AppColors.secondary;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(24),
        border: Border(left: BorderSide(color: stripColor, width: 8)),
      ),
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: isDone ? AppColors.primaryContainer : AppColors.secondary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(med.type == 'pill' ? Icons.medication : Icons.water_drop, size: 36, color: stripColor),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(med.timeLabel, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDone ? AppColors.onSurfaceVariant : AppColors.secondary)),
                const SizedBox(height: 4),
                Text(med.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
                const SizedBox(height: 4),
                Text(med.dosageDescription, style: const TextStyle(fontSize: 18, color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          if (isDone)
            const Icon(Icons.check_circle, size: 48, color: AppColors.primary)
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(16)),
              child: const Text("Take Now", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.surfaceDim)),
            )
        ],
      ),
    );
  }

  Widget _buildSafeZoneMap(BuildContext context, SafeZoneData mapData) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.location_on, size: 28, color: AppColors.primary),
                    SizedBox(width: 12),
                    Text("You are Safe", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                Text("You are currently at ${mapData.locationName}.", style: const TextStyle(fontSize: 18, color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(mapData.mapImagePath), fit: BoxFit.cover, colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.darken)),
            ),
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.4), width: 4),
                ),
                child: Center(
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: AppColors.primary, blurRadius: 20)],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(color: AppColors.surfaceContainerHighest.withValues(alpha: 0.5)),
                child: const Center(
                  child: Text("Call Caretaker", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
