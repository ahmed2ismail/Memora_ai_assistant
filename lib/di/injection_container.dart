import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../features/onboarding/data/datasources/onboarding_local_data_source.dart';
import '../features/onboarding/data/repositories/onboarding_repository_impl.dart';
import '../features/onboarding/domain/repositories/onboarding_repository.dart';
import '../features/onboarding/domain/usecases/cache_first_timer.dart';
import '../features/onboarding/domain/usecases/check_if_user_is_first_timer.dart';
import '../features/onboarding/presentation/cubit/onboarding_cubit.dart';

import '../features/home/presentation/cubit/general/dashboard/general_dashboard_cubit.dart';
import '../features/home/presentation/cubit/general/detail/general_detail_cubit.dart';
import '../features/home/presentation/cubit/student/dashboard/student_dashboard_cubit.dart';
import '../features/home/presentation/cubit/student/detail/student_detail_cubit.dart';
import '../features/home/presentation/cubit/alzheimer/dashboard/alzheimer_dashboard_cubit.dart';
import '../features/home/presentation/cubit/alzheimer/detail/alzheimer_detail_cubit.dart';

import '../features/ai_assistant/data/datasources/gemini_remote_datasource.dart';
import '../features/ai_assistant/data/repositories/ai_repository_impl.dart';
import '../features/ai_assistant/domain/repositories/ai_repository.dart';
import '../features/ai_assistant/domain/usecases/send_message_usecase.dart';
import '../features/ai_assistant/presentation/cubit/ai_assistant_cubit.dart';
import '../features/settings/presentation/cubit/settings_cubit.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  // ===================================================================
  // Features - Onboarding
  // ===================================================================
  sl.registerFactory(() => OnboardingCubit(
        cacheFirstTimer: sl(),
        checkIfUserIsFirstTimer: sl(),
      ));

  sl.registerLazySingleton(() => CacheFirstTimer(sl()));
  sl.registerLazySingleton(() => CheckIfUserIsFirstTimer(sl()));

  sl.registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepositoryImpl(localDataSource: sl()));

  sl.registerLazySingleton<OnboardingLocalDataSource>(
      () => OnboardingLocalDataSourceImpl(prefs: sl()));

  // ===================================================================
  // Features - Home Dashboards
  // ===================================================================
  sl.registerFactory(() => GeneralDashboardCubit());
  sl.registerFactory(() => GeneralDetailCubit());
  sl.registerFactory(() => StudentDashboardCubit());
  sl.registerFactory(() => StudentDetailCubit());
  sl.registerFactory(() => AlzheimerDashboardCubit());
  sl.registerFactory(() => AlzheimerDetailCubit());

  // ===================================================================
  // Features - Settings & Pricing
  // ===================================================================
  sl.registerFactory(() => SettingsCubit());

  // ===================================================================
  // Features - AI Assistant (Gemini Integration)
  // ===================================================================

  // 1. Core Gemini Model (Singleton — reused across chat sessions)
  final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

  final geminiModel = GenerativeModel(
    model: 'gemini-2.0-flash',
    apiKey: apiKey,
    systemInstruction: Content.system(
      'You are Memora, an empathetic and intelligent AI memory assistant. '
      'You help users manage their daily tasks, habits, medications, and schedules. '
      'You speak in a warm, concise, and proactive tone. '
      'When the user shares something to remember, acknowledge it and suggest a smart reminder strategy. '
      'You have access to the user\'s dashboard context which will be provided in follow-up messages. '
      'Always reference specific items from their dashboard when relevant. '
      'Keep responses under 3 sentences unless the user asks for detail.',
    ),
  );

  sl.registerLazySingleton<GenerativeModel>(() => geminiModel);

  // 2. Data Source
  sl.registerLazySingleton<GeminiRemoteDataSource>(
    () => GeminiRemoteDataSource(model: sl<GenerativeModel>()),
  );

  // 3. Repository
  sl.registerLazySingleton<AiRepository>(
    () => AiRepositoryImpl(remoteDataSource: sl<GeminiRemoteDataSource>()),
  );

  // 4. Use Case
  sl.registerLazySingleton(() => SendMessageUseCase(sl<AiRepository>()));

  // 5. Cubit (Factory — new instance per screen)
  sl.registerFactory(() => AiAssistantCubit(
        sendMessageUseCase: sl<SendMessageUseCase>(),
      ));

  // ===================================================================
  // External
  // ===================================================================
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
