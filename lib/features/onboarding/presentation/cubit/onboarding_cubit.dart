import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/cache_first_timer.dart';
import '../../domain/usecases/check_if_user_is_first_timer.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final CacheFirstTimer cacheFirstTimer;
  final CheckIfUserIsFirstTimer checkIfUserIsFirstTimer;

  OnboardingCubit({
    required this.cacheFirstTimer,
    required this.checkIfUserIsFirstTimer,
  }) : super(OnboardingInitial());

  Future<void> cacheFirstTimerStatus() async {
    emit(OnboardingCaching());
    final result = await cacheFirstTimer(NoParams());
    result.fold(
      (failure) => emit(OnboardingError(message: failure.message)),
      (_) => emit(OnboardingCacheSuccess()),
    );
  }

  Future<void> checkIfUserIsFirstTime() async {
    emit(CheckingIfFirstTimer());
    final result = await checkIfUserIsFirstTimer(NoParams());
    result.fold(
      (failure) => emit(const OnboardingStatusChecked(isFirstTimer: true)), // Default on error
      (isFirstTimer) => emit(OnboardingStatusChecked(isFirstTimer: isFirstTimer)),
    );
  }
}
