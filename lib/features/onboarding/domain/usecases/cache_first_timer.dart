import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/onboarding_repository.dart';

class CacheFirstTimer implements UseCase<void, NoParams> {
  final OnboardingRepository repository;

  CacheFirstTimer(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.cacheFirstTimer();
  }
}
