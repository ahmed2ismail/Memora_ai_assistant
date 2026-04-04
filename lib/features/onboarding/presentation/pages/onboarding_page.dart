import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../di/injection_container.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';
import '../widgets/welcome_section.dart';
import '../widgets/smart_reminders_section.dart';
import '../widgets/personalized_feature_section.dart';
import '../widgets/profile_selection_section.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OnboardingCubit>()..checkIfUserIsFirstTime(),
      child: const OnboardingView(),
    );
  }
}

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingCacheSuccess || 
             (state is OnboardingStatusChecked && !state.isFirstTimer)) {
            context.go('/home');
          }
        },
        builder: (context, state) {
          if (state is CheckingIfFirstTimer) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              // Background Accents
              Positioned(
                top: -100, right: -100,
                child: Container(
                  width: 300, height: 300,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  transform: Matrix4.translationValues(0, 0, 0)..scale(2.0),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.0),
                      child: Text(
                        "Memora",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF4EDEA3),
                        ),
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          WelcomeSection(onNext: _nextPage),
                          SmartRemindersSection(onNext: _nextPage),
                          PersonalizedFeatureSection(onNext: _nextPage),
                          ProfileSelectionSection(
                            onProfileSelected: () {
                              context.read<OnboardingCubit>().cacheFirstTimerStatus();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
