import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_data_source.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> cacheFirstTimer() async {
    try {
      await localDataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException {
      return const Left(CacheFailure(message: 'Failed to cache onboarding status'));
    } catch (e) {
      return const Left(CacheFailure(message: 'Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkIfUserIsFirstTimer() async {
    try {
      final result = await localDataSource.checkIfUserIsFirstTimer();
      return Right(result);
    } on CacheException {
      return const Left(CacheFailure(message: 'Failed to fetch onboarding status'));
    } catch (e) {
      return const Left(CacheFailure(message: 'Unexpected error occurred'));
    }
  }
}
