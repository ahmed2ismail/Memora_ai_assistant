import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class CheckingIfFirstTimer extends OnboardingState {}

class OnboardingStatusChecked extends OnboardingState {
  final bool isFirstTimer;
  const OnboardingStatusChecked({required this.isFirstTimer});

  @override
  List<Object> get props => [isFirstTimer];
}

class OnboardingCaching extends OnboardingState {}

class OnboardingCacheSuccess extends OnboardingState {}

class OnboardingError extends OnboardingState {
  final String message;
  const OnboardingError({required this.message});

  @override
  List<Object> get props => [message];
}
