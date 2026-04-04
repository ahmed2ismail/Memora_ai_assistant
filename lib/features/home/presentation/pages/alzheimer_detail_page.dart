import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/alzheimer/detail/alzheimer_detail_cubit.dart';
import '../cubit/alzheimer/detail/alzheimer_detail_state.dart';
import '../widgets/alzheimer/alzheimer_detail_hero.dart';
import '../widgets/alzheimer/alzheimer_medication_detail_card.dart';
import '../widgets/alzheimer/alzheimer_safe_zone_map.dart';

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
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<AlzheimerDetailCubit, AlzheimerDetailState>(
        builder: (context, state) {
          if (state is AlzheimerDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlzheimerDetailLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                children: [
                  AlzheimerDetailHero(identityData: state.identityData),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AlzheimerMedicationDetailCard(medicines: state.medicines),
                        const SizedBox(height: 24),
                        const AlzheimerSafeZoneMap(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
