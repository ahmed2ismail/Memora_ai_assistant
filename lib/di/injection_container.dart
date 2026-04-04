import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/onboarding/data/datasources/onboarding_local_data_source.dart';
import '../features/onboarding/data/repositories/onboarding_repository_impl.dart';
import '../features/onboarding/domain/repositories/onboarding_repository.dart';
import '../features/onboarding/domain/usecases/cache_first_timer.dart';
import '../features/onboarding/domain/usecases/check_if_user_is_first_timer.dart';
import '../features/onboarding/presentation/cubit/onboarding_cubit.dart';
import '../features/home/presentation/cubit/general_dashboard_cubit.dart';

import '../features/home/presentation/cubit/student_dashboard_cubit.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  // Features - Onboarding
  sl.registerFactory(() => OnboardingCubit(
        cacheFirstTimer: sl(),
        checkIfUserIsFirstTimer: sl(),
      ));

  sl.registerFactory(() => GeneralDashboardCubit());
  sl.registerFactory(() => StudentDashboardCubit());

  sl.registerLazySingleton(() => CacheFirstTimer(sl()));
  sl.registerLazySingleton(() => CheckIfUserIsFirstTimer(sl()));

  sl.registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepositoryImpl(localDataSource: sl()));

  sl.registerLazySingleton<OnboardingLocalDataSource>(
      () => OnboardingLocalDataSourceImpl(prefs: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
